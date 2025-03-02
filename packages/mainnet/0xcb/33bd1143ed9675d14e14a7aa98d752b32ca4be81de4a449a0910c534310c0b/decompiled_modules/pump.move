module 0xcb33bd1143ed9675d14e14a7aa98d752b32ca4be81de4a449a0910c534310c0b::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://firebasestorage.googleapis.com/v0/b/pumpisland-32099.firebasestorage.app/o/uploads%2FLogo200_pumpisland-1740942985975.webp?alt=media&token=6cffe4a8-a285-4328-8496-b22e48b58511                                                                                                                                         ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMP    ")))), trim_right(b"Pumpisland                      "), trim_right(b"PUMP is the first token on PumpIsland, created by the developers of PopIsland. It will be used for staking and boosts on the platform. The token is deflationary: every PUMP used to purchase a boost will be sent to a dead wallet, reducing the supply over time.                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v4);
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

