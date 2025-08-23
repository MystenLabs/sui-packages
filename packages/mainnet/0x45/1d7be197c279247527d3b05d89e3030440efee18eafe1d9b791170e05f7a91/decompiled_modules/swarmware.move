module 0x451d7be197c279247527d3b05d89e3030440efee18eafe1d9b791170e05f7a91::swarmware {
    struct SWARMWARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARMWARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9iDDjHPLhsSiyHtPZHHs4FoNXqxcWUspWXnvZpMSpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SWARMWARE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SWARMWARE   ")))), trim_right(b"Swarmware                       "), trim_right(b"SwarmWare is the next-generation platform for deploying, managing, and securing AI agent swarms. Transform your business operations with intelligent, collaborative AI agents that work together seamlessly to solve complex problems at scale with Multi-Agent Orchestration, Swarm Shield Security, Swarm Shield Security, rea"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARMWARE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARMWARE>>(v4);
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

