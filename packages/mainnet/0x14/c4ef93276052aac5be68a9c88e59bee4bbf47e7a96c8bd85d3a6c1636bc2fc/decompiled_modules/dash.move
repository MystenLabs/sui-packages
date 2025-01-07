module 0x14c4ef93276052aac5be68a9c88e59bee4bbf47e7a96c8bd85d3a6c1636bc2fc::dash {
    struct DASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASH>(arg0, 9, b"DASH", b"DasWealth", b"Daswealth's fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1af6ff8a-a244-453c-b7d4-a46772dec547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

