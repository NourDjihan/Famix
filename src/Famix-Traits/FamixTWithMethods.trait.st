Trait {
	#name : #FamixTWithMethods,
	#instVars : [
		'#methods => FMMany type: #FamixTMethod opposite: #parentType'
	],
	#category : #'Famix-Traits-Behavioral'
}

{ #category : #meta }
FamixTWithMethods classSide >> annotation [

	<FMClass: #TWithMethods super: #Object>
	<package: #'Famix-Traits'>
	<generated>
	^self
]

{ #category : #accessing }
FamixTWithMethods >> addMethod: aMethod [
	methods add: aMethod
]

{ #category : #accessing }
FamixTWithMethods >> methods [
	"Relation named: #methods type: #FamixTMethod opposite: #parentType"

	<generated>
	<FMComment: 'Methods declared by this type.'>
	<derived>
	^ methods
]

{ #category : #accessing }
FamixTWithMethods >> methods: anObject [

	<generated>
	methods value: anObject
]

{ #category : #accessing }
FamixTWithMethods >> methodsGroup [
	<navigation: 'Methods'>
	^MooseGroup
		withAll: self methods
		withDescription: 'Methods from ' , self mooseName
]

{ #category : #metrics }
FamixTWithMethods >> numberOfAbstractMethods [
	<FMProperty: #numberOfAbstractMethods type: #Number>
	<derived>
	<FMComment: 'The number of abstract methods in the class'>
	^ self lookUpPropertyNamed: #numberOfAbstractMethods computedAs: [ self methodsGroup count: [ :each | each isAbstract ] ]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfAbstractMethods: aNumber [
	self cacheAt: #numberOfAbstractMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> numberOfConstructorMethods [
	<FMProperty: #numberOfConstructorMethods type: #Number>
	<derived>
	<FMComment: 'The number of constructor methods in a class'>
	^ self
		lookUpPropertyNamed: #numberOfConstructorMethods
		computedAs: [ 
			| nc |
			nc := 0.
			self methods
				do: [ :method | 
					method isConstructor
						ifNotNil: [ 
							method isConstructor
								ifTrue: [ nc := 1 ] ] ].
			nc ]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfConstructorMethods: aNumber [
	self cacheAt: #numberOfConstructorMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> numberOfMessageSends [
	<FMProperty: #numberOfMessageSends type: #Number>
	<derived>
	<FMComment: 'The number of message sends from a class'>
	
	^self
		lookUpPropertyNamed: #numberOfMessageSends
		computedAs: [self methodsGroup sumNumbers: #numberOfMessageSends]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfMessageSends: aNumber [
	self cacheAt: #numberOfMessageSends put: aNumber
]

{ #category : #accessing }
FamixTWithMethods >> numberOfMethods [
	<FMProperty: #numberOfMethods type: #Number>
	<derived>
	<FMComment: 'The number of methods in a class'>

	^self
		lookUpPropertyNamed: #numberOfMethods
		computedAs: [self methods size]
]

{ #category : #accessing }
FamixTWithMethods >> numberOfMethods: aNumber [
	self cacheAt: #numberOfMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> numberOfPrivateMethods [
	<FMProperty: #numberOfPrivateMethods type: #Number>
	<derived>
	<FMComment: 'The number of private methods in a class'>
			
	^self
		lookUpPropertyNamed: #numberOfPrivateMethods
		computedAs: [(self methods select: [:each | each isPrivate]) size]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfPrivateMethods: aNumber [
	self cacheAt: #numberOfPrivateMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> numberOfProtectedMethods [
	<FMProperty: #numberOfProtectedMethods type: #Number>
	<derived>
	<FMComment: 'The number of protected methods in a class'>		
	
	^self
		lookUpPropertyNamed: #numberOfProtectedMethods
		computedAs: [(self methods select: [:each | each isProtected]) size]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfProtectedMethods: aNumber [
	self cacheAt: #numberOfProtectedMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> numberOfPublicMethods [
	<FMProperty: #numberOfPublicMethods type: #Number>
	<derived>
	<FMComment: 'The number of public methods in a class'>		
		
	^self
		lookUpPropertyNamed: #numberOfPublicMethods
		computedAs: [(self methods select: [:each | each isPublic]) size]
]

{ #category : #metrics }
FamixTWithMethods >> numberOfPublicMethods: aNumber [
	self cacheAt: #numberOfPublicMethods put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> tightClassCohesion [
	<FMProperty: #tightClassCohesion type: #Number>
	<derived>
	<FMComment: 'Tight class cohesion of a class'>
	self flag: #TODO.
	^ self
		lookUpPropertyNamed: #tightClassCohesion
		computedAs: [ | tcc accessDictionary nom |
			tcc := 0.
			accessDictionary := Dictionary new.
			self methods
				do: [ :eachMethod | 
					eachMethod accesses
						do: [ :eachAccess | 
							| var |
							var := eachAccess variable.
							var isAttribute
								ifTrue: [ | varName accessedFrom |
									varName := var name.
									accessedFrom := accessDictionary at: varName ifAbsent: [  ].
									accessedFrom
										ifNil: [ accessedFrom := Set new.
											accessDictionary at: varName put: accessedFrom ].
									accessedFrom add: eachMethod name ] ] ].
			accessDictionary values
				do: [ :each | 
					| size |
					size := each size.
					tcc := tcc + (size * (size - 1) / 2) ].
			nom := self numberOfMethods.
			tcc := (nom = 0 or: [ nom = 1 ]) ifFalse: [ tcc / (nom * (nom - 1) / 2) ] ifTrue: [ 0 ].
			tcc asFloat ]
]

{ #category : #metrics }
FamixTWithMethods >> tightClassCohesion: aNumber [
	self cacheAt: #tightClassCohesion put: aNumber
]

{ #category : #metrics }
FamixTWithMethods >> weightedMethodCount [
	<FMProperty: #weightedMethodCount type: #Number>
	<derived>
	<FMComment: 'The sum of the complexity in a class'>
			
	^self
		lookUpPropertyNamed: #weightedMethodCount
		computedAs: [self methodsGroup sumNumbers: #cyclomaticComplexity]
]

{ #category : #metrics }
FamixTWithMethods >> weightedMethodCount: aNumber [
	self cacheAt: #weightedMethodCount put: aNumber
]
