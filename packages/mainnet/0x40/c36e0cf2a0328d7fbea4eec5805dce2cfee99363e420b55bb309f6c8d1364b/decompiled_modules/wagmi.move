module 0x40c36e0cf2a0328d7fbea4eec5805dce2cfee99363e420b55bb309f6c8d1364b::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAGMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGMI>>(0x2::coin::mint<WAGMI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x5f4ab80c2c7755d565371236f090597921d18ee5.png?size=lg&key=c29e04                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAGMI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WAGMI   ")))), trim_right(b"WAGMICOIN                       "), trim_right(b"Inspired by Beeples iconic \"WAGMICOIN\" artwork, $WAGMI has emerged as a unique memecoin built on the ethos of \"Were All Gonna Make It.\" Combining creativity with community-driven innovation, $WAGMI aims to bring a fresh perspective to the world of cryptocurrency.                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAGMI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAGMI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGMI>>(0x2::coin::mint<WAGMI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

