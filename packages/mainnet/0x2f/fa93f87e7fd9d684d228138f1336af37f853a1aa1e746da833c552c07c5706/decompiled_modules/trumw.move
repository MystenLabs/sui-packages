module 0x2ffa93f87e7fd9d684d228138f1336af37f853a1aa1e746da833c552c07c5706::trumw {
    struct TRUMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMW>(arg0, 9, b"TRUMW", b"TrumpWin", b"TrumpWin is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49ee7542-40c1-4856-b380-f86635d11bf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

