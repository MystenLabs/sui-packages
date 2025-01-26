module 0x19c2776cec684dab163e55edfc9a8377cb604849fd33cae25c76fc05e0e814fe::saitama {
    struct SAITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9aD34xEzZbXJXGRWmjySLiRTUV8JZzhQ4T4RHyxupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAITAMA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAITAMA     ")))), trim_right(b"SAITAMA INU                     "), trim_right(x"57656c636f6d6520746f207468652072656269727468206f662053616974616d612120546865204f4720576f6c667061636b206973206261636b2c207374726f6e676572207468616e20657665722e204a6f696e2075732061732077652072657669766520746865206c656761637920616e6420706f776572206f66207468697320696e6372656469626c6520636f696e2e20546f6765746865722c2077652063616e20726563726561746520746865206578636974656d656e74206f6620323032312e2057656c636f6d65206261636b20746f20746865207061636b210a0a53414954414d41204953204f4646494349414c4c59205245424f524e2e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAITAMA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAITAMA>>(v4);
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

