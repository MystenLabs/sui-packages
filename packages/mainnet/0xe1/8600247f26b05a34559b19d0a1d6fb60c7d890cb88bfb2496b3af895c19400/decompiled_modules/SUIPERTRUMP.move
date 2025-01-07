module 0xe18600247f26b05a34559b19d0a1d6fb60c7d890cb88bfb2496b3af895c19400::SUIPERTRUMP {
    struct SUIPERTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERTRUMP>(arg0, 6, b"SUIPERTRUMP", b"SUIPERTRUMP", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/AISSlQJ.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPERTRUMP>(&mut v2, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERTRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

