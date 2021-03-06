Class {
	#name : #SmalltalkScope,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'parent'
	],
	#category : #'Moose-SmalltalkImporter'
}

{ #category : #'instance creation' }
SmalltalkScope class >> extend: aScope [ 
	 
	^(self new) 
		parent: aScope; 
		yourself
]

{ #category : #accessing }
SmalltalkScope >> at: name bind: object [ 
	^dictionary at: name put: object
]

{ #category : #accessing }
SmalltalkScope >> at: name ifAbsent: aBlock [ 
	^dictionary at: name ifAbsent: aBlock
]

{ #category : #enumerating }
SmalltalkScope >> do: aBlock [ 
	 
	dictionary do: aBlock
]

{ #category : #initialization }
SmalltalkScope >> initialize [ 

	super initialize. 
	dictionary := Dictionary new
]

{ #category : #accessing }
SmalltalkScope >> parent [ 
	 
	^parent
]

{ #category : #accessing }
SmalltalkScope >> parent: anObject [ 
	 
	parent := anObject
]

{ #category : #accessing }
SmalltalkScope >> resolve: name ifAbsent: aBlock [
	^ dictionary
		at: name
		ifAbsent: [ parent
				ifNil: [ aBlock value ]
				ifNotNil: [ parent resolve: name ifAbsent: aBlock ] ]
]

{ #category : #accessing }
SmalltalkScope >> size [ 
	 
	^dictionary size
]

{ #category : #accessing }
SmalltalkScope >> values [ 
	 
	^dictionary values
]
