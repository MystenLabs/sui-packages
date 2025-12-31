module 0xcf738df7c2e1701364f2f4e8cb70a70d713d3b64c77e0a914e9460e68bd50dab::yukc {
    struct YUKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/Qmewcd5M27GUyVG45UhVmQMFa9VxT5J1KL5VVWYJv5M9qS                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YUKC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YUKC    ")))), trim_right(b"Yukichi Coin                    "), trim_right(x"59554b4320697320612066697865642d737570706c79207574696c69747920746f6b656e20697373756564206f6e207468652053756920626c6f636b636861696e2e0a49742069732064657369676e656420746f2066756e6374696f6e20617320612067656e6572616c2d707572706f7365206469676974616c2061737365742077697468696e206170706c69636174696f6e7320616e64207365727669636573206275696c74206f6e205375692e0a54686520746f74616c20737570706c79206f662059554b43206973207065726d616e656e746c792063617070656420616e642063616e6e6f7420626520696e637265617365642e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKC>>(v4);
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

