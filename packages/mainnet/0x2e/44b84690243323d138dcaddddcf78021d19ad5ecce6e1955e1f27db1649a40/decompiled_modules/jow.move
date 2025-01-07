module 0x2e44b84690243323d138dcaddddcf78021d19ad5ecce6e1955e1f27db1649a40::jow {
    struct JOW has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JOW>>(0x2::coin::mint<JOW>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x17d9958e9086d5d31416942f3594f0c8f7234428.png?size=lg&key=c31cd6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JOW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JOW     ")))), trim_right(b"Jow Dones                       "), trim_right(b"At Jow Dones were flipping the script literally. Inspired by the Dow Jones and fueled by the unstoppable energy of meme culture, were here to redefine what it means to build wealth. we are uniting innovation, community, and fun with a singular mission: to surpass the market cap of the Dow Jones.                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOW>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JOW>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<JOW>>(0x2::coin::mint<JOW>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

