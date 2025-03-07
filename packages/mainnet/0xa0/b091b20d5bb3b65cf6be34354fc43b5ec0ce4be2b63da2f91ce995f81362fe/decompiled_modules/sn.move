module 0xa0b091b20d5bb3b65cf6be34354fc43b5ec0ce4be2b63da2f91ce995f81362fe::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3FDydrowEeGNwEnTxZj13cgMqKgmzw1ewEX3CHXtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SN          ")))), trim_right(b"Sir Nasty                       "), trim_right(x"536972204e617374792028534e29202d2054686520526f677565206f662043727970746f0a0a536972204e617374792028534e29206973206120726562656c6c696f757320616e6420756e66696c74657265642063727970746f63757272656e63792064657369676e656420666f722074686f73652077686f20706c6179206279207468656972206f776e2072756c65732e205374726f6e6720636f6d6d756e697479206261636b696e672c20616e6420616e20756e61706f6c6f6765746963616c6c79207261772061747469747564652c20536972204e61737479206973206865726520746f207368616b65207570207468652063727970746f20776f726c642e0a0a4b65792066656174757265733a0a0a436f6d6d756e6974792d44726976656e3a204275696c7420627920646567656e732c20666f7220646567656e73"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SN>>(v4);
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

