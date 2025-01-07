module 0xcb32f83bc848b31ebd576b06163685fef8a8ed267ab1d17bee0cb1ee2d3bede9::globbo {
    struct GLOBBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBBO>(arg0, 6, b"Globbo", b"GlobboSui", b"Why be normal when you can be Globbo?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_054230721_3f5794d31b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOBBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

