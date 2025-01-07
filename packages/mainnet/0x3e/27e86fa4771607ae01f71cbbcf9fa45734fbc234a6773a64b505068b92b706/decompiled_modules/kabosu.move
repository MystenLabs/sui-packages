module 0x3e27e86fa4771607ae01f71cbbcf9fa45734fbc234a6773a64b505068b92b706::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 9, b"KABOSU", b"KABOSU", x"244b41424f535520205468652066616365206f6620446f67652e20205265737420696e207065616365f09f9295", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmVfx7xLEwnLTYayefcP6a2Y9DgyD1n1Tu1Wog7c3xjdos")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KABOSU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

