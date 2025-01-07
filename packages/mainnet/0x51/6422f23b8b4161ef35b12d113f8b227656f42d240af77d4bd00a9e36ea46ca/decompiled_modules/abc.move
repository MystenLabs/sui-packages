module 0x516422f23b8b4161ef35b12d113f8b227656f42d240af77d4bd00a9e36ea46ca::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 9, b"ABC", b"Abc meme", b"Tao de lam nvu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ad599dc-1cb1-457d-9396-cca32c6e4fa2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

