module 0x66fda9451c4b9af84f06e35a16f67aae73e6224dd7ef0173d7b780aef8d30389::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 9, b"SPY", b"SPICYSURF ", b"Always Reliable ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81dbbb9a-b410-40e8-b1a2-a6c6c9f6d2df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

