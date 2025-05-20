module 0xf7b46c000a7516a0524a6178f28c45445ab603ac8f9cc86999b393066ee14125::bitcorn {
    struct BITCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FSqH8gHUdt87mwJJm8figSz8kJyLdietRcPwDcfopump.png?claimId=BYvqHCj6t4zvQTDk                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BITCORN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BITCORN     ")))), trim_right(b"BITCORN                         "), trim_right(x"5468696e6b20746865726520776173206e6f2073706563696669632074696d6520616e6420706c6163652077686572652022626974636f726e222077617320636f696e65642e20497420776173206261736963616c6c79206a757374206120706c6179206f6e20776f7264732e20546865207465726d2077617320706f70756c6172697a656420616674657220612070726f666573736f722066726f6d20626f73746f6e20756e697665727369747920284d61726b2057696c6c69616d73292070726564696374656420696e203230313320746861742042544320776f756c642062652074726164696e672061742024313020612079656172206c617465722e200a0a486520776173206e616d6564202270726f666573736f7220626974636f726e222062792074686520636f6d6d756e6974792062656361757365206f6620"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCORN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCORN>>(v4);
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

