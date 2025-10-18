module 0xe63cd2acaf9a2f2709d86f48f416fd5e77af28bb598ce15b5b733155a04eae9f::private_coin {
    struct PRIVATE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PRIVATE_COIN>, arg1: 0x2::coin::Coin<PRIVATE_COIN>) {
        0x2::coin::burn<PRIVATE_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIVATE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATE_COIN>>(0x2::coin::mint<PRIVATE_COIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<PRIVATE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATE_COIN>>(0x2::coin::split<PRIVATE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIVATE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIVATE_COIN>(arg0, 9, trim_right(b"USDT"), trim_right(b"private coin"), trim_right(b"jingongyule"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreienqldgrluo2fdnwghpl3sw54fmrzmxh4po47v5ahqm5gebzl43m4"))), arg1);
        let v2 = v0;
        if (76904188000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATE_COIN>>(0x2::coin::mint<PRIVATE_COIN>(&mut v2, 76904188000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIVATE_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRIVATE_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<PRIVATE_COIN>, arg1: 0x2::coin::Coin<PRIVATE_COIN>) {
        0x2::coin::join<PRIVATE_COIN>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<PRIVATE_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIVATE_COIN>>(0x2::coin::mint<PRIVATE_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

