module 0x2b395ff9223ef73624aaf8a42d6bec5b3a73de583dfd49cc8a97b9a24f4a36f0::stsui {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 6, b"STSUI", b"Satosui", x"416e20656e67696e6565722066726f6d20626c6f636b636861696e0a4d654d652069732074686520667574757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_deff091e36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

