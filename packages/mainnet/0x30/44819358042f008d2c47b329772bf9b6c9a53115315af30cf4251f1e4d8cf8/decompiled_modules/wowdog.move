module 0x3044819358042f008d2c47b329772bf9b6c9a53115315af30cf4251f1e4d8cf8::wowdog {
    struct WOWDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWDOG>(arg0, 6, b"WOWDOG", b"WOWDOG ON SUI", b"WOWDOG on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOWDOG_969b78b119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

