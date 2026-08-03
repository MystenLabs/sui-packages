module 0x699b8932e8fb532d99bb2e5920cc1cbb60e7646d8414c4e325937f80c089e8ed::trac {
    struct TRAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/do3EmSFcf5KHtjKzJFe3natdhobTY1KpzVk8X4nBJJ4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/do3EmSFcf5KHtjKzJFe3natdhobTY1KpzVk8X4nBJJ4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TRAC>(arg0, 9, trim_right(b"TRAC"), trim_right(b"TRAC  "), trim_right(b"TRAC (Trace Token) is the native utility token of OriginTrail, an open infrastructure building the Decentralized Knowledge Graph (DKG) for trusted data exchange, supply chain traceability and verifiable AI."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (99999999000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TRAC>>(0x2::coin::mint<TRAC>(&mut v5, 99999999000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRAC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAC>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

