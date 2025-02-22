module 0xadb0ad84eadf0956b609803a95e265bb1476b72876cf8af156cc467d6b7af72e::link {
    struct LINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6U9jg6i8SBA7TcQc1maM5CxJP5ZcfEZxKBy2CGBLpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LINK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LINK        ")))), trim_right(b"AILINK                          "), trim_right(b"AIlink is revolutionizing the way people interact with decentralized finance (DeFi). Powered by cutting-edge AI technology and multiple advanced language models (LLMs), AIlink serves as a smart oracle designed to bring Real-World Asset (RWA) investments to the masses. Our mission is to simplify DeFi, making it accessib"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINK>>(v4);
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

