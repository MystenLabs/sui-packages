module 0x4c58f73e2adce5330ced806303bd2a2773962169b5171fa05093cff59954c393::sisae {
    struct SISAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISAE>(arg0, 6, b"SISAE", b"SUI SNAKE ", b"Sui snake is a layer 1 sui blockchain best Mem coin. This mene coin is a safe and secure meme coin. You can invest in this meme coin with your eyes closed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733300048074.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SISAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISAE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

