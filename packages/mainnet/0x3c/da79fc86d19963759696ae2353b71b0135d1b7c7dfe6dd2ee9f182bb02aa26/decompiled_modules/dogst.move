module 0x3cda79fc86d19963759696ae2353b71b0135d1b7c7dfe6dd2ee9f182bb02aa26::dogst {
    struct DOGST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGST>(arg0, 9, b"DOGST", b"DogStyle ", b"A meme of a very stylish puppy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1425ee41-e650-4a51-80bc-6cb5df2fdf43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGST>>(v1);
    }

    // decompiled from Move bytecode v6
}

