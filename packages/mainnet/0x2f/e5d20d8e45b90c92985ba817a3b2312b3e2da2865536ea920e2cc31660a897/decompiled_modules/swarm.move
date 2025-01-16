module 0x2fe5d20d8e45b90c92985ba817a3b2312b3e2da2865536ea920e2cc31660a897::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SWARM>(arg0, 10152084063317784171, b"SwarmAi", b"Swarm", b"Swarm AI", b"https://images.hop.ag/ipfs/QmTBeuhqyWXFMgrTLrE9s8tFDtzCRuG9fEdL53T5sNVrvL", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

