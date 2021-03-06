Class {
	#name : #LANMooseModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Moose-SmalltalkImporter-LAN-Tests'
}

{ #category : #util }
LANMooseModelTest >> model [
	" to debug and avoid caching behavior: LANPackageTestResource reset."
	^ LANPackageTestResource current model 

]

{ #category : #running }
LANMooseModelTest >> setUp [
	super setUp.
	model := MooseModel new.
]

{ #category : #tests }
LANMooseModelTest >> testIncludeElementOfType [
	self assert: (self model includesElementsOfType: FamixStClass).
	self deny: (self model includesElementsOfType: SmallInteger)
]
