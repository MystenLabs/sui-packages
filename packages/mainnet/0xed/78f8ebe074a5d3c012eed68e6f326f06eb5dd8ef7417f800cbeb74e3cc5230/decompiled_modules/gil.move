module 0xed78f8ebe074a5d3c012eed68e6f326f06eb5dd8ef7417f800cbeb74e3cc5230::gil {
    struct GIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CSTx4nwL3Q3GUAZ5P81gWu95pxcNEN26vuK5Nb5dpump.png?claimId=Ych_1Wt_ZAE5GfzS                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GIL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GIL         ")))), trim_right(b"GIL                             "), trim_right(x"2447494c206f6e20534f4c0a0a46696e616c2046616e74617379204949492062792053717561726520456e6978202831393930292070726564696374656420616e206561726c792061646170746174696f6e206f6620426974636f696e2077697468206120677265656e20636f6c6f722e0a0a53717561726520456e697820616e64205361746f736869204e616b616d6f746f2061726520626f7468204a6170616e6573652e20436f696e636964656e63653f202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIL>>(v4);
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

