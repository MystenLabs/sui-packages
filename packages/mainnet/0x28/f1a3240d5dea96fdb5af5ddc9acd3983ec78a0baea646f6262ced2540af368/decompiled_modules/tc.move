module 0x28f1a3240d5dea96fdb5af5ddc9acd3983ec78a0baea646f6262ced2540af368::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ed9cfc2a72ffa21e470ba036d04f9b1071b430d71410a3de3ec7f54e1099057d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TC          ")))), trim_right(b"The Coalition                   "), trim_right(b"From the ashes of rug pulls and snipes, a new order rises. We are the renegade devs  the ones who stayed when everyone else ran. Forged in chaos, hardened by the grind, we build not for hype, but for honor. This is the coalition: a decentralized force of based devs united by purpose, bound by code, and driven by the mi"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TC>>(v4);
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

