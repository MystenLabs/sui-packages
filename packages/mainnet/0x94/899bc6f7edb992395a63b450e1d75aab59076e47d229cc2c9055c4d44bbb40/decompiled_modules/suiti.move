module 0x94899bc6f7edb992395a63b450e1d75aab59076e47d229cc2c9055c4d44bbb40::suiti {
    struct SUITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITI>(arg0, 6, b"SUITI", b"Yeti", b"Yeti on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yeti_17df220e7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITI>>(v1);
    }

    // decompiled from Move bytecode v6
}

