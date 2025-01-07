module 0xaa24d7e740199b65d26750c99bedb53eb2154022815b7bb4d9286f3d898ee724::gmc {
    struct GMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMC>(arg0, 9, b"GMC", b"GRUMPY CAT", b"A Famous meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13875393-938f-44f5-a78a-0513d6eda9d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

