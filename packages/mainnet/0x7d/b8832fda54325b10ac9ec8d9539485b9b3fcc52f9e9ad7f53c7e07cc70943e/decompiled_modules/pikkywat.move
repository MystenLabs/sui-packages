module 0x7db8832fda54325b10ac9ec8d9539485b9b3fcc52f9e9ad7f53c7e07cc70943e::pikkywat {
    struct PIKKYWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKKYWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKKYWAT>(arg0, 9, b"PIKKYWAT", b"Green", b"Green is a meme inspired by the atmosphere of natural growth and adventure. With Green, we are not just mastering the waves, we are making formation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64bce617-ab92-44b8-99c1-afac81aae337.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKKYWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKKYWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

