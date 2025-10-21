module 0xee233deb075224f6b4f949c48a7917edd05efae18b6ccdfb380cb9f6164766a8::fluent {
    struct FLUENT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLUENT>, arg1: 0x2::coin::Coin<FLUENT>) {
        0x2::coin::burn<FLUENT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLUENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUENT>>(0x2::coin::mint<FLUENT>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<FLUENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUENT>>(0x2::coin::split<FLUENT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLUENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUENT>(arg0, 9, trim_right(b"FLUENT"), trim_right(b"FLUENT "), trim_right(x"466c75656e7420e698afe69c80e585b7e8a1a8e78eb0e58a9be79a84e58cbae59d97e993bee4b98be4b880efbc8ce4bda0e58fafe4bba5e4bdbfe794a8e4bbbbe4bd95e8999ae68b9fe69cbae5928ce7bc96e7a88be8afade8a880e69da5e69e84e5bbbae5ba94e794a8e7a88be5ba8fe38082e5bd93e5898de694afe68c812045564de380810a53564d202349205741534d2e"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreigo4zrlsavq7ifwimvbmmhmuurjxatjrqjz77wk76r4g4klcobmte"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FLUENT>>(0x2::coin::mint<FLUENT>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUENT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUENT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<FLUENT>, arg1: 0x2::coin::Coin<FLUENT>) {
        0x2::coin::join<FLUENT>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<FLUENT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLUENT>>(0x2::coin::mint<FLUENT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (*0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != 32) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

