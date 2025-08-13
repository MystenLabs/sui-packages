module 0x3687f3f6c11c626ad675825207a4e9c79bce5ab95fe3ba8ca29aef7704d85c9c::brs {
    struct BRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F1By3oDsf4YY4WTNAMznXwsBgGt7KBQPFfoMA2BEjups.png?claimId=OSbTPc8PsCRSmM2s                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRS         ")))), trim_right(b"Block Raccoon S.A               "), trim_right(x"244252532069732061206d656d6520636f696e20706f776572656420627920746865206e6172726174697665206368616f73206f6620426c6f636b526163632e61207061726f6479207370696e206f6e20426c61636b526f636b2e20497420626c656e64732061627375726420636f72706f72617465204c415250696e672c20686967682d6566666f727420726163636f6f6e206d656d65732c20616e6420536f6c616e612d6e61746976652063756c747572652e200a0a5468696e6b3a20546865204f6666696365206d6565747320446546692e20576974682064656570206c6f726520616e642063756c742d6c696b652076696265732024425253206973206275696c64696e6720612073617469726963616c20656d70697265206f6e2074686520536f6c616e6120626c6f636b636861696e2e20202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRS>>(v4);
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

