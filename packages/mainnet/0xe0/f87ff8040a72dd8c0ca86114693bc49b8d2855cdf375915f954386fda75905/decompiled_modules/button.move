module 0xe0f87ff8040a72dd8c0ca86114693bc49b8d2855cdf375915f954386fda75905::button {
    struct BUTTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTON>(arg0, 6, b"Button", b"Facebook Button", b"Facebook needs three button. 'Like', 'Dislike', and 'Stop being stupid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/like_3db5b9998f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

