module 0xa0f3e2ac8e0e60f7648cd5aee4088a96149a55ed444e2452acaee5dd57610a70::b16z {
    struct B16Z has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<B16Z>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<B16Z>>(0x2::coin::mint<B16Z>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: B16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HrzAvSCrpQR1R9SWiMfVSNRRqCb552q7zTK8oXSboop.png?size=lg&key=48b09b                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<B16Z>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"B16z    ")))), trim_right(b"Boop16z                         "), trim_right(b"Meme-based Public Tech: Built by everyone, for everyone. An open project to create tech transparently with shared ideas and teamwork. Join memers, developers, and thinkers to shape tech thats not controlled by big institutions but driven by community and open code.                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B16Z>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<B16Z>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<B16Z>>(0x2::coin::mint<B16Z>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

