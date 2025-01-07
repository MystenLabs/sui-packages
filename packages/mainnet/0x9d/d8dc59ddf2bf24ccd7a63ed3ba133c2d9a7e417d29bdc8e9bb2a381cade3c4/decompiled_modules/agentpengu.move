module 0x9dd8dc59ddf2bf24ccd7a63ed3ba133c2d9a7e417d29bdc8e9bb2a381cade3c4::agentpengu {
    struct AGENTPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTPENGU>(arg0, 6, b"AGENTPENGU", b"AGENT PENGU", x"54686520636f6f6c65737420616e64206d6f737420746563686e6f6c6f676963616c206d656d65636f696e206f6e20746865206d61726b65742120e29d84efb88ff09f90a720496e737069726564206279207468652063756e6e696e6720616e64206368617269736d61206f6620746865206d6f73742061646f7261626c6520736563726574206167656e742c204167656e742050656e67752c20746869732063727970746f63757272656e637920636f6d62696e65732066756e2c20636f6d6d756e69747920616e64206675747572697374696320746563686e6f6c6f67792e205769746820697473206d697373696f6e20746f20636f6e71756572207468", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736118381409.38")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENTPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTPENGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

