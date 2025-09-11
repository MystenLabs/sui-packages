module 0xc9b36159f6b78994294da8d959fbbac1dddc6f88fea9f1d50ae17ee586d3aed::privatecoin {
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
        mint(v3, 75905625000000000, @0xf45000e902bc07b4a87b54b0c05dfb31b5d22b12ae255f6310fae2d9fd1d5db3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATECOIN>>(v2, @0xf45000e902bc07b4a87b54b0c05dfb31b5d22b12ae255f6310fae2d9fd1d5db3);
    }

    // decompiled from Move bytecode v6
}

