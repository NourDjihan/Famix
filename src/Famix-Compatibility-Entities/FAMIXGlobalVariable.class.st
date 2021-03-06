Class {
	#name : #FAMIXGlobalVariable,
	#superclass : #FAMIXStructuralEntity,
	#traits : 'FamixTDefinedInModule + FamixTGlobalVariable',
	#classTraits : 'FamixTDefinedInModule classTrait + FamixTGlobalVariable classTrait',
	#category : #'Famix-Compatibility-Entities-Entities'
}

{ #category : #meta }
FAMIXGlobalVariable class >> annotation [

	<FMClass: #GlobalVariable super: #FAMIXStructuralEntity>
	<package: #FAMIX>
	<generated>
	^self
]

{ #category : #'Famix-Extensions' }
FAMIXGlobalVariable >> isPrivate [
	^ self isPublic not
]

{ #category : #'Famix-Extensions' }
FAMIXGlobalVariable >> isPublic [
	"checker whether I am called outside the module in which I am defined"
	^ self incomingAccesses anySatisfy: [:inv |
			inv accessor parentScope ~~ self parentScope]
]

{ #category : #'Famix-Implementation' }
FAMIXGlobalVariable >> printOn: aStream [ 
	| parent |
	parent := self belongsTo.
	parent ifNotNil:
		[ aStream nextPutAll: parent name.
		aStream nextPut: $. ].
	self name ifNotNil: [ aStream nextPutAll: self name ].
	aStream nextPutAll: ' (Global Variable)'
]
