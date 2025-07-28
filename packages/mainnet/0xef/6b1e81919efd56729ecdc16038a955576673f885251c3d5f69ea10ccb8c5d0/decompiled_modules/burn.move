module 0xef6b1e81919efd56729ecdc16038a955576673f885251c3d5f69ea10ccb8c5d0::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmT51gCZaXGZeLnHsJqQdKQFrx9RsikRLpiksFzggxCa8j                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BURN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BURN    ")))), trim_right(b"BurnPlay                        "), trim_right(x"4275726e506c61792028244255524e2920697320612067616d652d6261736564206465666c6174696f6e61727920746f6b656e206f6e205355492c206f66666572696e67207765656b6c79207265776172647320616e64206578747261207072697a65732c206c696b652074686520596561722d656e64206a61636b706f74210a54686520556c74696d6174652043727970746f2047616d696e6720457870657269656e6365210a506c6179206164646963746976652067616d65732c206275726e20746f6b656e732c206561726e2072657761726473206f6e207468652053554920626c6f636b636861696e2120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v4);
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

