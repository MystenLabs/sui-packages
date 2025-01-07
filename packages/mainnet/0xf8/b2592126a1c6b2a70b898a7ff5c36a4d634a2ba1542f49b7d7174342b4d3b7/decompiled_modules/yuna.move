module 0xf8b2592126a1c6b2a70b898a7ff5c36a4d634a2ba1542f49b7d7174342b4d3b7::yuna {
    struct YUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNA>(arg0, 6, b"Yuna", b"Yuna The Tapir", x"59756e6120697320707265676e616e7420616e6420657870656374696e672061206c6974746c652077617465726d656c6f6e20746869732066616c6c2f77696e746572210a0a45766572796f6e652074616c6b732061626f7574204d6f6f6e64656e672c20627574206e6f626f64792074616c6b732061626f75742059756e61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yuna_ed689d3f02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

