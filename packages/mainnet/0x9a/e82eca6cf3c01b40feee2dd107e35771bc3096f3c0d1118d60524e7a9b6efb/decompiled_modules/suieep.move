module 0x9ae82eca6cf3c01b40feee2dd107e35771bc3096f3c0d1118d60524e7a9b6efb::suieep {
    struct SUIEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEEP>(arg0, 6, b"SUIEEP", b"SUIEEP on SUI", b"SUIEEPing all the competition on Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0a1e31ae_3811_42ef_a570_55f58da23833_b6cbf8bde9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

