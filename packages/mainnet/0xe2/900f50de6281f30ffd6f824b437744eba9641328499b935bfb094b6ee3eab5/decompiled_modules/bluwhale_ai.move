module 0xe2900f50de6281f30ffd6f824b437744eba9641328499b935bfb094b6ee3eab5::bluwhale_ai {
    struct BLUWHALE_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUWHALE_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUWHALE_AI>(arg0, 9, b"BLUAI", b"Bluwhale AI", b"Bluwhale is a Web3 wallet analytics tool that enhances user experiences using personalized AI and contextual data.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.cryptorank.io/coins/bluwhale1760959386303.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUWHALE_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUWHALE_AI>>(0x2::coin::mint<BLUWHALE_AI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUWHALE_AI>>(v2);
    }

    // decompiled from Move bytecode v6
}

