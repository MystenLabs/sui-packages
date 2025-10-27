module 0xedffc43b2e450062559951295eb151077c777f2f79b1351aac39834164d21672::blueysui {
    struct BLUEYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEYSUI>(arg0, 9, b"BLUEYSUI", b"BLUEYSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761578908/sui_tokens/lekioj2od4vuttu6zeaw.avif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEYSUI>>(0x2::coin::mint<BLUEYSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEYSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEYSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

