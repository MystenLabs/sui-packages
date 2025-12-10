module 0x4257af578c2f1fe14fe2e42b74df1213d81be3fae8d301d6ec082dedec24ea97::wtfo {
    struct WTFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"63e98a5b8d5cdc2942bfebb3f1332a82750b337d776be0370fb09589b3941e07                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WTFO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WTFO        ")))), trim_right(b"WTF Opossum                     "), trim_right(x"245754464f206973206e6f74206a757374206120756e69717565206368617261637465722c20697420697320746865206f6666696369616c20746f6b656e206f6620506f7373756d6c61627320736f6c616e61206c61756e636870616420616e64205754462065636f73797374656d206f6e2074656c656772616d2e200a546f6b656e2070656767656420746f206d616e79206c697665207574696c69746965732073756368206173206c61756e63687061642c766f74696e672c206576656e742c20726166666c652063726561746f722e0a0a5765656b6c7920726576656e75652073686172652c206275726e2c207265646973747269627574696f6e2c20506f7373756d204e46542061697264726f7020746f20686f6c646572732e20202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTFO>>(v4);
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

