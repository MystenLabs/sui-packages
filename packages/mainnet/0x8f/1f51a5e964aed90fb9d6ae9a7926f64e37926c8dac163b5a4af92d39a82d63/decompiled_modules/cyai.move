module 0x8f1f51a5e964aed90fb9d6ae9a7926f64e37926c8dac163b5a4af92d39a82d63::cyai {
    struct CYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"102bd59eff813f02bf51fa1afdfa91c62aec74f3f316ab63d908779b31772118                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CYAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CYAI        ")))), trim_right(b"CyreneAI                        "), trim_right(b"The $CYAI Token is the heartbeat of the CyreneAI ecosystem, powering a decentralized AI economy. It enables seamless AI agent deployment, staking for decentralized compute, and transactions in the marketplace for AI-driven services and models. Token holders gain governance rights, shaping protocol upgrades and earning "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYAI>>(v4);
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

