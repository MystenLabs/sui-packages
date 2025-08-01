module 0x5fb78c84fd091648583d4083a1bc3df18aebb0245a76931f8e0d03fea7bc2b42::PKG {
    struct PKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKG>(arg0, 6, b"PACKAGE", b"PKG", b"delivery guy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/44caf3ca-d2b1-41b7-963b-ac9f7f7e4dde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKG>>(v0, @0x377af12632b732c34a7985e3ede6108e0f68d1698c6cc25df923efb6608da8af);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

