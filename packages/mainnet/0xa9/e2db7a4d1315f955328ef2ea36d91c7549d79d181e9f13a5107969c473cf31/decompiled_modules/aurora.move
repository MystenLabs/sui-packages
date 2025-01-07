module 0xa9e2db7a4d1315f955328ef2ea36d91c7549d79d181e9f13a5107969c473cf31::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"Aurora", b"Operation Aurora", b"Trumps Operation Aurora", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/june_21st_2023_portrait_donald_260nw_2320981303_ezgif_com_webp_to_jpg_converter_2354a3b35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

