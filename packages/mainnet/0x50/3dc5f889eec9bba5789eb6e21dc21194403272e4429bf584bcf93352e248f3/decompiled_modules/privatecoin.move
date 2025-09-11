module 0x503dc5f889eec9bba5789eb6e21dc21194403272e4429bf584bcf93352e248f3::privatecoin {
    struct PRIVATECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: 0x2::coin::Coin<PRIVATECOIN>) {
        0x2::coin::burn<PRIVATECOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATECOIN>>(0x2::coin::mint<PRIVATECOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIVATECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATECOIN>(arg0, 9, b"USDC ", b"Tatr USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmegTguLKv9FgfzPaX6NRYAwGUCY3WHuh8McvPaDEV1NZQ")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIVATECOIN>>(v1);
        let v3 = &mut v2;
        mint(v3, 75905627000000000, @0x56bef7791787e51c218aca319eae4bce5f59d0f46526552ed446ef6d08b8ae49, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v2, @0x56bef7791787e51c218aca319eae4bce5f59d0f46526552ed446ef6d08b8ae49);
    }

    // decompiled from Move bytecode v6
}

