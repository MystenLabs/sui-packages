module 0x15814d05ea65a5288efed6ce96cb0fadb147e5f1f632f4f3deaf1f67d460e508::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 6, b"GOOD", b"Good Times", b"Economics, money and good times! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/good_life_clean_7a5148e838.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

