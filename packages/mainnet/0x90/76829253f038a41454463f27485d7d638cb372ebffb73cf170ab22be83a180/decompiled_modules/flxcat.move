module 0x9076829253f038a41454463f27485d7d638cb372ebffb73cf170ab22be83a180::flxcat {
    struct FLXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Gb4VP7b7huToXmLvvNy1VauGttebc4vxVp5FEKQspump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLXCAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLXCAT      ")))), trim_right(b"FELIX The CAT                   "), trim_right(x"24464c5843415420697320546865204c6567656e646172792043656c656272697479204361742c2052657475726e73206f6e20536f6c616e61210a4a6f696e20746865207075727266656374207265766f6c7574696f6e20776974682046656c697820746865204361742c20746865206d656d65636f696e2074686174732074616b696e6720536f6c616e612062792073746f726d2120506c61792074686520464c584341542052554e20564944454f2047414d45204f4e204f55522057454253495445212024464c5843415420697320746865204f47204b494e47204f4620544845204d455441204d454d4520434f494e204341545321212120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLXCAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLXCAT>>(v4);
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

