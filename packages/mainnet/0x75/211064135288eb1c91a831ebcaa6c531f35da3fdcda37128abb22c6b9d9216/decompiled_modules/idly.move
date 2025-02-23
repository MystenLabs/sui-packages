module 0x75211064135288eb1c91a831ebcaa6c531f35da3fdcda37128abb22c6b9d9216::idly {
    struct IDLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDLY>(arg0, 9, b"IDLY", b"IDLY FUND", b"Building an autonomous digital real estate portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cc29f07-3e57-46bf-8a21-efb522928f46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

