module 0x5f4cdb9c21460c317632e83edae4d7365a01d488390d44b759286eec7eb335f1::freeshlomo {
    struct FREESHLOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREESHLOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9L1SWjsBFaCeUP9sh9s7wty7n69vTrTPCJx41DcPpump.png?claimId=PI7cUHadVSj7H13P                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FREESHLOMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FREESHLOMO  ")))), trim_right(b"FREE SHLOMO                     "), trim_right(x"234672656553686c6f6d6f0a0a36206d6f6e7468732061676f2c204161726f6e20616b612053686c6f6d6f2c2061204765726d616e206661746865722c207761732073656e74656e63656420746f20707269736f6e20666f7220706f6c69746963616c207361746972652e200a0a546f6461792c20686520627265616b73206869732073696c656e63652e0a0a496e73706972656420627920456c6f6e204d75736b20616e64204a442056616e63652c2053686c6f6d6f2067617468657265642074686520636f757261676520746f2073656e6420616e20617564696f206d6573736167652073747261696768742066726f6d20707269736f6e2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREESHLOMO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREESHLOMO>>(v4);
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

