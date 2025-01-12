module 0xfd06bad03b5458912ced417e0d79020478a7f1b2756fb0f2490f1a037626a34f::emoti {
    struct EMOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOTI>(arg0, 6, b"EMOTI", b"emoti art", b"AI Emoticon Artist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dex_profile_2_fcb93204ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

