module 0xa604f59e54407cc6fd6421232b0f91e692135a8f8690fa9383735fa95e7538f5::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<TED>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TED>>(arg0);
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 9, b"TED", b"Trump Elon Doge", b"The President Trump, Elon Musk, and Dogecoin. TrumpElonDoge aims to bring together the political dynamism of the new government, the innovative spirit of Elon Musk, and the fun, community-driven essence of Dogecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/tedogefunlogo/refs/heads/main/tedogefun.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TED>>(0x2::coin::mint<TED>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

