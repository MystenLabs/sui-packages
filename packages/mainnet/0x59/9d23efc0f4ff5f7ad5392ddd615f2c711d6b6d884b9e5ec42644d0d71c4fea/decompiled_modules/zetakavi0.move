module 0x599d23efc0f4ff5f7ad5392ddd615f2c711d6b6d884b9e5ec42644d0d71c4fea::zetakavi0 {
    struct ZETAKAVI0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZETAKAVI0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZETAKAVI0>(arg0, 9, b"ZETAKAVI0", b"Zeta-07", b"Zeta kavi description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0188946-67e7-4904-8512-8057e0b20527.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZETAKAVI0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZETAKAVI0>>(v1);
    }

    // decompiled from Move bytecode v6
}

