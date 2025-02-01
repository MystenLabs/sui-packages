module 0xcc223fe3b5fcf08b2cb15c290ba7a00d03cbb379dc8d4c1afe9d6d3ff8a1b36e::gtrump {
    struct GTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTRUMP>(arg0, 9, b"GTRUMP", b"Grand Trump Auto", b" Play as Donald, the ultimate deal-maker, dodging lawsuits, golfing, and tweeting your way to the top!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/cVg3eoRr3-fi85yX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GTRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTRUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

