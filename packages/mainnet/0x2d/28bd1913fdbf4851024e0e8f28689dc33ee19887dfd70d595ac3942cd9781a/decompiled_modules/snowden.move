module 0x2d28bd1913fdbf4851024e0e8f28689dc33ee19887dfd70d595ac3942cd9781a::snowden {
    struct SNOWDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7K9YEepYXwSmiVreL7s1mqoxeLGFQ5z4v2Vimxx4pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SNOWDEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SNOWDEN     ")))), trim_right(b"PARDON SNOWDEN                  "), trim_right(x"446576206c65667420746869732070726f6a65637420666f72206465616420736f20612043544f2063616d6520746f676574686572206f6e2074686973204f4720636f6e74726163742e20576520636f756c646e2774206c6574207468697320666967687420656e64210a0a45647761726420536e6f7764656e206578706f736564206d61737320676f7665726e6d656e74206f76657272656163682c20646566656e64696e6720746865207072696e6369706c6573206f66207472616e73706172656e637920616e6420707269766163792e200a0a4974732074696d652077652061636b6e6f776c656467652068697320636f757261676520616e64206772616e742068696d206120706172646f6e2e200a0a497473206265656e2031322079656172732e204c657473206272696e6720746865206c6567656e6420686f6d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWDEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWDEN>>(v4);
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

