module 0x3009daba750f98702c274d6e68e08a9e73f978b31c172e3553b82376ca968f30::tics {
    struct TICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GyagXyxpiUPrwfEpzhfnf5X8n3XKf3gG5WkD6LDFnvEc.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TICS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TICS        ")))), trim_right(b"Qubetics                        "), trim_right(x"2a2051756265746963733a2054686520576f726c642773204669727374204c6179657220312c205765623320416767726567617465642045636f73797374656d205468617420556e69746573204c656164696e6720426c6f636b636861696e7320496e636c7564696e6720536f6c616e61202a0a0a51756265746963732069732061206c6179657220312057454233206167677265676174656420626c6f636b636861696e20746861742077696c6c20756e69667920616c6c20626c6f636b636861696e206e6574776f726b7320696e636c7564696e6720534f4c2c20666f637573696e67206f6e207363616c6162696c6974792c20736563757269747920616e6420696e7465726f7065726162696c6974792e2051756265746963732061696d7320746f20626520746865206c656164696e6720626c6f636b636861696e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICS>>(v4);
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

