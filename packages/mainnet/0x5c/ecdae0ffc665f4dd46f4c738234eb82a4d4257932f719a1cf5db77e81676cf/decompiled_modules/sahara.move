module 0x5cecdae0ffc665f4dd46f4c738234eb82a4d4257932f719a1cf5db77e81676cf::sahara {
    struct SAHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/VgYumbnLSERyaLvFq13yV-6fo9JnGUIm42CpE1qgpuY";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/VgYumbnLSERyaLvFq13yV-6fo9JnGUIm42CpE1qgpuY"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<SAHARA>(arg0, 9, trim_right(b"sahara"), trim_right(b"sahara AI"), trim_right(b"Sahara Al is a decentralized blockchain platform for AI computing and data services. Focused on integrating AI technology with the Web3 ecosystem, it provides computing power, datasets, and AI training and application deployment solutions for AI researchers"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHARA>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SAHARA>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHARA>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

