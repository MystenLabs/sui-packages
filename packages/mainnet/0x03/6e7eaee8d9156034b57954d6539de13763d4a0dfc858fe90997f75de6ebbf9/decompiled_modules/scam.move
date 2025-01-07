module 0x36e7eaee8d9156034b57954d6539de13763d4a0dfc858fe90997f75de6ebbf9::scam {
    struct SCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM>(arg0, 9, b"SCAM", b"majorscam", b"SCAMa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bec11883-36fb-49fd-a312-015fc3cf11ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

