module 0x553024889b45d3d88e9fac2fecfd9d1630cb7d45676f4b45b820c872ff77e8a6::popfish {
    struct POPFISH has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPFISH>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POPFISH>>(0x2::coin::mint<POPFISH>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: POPFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPFISH>(arg0, 9, b"POPFISH", b"POPFISH", b"POPFISH a popping fish out of the water like Sui pops every time upcoming mascot of the blockchain, hardcore community no pre-sale no airdrops.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840399923403001856/58xFUfOA_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPFISH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPFISH>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

