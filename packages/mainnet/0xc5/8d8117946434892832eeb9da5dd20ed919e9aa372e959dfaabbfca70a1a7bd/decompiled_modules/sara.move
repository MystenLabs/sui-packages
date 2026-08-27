module 0xc58d8117946434892832eeb9da5dd20ed919e9aa372e959dfaabbfca70a1a7bd::sara {
    struct SARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARA>(arg0, 9, b"SARA", b"SARA", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/AYHDTyAVcs2b8uG4NPPCAF36-xGlsfscnRLGDcnWFrA")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SARA>>(0x2::coin::mint<SARA>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SARA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SARA>>(v1);
    }

    // decompiled from Move bytecode v7
}

