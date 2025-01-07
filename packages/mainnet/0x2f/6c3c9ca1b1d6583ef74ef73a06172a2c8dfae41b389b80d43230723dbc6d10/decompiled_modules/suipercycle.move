module 0x2f6c3c9ca1b1d6583ef74ef73a06172a2c8dfae41b389b80d43230723dbc6d10::suipercycle {
    struct SUIPERCYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERCYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERCYCLE>(arg0, 6, b"Suipercycle", b"Suipercycle2025", b"SUI IS THE 2025 CHAMPION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OG_11a31fb091.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERCYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERCYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

