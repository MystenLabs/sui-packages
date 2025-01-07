module 0x197a577e792111c17187d0e94368e218923cb6e3e1195a43ea24c2f75a24e8bf::tj {
    struct TJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJ>(arg0, 9, b"TJ", b"WAVE", b"For funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e598059-b58a-42ee-b21a-e3310b5cfcc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

