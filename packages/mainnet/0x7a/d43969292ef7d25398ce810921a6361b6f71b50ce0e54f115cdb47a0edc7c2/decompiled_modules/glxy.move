module 0x7ad43969292ef7d25398ce810921a6361b6f71b50ce0e54f115cdb47a0edc7c2::glxy {
    struct GLXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLXY>(arg0, 9, b"GLXY", b"Galaxy", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GLXY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

