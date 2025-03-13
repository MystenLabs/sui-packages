module 0xf2a28f07dbad83e4271a6cc1da741c79dd51abbd9ef90cba2a9ea2ea0125850f::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bv133dHPMHXrfYoDe2JFEVMqoj7Pt3XFiqfnLXBUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MTC         ")))), trim_right(b"Merle The Cat                   "), trim_right(x"4d65726c65205468652043617420284d5443290a48656c6c6f2049276d204d65726c65207468652043617421205468697320746f6b656e206973206d616465206279204861726c6f204920616d2038207965617273206f6c6420616e642069276d206d616b696e67207468697320636f696e2077697468206d79204461642e2049206d616465206120636172746f6f6e206f66206d79206b6974747920636174206e616d6564204d65726c65212049206c6f766520746f206472617720616e64206d616b65206172742e20492061736b6564206d792064616420696620492063616e2062757920616e206970616420616e64206865207361696420492068616420746f206561726e20697420736f20492061736b65642068696d20696620692063616e206d616b6520612063727970746f2e20536f2068657265206973206f75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTC>>(v4);
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

