module 0x79e55f839ecc8e5154f1a9ddcf54f0b021b7ca6dc647bac58e09c4f540a5e2ad::land {
    struct LAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/J9tBGFgTnpkVWPEwtHMwLqxUNFMXQakZXLQUP5y5pump.png?claimId=9-dDzRDEZHVGh9IC                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LAND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Land        ")))), trim_right(b"Landcoin                        "), trim_right(b"this is the new manifest destiny                                                                                                                                                                                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAND>>(v4);
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

