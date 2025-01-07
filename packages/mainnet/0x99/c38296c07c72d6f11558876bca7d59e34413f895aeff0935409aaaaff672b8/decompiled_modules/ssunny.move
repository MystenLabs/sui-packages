module 0x99c38296c07c72d6f11558876bca7d59e34413f895aeff0935409aaaaff672b8::ssunny {
    struct SSUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUNNY>(arg0, 9, b"SSUNNY", b"ssunny", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2edb5a48-edc5-4b10-ab08-3f151a9b2316.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

