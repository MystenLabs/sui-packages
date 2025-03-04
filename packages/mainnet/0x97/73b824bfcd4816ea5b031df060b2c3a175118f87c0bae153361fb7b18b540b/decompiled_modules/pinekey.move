module 0x9773b824bfcd4816ea5b031df060b2c3a175118f87c0bae153361fb7b18b540b::pinekey {
    struct PINEKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINEKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GHAgf97Y4xsfRX61WoEx3b9mg6iDMQD6AsgnzEKopump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PINEKEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PineKey     ")))), trim_right(b"Pine Key Tampa Bay              "), trim_right(x"4265636f6d6520616e2069736c616e64206f776e65722077697468207573210a0a2450696e654b65792052574120616e64206861732061207265616c20776f726c64207574696c6974792e200a0a5265616c20776f726c6420736861726573206f66207468652069736c616e642063616e2062652070757263686173656420666f7220243130303020555344206f72206571756976616c656e7420696e202450696e654b657920546f6b656e2e0a0a5768656e2077652067657420746f2061202435304d204d432c20776520706c616e20746f2072656e616d65207468652069736c616e6420746f20536f6c616e612069736c616e642e200a0a5669736974206f7572207765627369746520666f72206d6f726520696e666f726d6174696f6e2e20202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINEKEY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINEKEY>>(v4);
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

