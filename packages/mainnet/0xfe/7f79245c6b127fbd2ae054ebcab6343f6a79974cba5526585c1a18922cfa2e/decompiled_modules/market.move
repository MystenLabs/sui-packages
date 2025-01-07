module 0xfe7f79245c6b127fbd2ae054ebcab6343f6a79974cba5526585c1a18922cfa2e::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKET>(arg0, 9, b"MARKET", b"Stonk Man", b"Stonk man is a man who is always optimistic about the rise of the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffb0e7f7-d834-49ca-ab4b-3537e4cb6754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

