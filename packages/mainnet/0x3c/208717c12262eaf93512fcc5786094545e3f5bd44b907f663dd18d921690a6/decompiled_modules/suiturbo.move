module 0x3c208717c12262eaf93512fcc5786094545e3f5bd44b907f663dd18d921690a6::suiturbo {
    struct SUITURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITURBO>(arg0, 9, b"SuiTurbo", b"SuiTurbo", b"$SuiTurbo Token began as a bold experiment in cryptocurrency creation. Inspired by the power of artificial intelligence, the project's creator turned to GPT-4 with a simple challenge.  Website: https://suiturbo.fun Twitter: https://x.com/SuiTurbo_Sui Telegram: https://t.me/SuiTurbo_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1728400623865-f35b1991fa7615089eb1c423d6aa5760.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITURBO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITURBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

