module 0xec22b07c47fb7299b0b17bdedf23af289802472a2b5d423ba8aa39d7f6f2f39d::moron {
    struct MORON has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MORON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MORON>>(0x2::coin::mint<MORON>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MORON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xbad167561495c65f6f6c401fc1d4eadc0ff5af2a.png?size=lg&key=89a600                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MORON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MORON   ")))), trim_right(b"Sui Moron                       "), trim_right(b"Da offishul curency of bad decesions. Buy hi, sell low, blame teh chart.  100% commnity drivan, zero IQ, full send too da moon. U dont hodl $MORON $MORON hodlz u.                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORON>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MORON>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MORON>>(0x2::coin::mint<MORON>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

