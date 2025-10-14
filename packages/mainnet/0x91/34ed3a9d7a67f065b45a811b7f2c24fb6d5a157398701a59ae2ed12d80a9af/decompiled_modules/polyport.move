module 0x9134ed3a9d7a67f065b45a811b7f2c24fb6d5a157398701a59ae2ed12d80a9af::polyport {
    struct POLYPORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLYPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9214fa8ba1415e40dfd8d39a891cfba0638bed4162b09c75523a89a9c9a597a9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POLYPORT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POLYPORT    ")))), trim_right(b"PolyPort                        "), trim_right(b"PolyPort is a next-generation decentralized prediction markets platform built on Solana, offering lightning-fast settlement, automated market making, and seamless user experience. Our platform enables users to trade on the outcome of real-world events with instant finality and minimal fees.                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLYPORT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLYPORT>>(v4);
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

