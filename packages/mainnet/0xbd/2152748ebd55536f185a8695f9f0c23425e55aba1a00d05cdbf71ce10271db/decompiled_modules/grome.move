module 0xbd2152748ebd55536f185a8695f9f0c23425e55aba1a00d05cdbf71ce10271db::grome {
    struct GROME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROME>(arg0, 9, b"GROME", b"GROME", b"GROME", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROME>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROME>>(v1);
    }

    // decompiled from Move bytecode v6
}

