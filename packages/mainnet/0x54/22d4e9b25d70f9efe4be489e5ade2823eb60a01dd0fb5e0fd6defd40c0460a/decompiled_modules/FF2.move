module 0x5422d4e9b25d70f9efe4be489e5ade2823eb60a01dd0fb5e0fd6defd40c0460a::FF2 {
    struct FF2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FF2>, arg1: 0x2::coin::Coin<FF2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FF2>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FF2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FF2>>(0x2::coin::mint<FF2>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<FF2>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FF2>>(arg0);
    }

    fun init(arg0: FF2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF2>(arg0, 9, b"FF2", b"Final Final 2", b"This is the final final 2, maybe last one? IDK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dictionary.com/e/wp-content/uploads/2018/03/asdfmovie-300x300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FF2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

