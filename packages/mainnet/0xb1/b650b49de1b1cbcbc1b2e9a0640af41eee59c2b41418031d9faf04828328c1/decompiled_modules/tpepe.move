module 0xb1b650b49de1b1cbcbc1b2e9a0640af41eee59c2b41418031d9faf04828328c1::tpepe {
    struct TPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEPE>(arg0, 9, b"TPEPE", b"Turbo Pepe", b"Inspired by the combination of turbo and pepe which is already world famous and very famous. save and we will be very big.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da6a4750-c7cb-4128-aaf7-e3cb296ba0ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

