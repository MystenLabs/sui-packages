module 0xb5bda77d4dcbea07f8c86c3c2aec376081be4dc31f97e3bd3eb1726bfd9925b0::yly {
    struct YLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YLY>(arg0, 9, b"YLY", b"yly", x"746861747320616c6c20f09f8cbcf09f8cbcf09f8cbcf09f8cbcf09f8cbcf09f8cbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2996266e-edae-4473-b742-60d46ee95927.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

