module 0xaa82460923d8ce3d6f3bd67af5e5110df853d339bcb12531b2441caeb844d0bb::advai {
    struct ADVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADVAI>(arg0, 6, b"ADVAI", b"Advisor AI", x"4e657874206c6576656c206f6620696e6e6f766174696f6e20776974682041492d504f57455245442e0a5472616e73666f726d20796f75722063727970746f20706f7274666f6c696f2077697468207265616c2d74696d6520616e616c79746963732c207269736b206173736573736d656e742c20616e6420706572736f6e616c697a6564696e7369676874732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADVAI_01bf81aaf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADVAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADVAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

