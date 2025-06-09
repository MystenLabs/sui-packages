module 0xb35cf018884fe2e663b75491dc06db447fc46598ac78a4a49067a4c1b25f1766::hnm {
    struct HNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2FnUQzRDTSyHjMpiw8j8VMNq19iAsCNSV1AE4oyDpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HNM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HNM         ")))), trim_right(b"HreNvaM                         "), trim_right(x"484e4d2069736e74206a7573742061206d656d652e2049747320686f70652e204974732066726565646f6d2e0a41207369676e616c20666f722074686f73652077686f207374696c6c2062656c6965766520696e20646563656e7472616c697a6174696f6e2c2063727970746f20696465616c732c20616e6420626c6f636b636861696e206a7573746963652e0a5765207374616e64207769746820526f737320556c62726963687420616e6420616c6c2077686f20666967687420666f722061207472756c79206672656520626c6f636b636861696e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HNM>>(v4);
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

