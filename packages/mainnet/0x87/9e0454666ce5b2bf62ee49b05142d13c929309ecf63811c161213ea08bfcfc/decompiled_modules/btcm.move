module 0x879e0454666ce5b2bf62ee49b05142d13c929309ecf63811c161213ea08bfcfc::btcm {
    struct BTCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCM>(arg0, 9, b"BTCM", b"bitcoinm", b"Bitcoin small ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5de4e5e7-0c8e-402e-95c5-970111ad86d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

