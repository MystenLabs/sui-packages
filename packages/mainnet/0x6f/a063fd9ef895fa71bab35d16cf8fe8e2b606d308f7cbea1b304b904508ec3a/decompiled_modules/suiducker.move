module 0x6fa063fd9ef895fa71bab35d16cf8fe8e2b606d308f7cbea1b304b904508ec3a::suiducker {
    struct SUIDUCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCKER>(arg0, 6, b"SuiDucker", b"Ducker", b"A duck preparing to take off in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_24_04_22_40_959be7f8c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

