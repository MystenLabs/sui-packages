module 0xfb19f019bcd701e67570888efa727154472276faa7cb183098c7a436b6203808::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 9, b"HD", b"Haul Dump", b"HD is used for mining activity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37ac7820-825c-4a56-95a6-a3a0a10eb57f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

