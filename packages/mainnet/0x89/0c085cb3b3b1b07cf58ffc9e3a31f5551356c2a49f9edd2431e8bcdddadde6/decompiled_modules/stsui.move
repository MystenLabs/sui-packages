module 0x890c085cb3b3b1b07cf58ffc9e3a31f5551356c2a49f9edd2431e8bcdddadde6::stsui {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 6, b"STSUI", b"Satosui", x"416e20656e67696e6565722066726f6d20626c6f636b636861696e0a4d654d652069732074686520667574757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_c30ed8fa0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

