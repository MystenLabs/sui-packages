module 0x1fd4835e8bfc7cbfb448fd91ec4132d86b8aa98d9061bf8f7b7c6823383a334f::aby {
    struct ABY has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ABY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ABY>>(arg0, arg1);
    }

    fun init(arg0: ABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABY>(arg0, 9, b"ABY", b"Abiiyco", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

