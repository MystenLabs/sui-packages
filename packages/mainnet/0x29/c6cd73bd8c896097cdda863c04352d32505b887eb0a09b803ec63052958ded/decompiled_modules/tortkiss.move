module 0x29c6cd73bd8c896097cdda863c04352d32505b887eb0a09b803ec63052958ded::tortkiss {
    struct TORTKISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORTKISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORTKISS>(arg0, 6, b"TORTKISS", b"Tort Kiss", b"Kisss a tort ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2063_fe243ec323.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORTKISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORTKISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

