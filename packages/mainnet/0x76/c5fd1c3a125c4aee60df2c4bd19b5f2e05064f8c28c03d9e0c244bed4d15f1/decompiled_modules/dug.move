module 0x76c5fd1c3a125c4aee60df2c4bd19b5f2e05064f8c28c03d9e0c244bed4d15f1::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 9, b"DUG", b"Dugo", b"Dugo is the iconic of the American rapper which is popular to stand out from other meme and become the best meme in wave community with a real life utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a65056c9-4fb6-4553-8b9e-cf5fd4152159.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

