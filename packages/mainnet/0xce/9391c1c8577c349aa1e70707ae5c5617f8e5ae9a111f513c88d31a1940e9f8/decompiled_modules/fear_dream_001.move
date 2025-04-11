module 0xce9391c1c8577c349aa1e70707ae5c5617f8e5ae9a111f513c88d31a1940e9f8::fear_dream_001 {
    struct FEAR_DREAM_001 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FEAR_DREAM_001>, arg1: 0x2::coin::Coin<FEAR_DREAM_001>) {
        0x2::coin::burn<FEAR_DREAM_001>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FEAR_DREAM_001>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FEAR_DREAM_001>>(0x2::coin::mint<FEAR_DREAM_001>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<FEAR_DREAM_001>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FEAR_DREAM_001>>(0x2::coin::split<FEAR_DREAM_001>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FEAR_DREAM_001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEAR_DREAM_001>(arg0, 9, trim_right(b"FND001"), trim_right(b"Fear & Dream001"), trim_right(b"Fear & Dream001 "), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreido4xyvqfihcp2mdzhxngoegzeylwftug2vlnd6cvo6ircyjyyteq"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FEAR_DREAM_001>>(0x2::coin::mint<FEAR_DREAM_001>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEAR_DREAM_001>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEAR_DREAM_001>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<FEAR_DREAM_001>, arg1: 0x2::coin::Coin<FEAR_DREAM_001>) {
        0x2::coin::join<FEAR_DREAM_001>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<FEAR_DREAM_001>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FEAR_DREAM_001>>(0x2::coin::mint<FEAR_DREAM_001>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

