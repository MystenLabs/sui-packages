module 0xf13b45f6b2acc93d465dea453b40e81ffc330807193f0421cc7ffd45eeb0332c::my_new_token {
    struct MY_NEW_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<MY_NEW_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_NEW_TOKEN>>(arg0, arg1);
    }

    fun init(arg0: MY_NEW_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_NEW_TOKEN>(arg0, 6, b"ADU", b"a duck", b"A fair token that everyone can mine, with a total supply of 500 million.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://duckcoin.space/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_NEW_TOKEN>>(0x2::coin::mint<MY_NEW_TOKEN>(&mut v2, 500000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_NEW_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MY_NEW_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

