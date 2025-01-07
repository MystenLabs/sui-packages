module 0xaf826673477d69719dca2538af18090974b7ce50f7124350d74edccb0ace8642::udud {
    struct UDUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDUD>(arg0, 9, b"UDUD", b"UdudOnSui", b"This udud on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21e09715-f5a2-41e8-8c90-436cfa8ce9d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

