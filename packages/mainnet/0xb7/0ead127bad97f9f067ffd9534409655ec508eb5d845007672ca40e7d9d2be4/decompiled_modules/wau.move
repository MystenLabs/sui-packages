module 0xb70ead127bad97f9f067ffd9534409655ec508eb5d845007672ca40e7d9d2be4::wau {
    struct WAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAU>(arg0, 9, b"WAU", b"WAU TOKEN", b"WAU IS SUI THE TOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69f02fdc-9450-469c-a3a7-8bdb6ae3a254.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

