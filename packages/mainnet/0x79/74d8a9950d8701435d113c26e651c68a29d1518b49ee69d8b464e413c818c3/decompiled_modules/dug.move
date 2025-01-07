module 0x7974d8a9950d8701435d113c26e651c68a29d1518b49ee69d8b464e413c818c3::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 9, b"DUG", b"Dugo", b"Dugo is the iconic of the American rapper which is popular to stand out from other meme and become the best meme in wave community with a real life utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab27f059-4f64-46c6-99f8-b60241661bb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

