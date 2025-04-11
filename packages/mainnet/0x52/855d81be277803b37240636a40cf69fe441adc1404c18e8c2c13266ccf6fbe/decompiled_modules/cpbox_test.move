module 0x52855d81be277803b37240636a40cf69fe441adc1404c18e8c2c13266ccf6fbe::cpbox_test {
    struct CPBOX_TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CPBOX_TEST>, arg1: 0x2::coin::Coin<CPBOX_TEST>) {
        0x2::coin::burn<CPBOX_TEST>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CPBOX_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CPBOX_TEST>>(0x2::coin::mint<CPBOX_TEST>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<CPBOX_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CPBOX_TEST>>(0x2::coin::split<CPBOX_TEST>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CPBOX_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPBOX_TEST>(arg0, 6, trim_right(b"CT"), trim_right(b"CPBOX_TEST"), trim_right(x"e8bf99e698afe4b880e4b8aae6b58be8af95e4bba3e5b881"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafybeihosqykigkif5vmc4y7dqbq7epkd2uetjkro5pnljvxzgfmp642qa"))), arg1);
        let v2 = v0;
        if (10000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CPBOX_TEST>>(0x2::coin::mint<CPBOX_TEST>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPBOX_TEST>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CPBOX_TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<CPBOX_TEST>, arg1: 0x2::coin::Coin<CPBOX_TEST>) {
        0x2::coin::join<CPBOX_TEST>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<CPBOX_TEST>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CPBOX_TEST>>(0x2::coin::mint<CPBOX_TEST>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

