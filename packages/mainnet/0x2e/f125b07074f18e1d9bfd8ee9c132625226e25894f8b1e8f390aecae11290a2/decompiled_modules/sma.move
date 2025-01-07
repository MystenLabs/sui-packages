module 0x2ef125b07074f18e1d9bfd8ee9c132625226e25894f8b1e8f390aecae11290a2::sma {
    struct SMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMA>(arg0, 9, b"SMA", b"vann samba", b"111111111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/266e94b5-da01-4dc3-9fe3-5450a8c14a8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

