module 0xd176dc3991837a78a5c0659fb38843e985938fb1bad5c8c75c9f437437bb1697::coin_private {
    struct COIN_PRIVATE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COIN_PRIVATE>, arg1: 0x2::coin::Coin<COIN_PRIVATE>) {
        0x2::coin::burn<COIN_PRIVATE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_PRIVATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_PRIVATE>>(0x2::coin::mint<COIN_PRIVATE>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<COIN_PRIVATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_PRIVATE>>(0x2::coin::split<COIN_PRIVATE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN_PRIVATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_PRIVATE>(arg0, 9, trim_right(b"USDT  "), trim_right(b"coin private"), trim_right(b"Ceshi yulezhuanyong"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreico6snv6ga4iugawyaghqpilrrc4sl3wcw7spyabe5g2sitzmjyza"))), arg1);
        let v2 = v0;
        if (75905666000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<COIN_PRIVATE>>(0x2::coin::mint<COIN_PRIVATE>(&mut v2, 75905666000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_PRIVATE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN_PRIVATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<COIN_PRIVATE>, arg1: 0x2::coin::Coin<COIN_PRIVATE>) {
        0x2::coin::join<COIN_PRIVATE>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<COIN_PRIVATE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN_PRIVATE>>(0x2::coin::mint<COIN_PRIVATE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

