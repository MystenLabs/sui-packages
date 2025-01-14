module 0x522e4a661c068856a4ef3fd5f1baa4cec313f456117668eeb152a8c9bf302b9b::template_coin {
    struct TEMPLATE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE_COIN>(arg0, 6, b"TMPL", b"Template Coin", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

