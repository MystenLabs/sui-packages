module 0xabbd71b13820d9f1c8878a4a2995b0cd14672512cea4ef3b716b439831bda38d::ync {
    struct YNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YNC>(arg0, 9, b"YNC", b"Younochi", b"YOUNOCHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4377c315-94cd-4d3f-828b-1760fb3ac526.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

