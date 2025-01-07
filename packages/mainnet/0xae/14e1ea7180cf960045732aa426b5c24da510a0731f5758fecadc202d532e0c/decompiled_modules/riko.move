module 0xae14e1ea7180cf960045732aa426b5c24da510a0731f5758fecadc202d532e0c::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"RIKO SUI", b"When FUN meets Ratels FEARLESS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_3_ba796777e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

