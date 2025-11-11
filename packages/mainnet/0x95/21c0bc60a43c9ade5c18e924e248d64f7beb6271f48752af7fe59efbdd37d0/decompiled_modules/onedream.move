module 0x9521c0bc60a43c9ade5c18e924e248d64f7beb6271f48752af7fe59efbdd37d0::onedream {
    struct ONEDREAM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONEDREAM>, arg1: 0x2::coin::Coin<ONEDREAM>) {
        0x2::coin::burn<ONEDREAM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ONEDREAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ONEDREAM>>(0x2::coin::mint<ONEDREAM>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<ONEDREAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ONEDREAM>>(0x2::coin::split<ONEDREAM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ONEDREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEDREAM>(arg0, 9, trim_right(b"ONEDREAM"), trim_right(b"ONEDREAM "), trim_right(b"ONEDREAM  "), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafybeido7nnixy5bjzvly3743wee47ypebkera7kazgzqfqdan4avbtuuy"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ONEDREAM>>(0x2::coin::mint<ONEDREAM>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEDREAM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONEDREAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<ONEDREAM>, arg1: 0x2::coin::Coin<ONEDREAM>) {
        0x2::coin::join<ONEDREAM>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<ONEDREAM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ONEDREAM>>(0x2::coin::mint<ONEDREAM>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

