module 0xefb3421e35359a9da00a0c1e3e050bdc5efa2debe60e1b60c03a98c88ef52ad2::husab05 {
    struct HUSAB05 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSAB05, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSAB05>(arg0, 9, b"HUSAB05", b"Kanju", b"The purpose is to fine a simplest way of transaction ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/944473a2-8815-4562-95f3-f3a652b9d0d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSAB05>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSAB05>>(v1);
    }

    // decompiled from Move bytecode v6
}

