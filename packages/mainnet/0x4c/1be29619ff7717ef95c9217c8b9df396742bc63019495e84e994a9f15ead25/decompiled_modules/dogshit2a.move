module 0x4c1be29619ff7717ef95c9217c8b9df396742bc63019495e84e994a9f15ead25::dogshit2a {
    struct DOGSHIT2A has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSHIT2A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BXebtR4k2WiaZ1HJmxcZkoCdxSBx1g1xnEpVra9Ppump.png?claimId=nS4QLdVxBdZj2iLM                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGSHIT2A>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGSHIT2    ")))), trim_right(b"Dog Shit Going NoWhere          "), trim_right(b"Burwick Law's lawsuit to pumpfun wont make sense when the token they launched to prove pump fun tokens go to zero runs to billions.                                                                                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSHIT2A>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSHIT2A>>(v4);
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

