module 0x79061744d5d9f2312ed9a8aa515f1bc617bb42acb5f34f6ac53942b7b93638ca::suillivan {
    struct SUILLIVAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUILLIVAN>, arg1: vector<0x2::coin::Coin<SUILLIVAN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUILLIVAN>>(&mut arg1);
        0x2::pay::join_vec<SUILLIVAN>(&mut v0, arg1);
        0x2::coin::burn<SUILLIVAN>(arg0, 0x2::coin::split<SUILLIVAN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUILLIVAN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUILLIVAN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUILLIVAN>(v0);
        };
    }

    fun init(arg0: SUILLIVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/disney/images/e/ef/Sulley.png/revision/latest?cb=20130302192551"));
        let (v2, v3) = 0x2::coin::create_currency<SUILLIVAN>(arg0, 8, b"Suillivan", b"Suillivan", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILLIVAN>>(v3);
        0x2::coin::mint_and_transfer<SUILLIVAN>(&mut v4, 10000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLIVAN>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILLIVAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUILLIVAN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUILLIVAN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUILLIVAN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

