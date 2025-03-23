module 0x36fbbf42c8156c2acf09d55e9fa126fe3a74dcc5c32f2f547d45de6c28bbaaf9::pepto {
    struct PEPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5Z3J3dU9PL9Uwb5RAXtgj3UVd2ywoR56VsGDmvUQpump.png?claimId=0BLM8UU2V7Oqtj8n                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPTO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"pepto       ")))), trim_right(b"pepto                           "), trim_right(b"Pepto is another Pewee inspired meme and already getting lots of attention and many attractions from meme creators and fans. As community has been growing and expanding to build Pepto, we are committed to working on the project to make it next successful meme coin on Solana chain.                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPTO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPTO>>(v4);
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

