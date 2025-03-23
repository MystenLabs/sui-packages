module 0xd589822040dec94c675ece324c7f164cc88987b665f42a1cb31a8129d72e16c6::nvs {
    struct NVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F2HZCgwKnD7t1zY9Gi94vXG48yLkpSJfdvoRxS3sXFpS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NVS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NVS         ")))), trim_right(b"Novius                          "), trim_right(x"4e6f76697573414920697320746865206e6578742067656e65726174696f6e206f662063727970746f63757272656e63792c20636f6d62696e696e672063757474696e6720656467652041492064726976656e20616e616c79746963732077697468207365637572652c20646563656e7472616c697a656420626c6f636b636861696e20746563686e6f6c6f67792e0a0a44657369676e656420666f72207472616e73666f726d6174696f6e20616e64206578706f6e656e7469616c2067726f7774682c204e6f76697573414920656d706f7765727320736d617274657220696e766573746d656e74732c207365616d6c657373207363616c6162696c69747920616e64207375737461696e61626c6520696e6e6f766174696f6e2e0a0a57697468206120666f756e646174696f6e20696e207472616e73706172656e63792c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVS>>(v4);
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

