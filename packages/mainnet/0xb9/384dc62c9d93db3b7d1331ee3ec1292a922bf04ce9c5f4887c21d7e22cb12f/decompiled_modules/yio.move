module 0xb9384dc62c9d93db3b7d1331ee3ec1292a922bf04ce9c5f4887c21d7e22cb12f::yio {
    struct YIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YIO>(arg0, 6, b"YIO", b"yio by SuiAI", b"yio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pngtree_world_cup_black_and_white_cartoon_football_banner_border_png_image_14086021_9c09e3ad0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YIO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

