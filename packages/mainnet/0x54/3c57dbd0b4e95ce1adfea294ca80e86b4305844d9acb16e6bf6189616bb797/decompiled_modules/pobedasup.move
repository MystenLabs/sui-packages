module 0x543c57dbd0b4e95ce1adfea294ca80e86b4305844d9acb16e6bf6189616bb797::pobedasup {
    struct POBEDASUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POBEDASUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POBEDASUP>(arg0, 9, b"POBEDASUP", b"PobedaN", x"d0bcd0bed0b920d182d0bed0bad0b5d0bd20d0bfd180d0bed0b1d0b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d46f492-a29b-46ce-a4ac-f75fc775d1c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POBEDASUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POBEDASUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

