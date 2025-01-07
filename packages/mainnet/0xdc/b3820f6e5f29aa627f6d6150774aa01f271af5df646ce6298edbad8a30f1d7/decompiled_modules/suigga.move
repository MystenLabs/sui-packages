module 0xdcb3820f6e5f29aa627f6d6150774aa01f271af5df646ce6298edbad8a30f1d7::suigga {
    struct SUIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGA>(arg0, 6, b"SUIGGA", b"Suigga", x"636f6c646573742073756967676120627265617468696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suigga_25c50fa79b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

