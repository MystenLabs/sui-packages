module 0xb11ffae5df750774821866c009c8eada2e382104a5dac07643632efeccb055dd::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FV2EfQ694g6w46Q7vCW4jmt2bwuvP6pncmPaDnAhpump.png?claimId=YZ0YeVoN9zbR6m_z                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MASK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mask        ")))), trim_right(b"dogwifmask                      "), trim_right(x"57652061726520706c656173656420746f20616e6e6f756e636520746861742c20666f6c6c6f77696e672074656d706f72617279206368616c6c656e6765732063617573656420627920746865206d6173732073616c65206f662074686520746f6b656e2c2074686520736974756174696f6e20686173206265656e207375636365737366756c6c792073746162696c697a65642e2057652073696e636572656c79207468616e6b2065766572796f6e6520666f722074686569722070617469656e636520616e6420636f6e74696e75656420737570706f72742e20200a0a54686973206973206120434f4d4d554e4954592054414b454f5645522020616e64207468652066757475726520737461727473206e6f772e2020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASK>>(v4);
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

