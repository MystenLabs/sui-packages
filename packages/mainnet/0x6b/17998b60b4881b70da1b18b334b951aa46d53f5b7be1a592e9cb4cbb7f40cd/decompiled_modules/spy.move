module 0x6b17998b60b4881b70da1b18b334b951aa46d53f5b7be1a592e9cb4cbb7f40cd::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 9, b"SPY", b"SPICYSURF ", b"Always Reliable ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a158075-cfb7-4d29-85cc-159d0e84b0ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

