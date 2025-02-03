module 0x6b28c13f682b8dd8109c96884e54974d9131d5c3709ec2f3ee2cf0da4444d2ec::tariffs {
    struct TARIFFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARIFFS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BzTg2oP7C91hc4fom11UrYKeFyLnrbi7687WX3Kzpump.png?claimId=pEMA_OLIDydIPxUR                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TARIFFS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TARIFFS     ")))), trim_right(b"TARIFFS                         "), trim_right(x"57652061726520737065617268656164696e67206120436f6d6d756e6974792054616b656f766572202843544f2920696e69746961746976652c20656d70686173697a696e67207468617420696d706c656d656e74696e6720746172696666732077696c6c20726573746f726520416d657269636127732065636f6e6f6d69632070726f737065726974792e20507265736964656e74205472756d70206973207472756c7920746865204772656174657374206f6620416c6c2054696d652028474f415429210a0a496e2068697320726563656e7420696e6175677572616c20616464726573732c20507265736964656e74205472756d7020616e6e6f756e63656420706c616e7320746f206f7665726861756c207468652074726164652073797374656d20746f2070726f7465637420416d65726963616e20776f726b6572"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARIFFS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARIFFS>>(v4);
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

