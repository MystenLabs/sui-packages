module 0x8885e592015ec4c7fd2540f26d785012e55b0d6f251981a766c809e424650be7::pallmovingon {
    struct PALLMOVINGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALLMOVINGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALLMOVINGON>(arg0, 6, b"PALLMOVINGON", b"Pallmovingon", b"PALLMOVINGON is a cheerful cat with a stocky body but a sweet face, can be a helper but can also be an adorable pet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058618_f743a151a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALLMOVINGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PALLMOVINGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

