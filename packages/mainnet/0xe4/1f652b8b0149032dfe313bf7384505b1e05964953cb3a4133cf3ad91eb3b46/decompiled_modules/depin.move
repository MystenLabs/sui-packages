module 0xe41f652b8b0149032dfe313bf7384505b1e05964953cb3a4133cf3ad91eb3b46::depin {
    struct DEPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPIN>(arg0, 9, b"DEPIN", b"Depin", b"Trend Depin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4134f577-0085-4a8d-b2b5-b84e28d8c177.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

