module 0xd80c63242ce542c307e627d3fc57952d646533f2379e63e59753fd0d78c98b27::gators {
    struct GATORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/77DxoUp91xxumYBzPDQF7YqKe86y927LbeKBH1EiBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GATORS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GATORS      ")))), trim_right(b"gatorwifhouse                   "), trim_right(b"100% of royalties go to Bellowing Acres Alligator Sanctuary, which provides a forever home to rescued nuisance alligators. @GatorBoys_Chris is one of the co-founders and will receive all funds raised by this community driven token. Let's see how many gators we can save.                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATORS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATORS>>(v4);
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

