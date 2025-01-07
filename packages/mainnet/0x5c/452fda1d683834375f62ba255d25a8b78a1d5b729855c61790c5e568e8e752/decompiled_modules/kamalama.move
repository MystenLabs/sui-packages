module 0x5c452fda1d683834375f62ba255d25a8b78a1d5b729855c61790c5e568e8e752::kamalama {
    struct KAMALAMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAMALAMA>, arg1: 0x2::coin::Coin<KAMALAMA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAMALAMA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAMALAMA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KAMALAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALAMA>(arg0, 6, b"KAMALAMA", b"KAMLA", x"4d616b6520416d6572696361205365787920416761696e20244b414d4c4120546869732069736ee2809974206a7573742061206368616c6c656e67653b206974e280997320616e207570726973696e6721205765e280997265206465636c6172696e672061206d656d652077617220616761696e737420746865204d41474120636f696e2120496e74726f647563696e673a204b414d414c414d41212068747470733a2f2f7777772e6b616d616c616d612e6f72672f202068747470733a2f2f782e636f6d2f6b616d6c615f6b616d616c616d61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmdjMdVHJzwg36JAA16vcfKej2mLoeMmrbauvQH8VMT9pG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMALAMA>, arg1: 0x2::coin::Coin<KAMALAMA>) : u64 {
        0x2::coin::burn<KAMALAMA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMALAMA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KAMALAMA> {
        0x2::coin::mint<KAMALAMA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

