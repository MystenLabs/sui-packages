module 0xd08869bd9aa7aca19e028d2c3e1d25b4cfba497f027fdb42d8dc04e9bab7df82::fatgirls {
    struct FATGIRLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATGIRLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6qGBJd8TaXP4nzNdCoFfyytM7RZfdwVNRcju6mfuLqpK.png?claimId=DFYx6-74WLsB2rQM                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FATGIRLS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"fatgirls    ")))), trim_right(b"like buying bitcoin in 2009     "), trim_right(b"Like buying bitcoin in 2009.                                                                                                                                                                                                                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATGIRLS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATGIRLS>>(v4);
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

