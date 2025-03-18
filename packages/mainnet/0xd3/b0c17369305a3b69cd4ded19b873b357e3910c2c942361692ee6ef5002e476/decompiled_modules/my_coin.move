module 0xd3b0c17369305a3b69cd4ded19b873b357e3910c2c942361692ee6ef5002e476::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        0x2::coin::burn<MY_COIN>(arg0, arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"CPWH", b"coderpwh", x"436f6465725057482028435057482920e698afe4b880e4b8aae59fbae4ba8e2053756920e58cbae59d97e993bee79a84e887aae5ae9ae4b989e4bba3e5b881efbc8ce794b1e5bc80e58f91e88085207077682d707768efbc884769744875623a206769746875622e636f6d2f7077682d707768efbc89e5889be5bbbae380824350574820e697a8e59ca8e4b8bae5bc80e58f91e88085e7a4bee58cbae68f90e4be9be4b880e7a78de8bdbbe9878fe7baa7e38081e58ebbe4b8ade5bf83e58c96e79a84e4bbb7e580bce4baa4e68da2e5b7a5e585b7efbc8ce6bf80e58ab1e7bc96e7a88be5889be696b0e38081e79fa5e8af86e58886e4baabe5928ce58d8fe4bd9ce5bc80e58f91", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/56707259?v=4&size=128")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MY_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

