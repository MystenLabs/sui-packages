module 0xde39a8360ffba0c968aaa171c88ca3d937ddd2c0d74b7f173bf5b081eefc959c::world_liberty_financial_usd {
    struct WORLD_LIBERTY_FINANCIAL_USD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WORLD_LIBERTY_FINANCIAL_USD>, arg1: 0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>) {
        0x2::coin::burn<WORLD_LIBERTY_FINANCIAL_USD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WORLD_LIBERTY_FINANCIAL_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>>(0x2::coin::mint<WORLD_LIBERTY_FINANCIAL_USD>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>>(0x2::coin::split<WORLD_LIBERTY_FINANCIAL_USD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WORLD_LIBERTY_FINANCIAL_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORLD_LIBERTY_FINANCIAL_USD>(arg0, 6, trim_right(b"USD1  "), trim_right(b"World Liberty Financial USD"), trim_right(x"54686520555320446f6c6c617220757067726164656420666f722061206e657720657261206f662066696e616e636520e2809420737461626c652c207365637572652c20616e64207472616e73706172656e742062792064657369676e2e"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreiegajmvnizo3rludbgidfzomuutzdwpwyet5rl4ypfr2mehjhvus4"))), arg1);
        let v2 = v0;
        if (134099436000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>>(0x2::coin::mint<WORLD_LIBERTY_FINANCIAL_USD>(&mut v2, 134099436000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORLD_LIBERTY_FINANCIAL_USD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WORLD_LIBERTY_FINANCIAL_USD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>, arg1: 0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>) {
        0x2::coin::join<WORLD_LIBERTY_FINANCIAL_USD>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<WORLD_LIBERTY_FINANCIAL_USD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WORLD_LIBERTY_FINANCIAL_USD>>(0x2::coin::mint<WORLD_LIBERTY_FINANCIAL_USD>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

