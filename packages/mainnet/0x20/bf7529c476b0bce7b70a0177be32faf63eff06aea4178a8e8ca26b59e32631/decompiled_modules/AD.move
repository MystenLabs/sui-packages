module 0x20bf7529c476b0bce7b70a0177be32faf63eff06aea4178a8e8ca26b59e32631::AD {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 9, b"AD", b"ADAPT", b"The first agent network protocol (ANP3) for crypto trading. Connected agents empower everyone to trade like experts and adapt to the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://adapt-anp3.ai/logo.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AD>>(0x2::coin::mint<AD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AD>>(v2);
    }

    // decompiled from Move bytecode v7
}

