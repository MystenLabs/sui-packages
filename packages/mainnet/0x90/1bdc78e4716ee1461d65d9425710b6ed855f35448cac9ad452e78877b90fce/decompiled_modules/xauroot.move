module 0x901bdc78e4716ee1461d65d9425710b6ed855f35448cac9ad452e78877b90fce::xauroot {
    struct XAUROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUROOT>(arg0, 6, b"XAUROOT", b"XAU ROOT", b"THE CLUB XAU ROOT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_25_alle_21_18_18_1cf30d59c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAUROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAUROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

