module 0x130f505398df77b899e0accfec43743a1eebead088135faefe5a6e2ebf6582e8::lai {
    struct LAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LAI>>(0x2::coin::mint<LAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x1865dc79a9e4b5751531099057d7ee801033d268.png?size=lg&key=bde3e1                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LAI     ")))), trim_right(b"Laika AI                        "), trim_right(b"Laika AI is building the comprehensive AI layer for Web3, combining enterprise RAG infrastructure, developer APIs, and analytics tools. With our multi-chain super-app chrome extension, Ai Agent Infrastructure, Telegram AI analytics, and verified ChatGPT plugins.                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LAI>>(0x2::coin::mint<LAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

