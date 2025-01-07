module 0xecd5b467729a5875c8353133593c65b2b8e5494dfd5462e09fc590a142a8fead::lud {
    struct LUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUD>(arg0, 6, b"LUD", b"Ludoman Gollum", b"We are very attracted by the same constant gambling process, wanting to inevitably get rich . I'm just like you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LUD_T_Qz18y_M_Fkyy_Xgj_QW_Ha_33723aeb48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

