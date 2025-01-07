module 0x27ca097afc9da7babb2d16ce23954b3706e127d76fb3b0329fcc3a76e0c82226::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 9, b"HI", b"Luanmeme", b"Hah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8e53b40-7868-47c7-bbc2-512ea2b1dfba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HI>>(v1);
    }

    // decompiled from Move bytecode v6
}

