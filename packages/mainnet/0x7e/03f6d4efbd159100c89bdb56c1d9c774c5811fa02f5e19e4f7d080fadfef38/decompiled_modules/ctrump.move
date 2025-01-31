module 0x7e03f6d4efbd159100c89bdb56c1d9c774c5811fa02f5e19e4f7d080fadfef38::ctrump {
    struct CTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRUMP>(arg0, 9, b"CTRUMP", b"C.Trump", b"This is a coin to acknowledge President Trump a True Hero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/721e94c4-5e3e-4ce5-a19d-22939ac007fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

