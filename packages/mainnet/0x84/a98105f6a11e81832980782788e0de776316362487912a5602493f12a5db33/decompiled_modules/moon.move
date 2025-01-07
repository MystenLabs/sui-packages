module 0x84a98105f6a11e81832980782788e0de776316362487912a5602493f12a5db33::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"Moon", b"SuiMoon", b"The rock controls our destiny and our destiny is the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7136_5033061eab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

