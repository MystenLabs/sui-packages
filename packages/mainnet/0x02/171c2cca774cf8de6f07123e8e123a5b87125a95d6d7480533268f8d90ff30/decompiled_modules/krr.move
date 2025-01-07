module 0x2171c2cca774cf8de6f07123e8e123a5b87125a95d6d7480533268f8d90ff30::krr {
    struct KRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRR>(arg0, 9, b"KRR", b"Kuroro", b"Kuroro Beast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0175955-8214-47ee-9e44-45357c93a0b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

