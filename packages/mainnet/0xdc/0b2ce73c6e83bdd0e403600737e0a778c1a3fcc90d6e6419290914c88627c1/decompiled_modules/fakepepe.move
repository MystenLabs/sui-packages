module 0xdc0b2ce73c6e83bdd0e403600737e0a778c1a3fcc90d6e6419290914c88627c1::fakepepe {
    struct FAKEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKEPEPE>(arg0, 9, b"FAKEPEPE", b"FAKE PEPE", b"Is this PEPE? Nah haha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7959b0ef-175a-4d62-a3d5-a4abeaba6135.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

