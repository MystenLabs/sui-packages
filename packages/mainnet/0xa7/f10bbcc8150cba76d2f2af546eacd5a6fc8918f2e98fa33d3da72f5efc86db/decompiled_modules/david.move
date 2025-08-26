module 0xa7f10bbcc8150cba76d2f2af546eacd5a6fc8918f2e98fa33d3da72f5efc86db::david {
    struct DAVID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/36HyC4Cv61N4HoLXu4MiDB4m6tnXfo2BznwhVbfDL777.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DAVID>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DAVID       ")))), trim_right(b"DAVID & GOLIATH                 "), trim_right(x"20556e6976657273616c6c792069636f6e69632e2054696d656c6573736c79207265736f6e616e742e0a0a5468652073746f7279206f6620446176696420616e6420476f6c69617468206973206f6e65206f6620746865206d6f737420776964656c79207265636f676e697a6564206e61727261746976657320696e2068756d616e20686973746f72792e20466f756e6420696e20312053616d75656c20313720696e20746865204f6c642054657374616d656e742c20697473206e6f74206a7573742061206269626c6963616c2074616c65697473206265636f6d652061206d65746170686f7220656d62656464656420696e20676c6f62616c2063756c7475726520666f722074686520756e646572646f6720747269756d7068696e6720616761696e7374206f7665727768656c6d696e67206f6464732e0a0a20576879"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVID>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAVID>>(v4);
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

