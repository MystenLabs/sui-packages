module 0xa73414b5670e54e2b9a29e0007ca1a8d1a0fa302e0473571a5fb6eaa6aec2847::bn {
    struct BN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BN>(arg0, 9, b"BN", b"BNB", b"Binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7da413b-2ac3-44e8-b53a-1d711c7000f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BN>>(v1);
    }

    // decompiled from Move bytecode v6
}

