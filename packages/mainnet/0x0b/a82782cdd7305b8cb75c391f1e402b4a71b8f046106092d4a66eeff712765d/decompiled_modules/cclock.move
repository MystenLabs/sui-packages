module 0xba82782cdd7305b8cb75c391f1e402b4a71b8f046106092d4a66eeff712765d::cclock {
    struct CCLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCLOCK>(arg0, 9, b"CCLOCK", b"XuCan", b"Chinese company ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d4d089a-1c04-404f-9829-8bd1fc71e82b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCLOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCLOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

