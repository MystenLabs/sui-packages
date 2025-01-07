module 0xf3e5cfe13d574a94eea571a7ec8146d32d6eb464153a0264e6d6e638bb80475b::btusk {
    struct BTUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTUSK>(arg0, 6, b"BTusk", b"Baby Tusk", b"Baby Walrus come to eat the fish ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaa_b4e254f67d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

