module 0x85a62f693f6e649ff4effa6e6dfc44c0813b86668368c9bbd7719ef6b5f7434a::suitcase {
    struct SUITCASE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITCASE>, arg1: vector<0x2::coin::Coin<SUITCASE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUITCASE>>(&mut arg1);
        0x2::pay::join_vec<SUITCASE>(&mut v0, arg1);
        0x2::coin::burn<SUITCASE>(arg0, 0x2::coin::split<SUITCASE>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUITCASE>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUITCASE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUITCASE>(v0);
        };
    }

    fun init(arg0: SUITCASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/pbX5hxb/photo-2024-09-12-16-46-22.jpg"));
        let (v2, v3) = 0x2::coin::create_currency<SUITCASE>(arg0, 9, b"SUITCASE", b"SUITCASE", b"just a suitcase", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITCASE>>(v3);
        0x2::coin::mint_and_transfer<SUITCASE>(&mut v4, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCASE>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITCASE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITCASE>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUITCASE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITCASE>>(arg0);
    }

    // decompiled from Move bytecode v6
}

