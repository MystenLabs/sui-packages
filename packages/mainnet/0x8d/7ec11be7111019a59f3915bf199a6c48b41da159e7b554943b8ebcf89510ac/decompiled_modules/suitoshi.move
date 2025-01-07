module 0x8d7ec11be7111019a59f3915bf199a6c48b41da159e7b554943b8ebcf89510ac::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"Suitoshi", b"Suitoshi Nakamoto", b"Suitoshi Nakamoto, the OG father!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7d5176125262745_611541a5abf73_d621037818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

