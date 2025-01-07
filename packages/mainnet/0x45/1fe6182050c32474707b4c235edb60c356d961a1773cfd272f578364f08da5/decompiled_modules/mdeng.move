module 0x451fe6182050c32474707b4c235edb60c356d961a1773cfd272f578364f08da5::mdeng {
    struct MDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDENG>(arg0, 9, b"MDENG", b"Moodeng", b"Moodeng father of all memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4961eb78-fed5-415d-83dc-0ad09e33a45d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

