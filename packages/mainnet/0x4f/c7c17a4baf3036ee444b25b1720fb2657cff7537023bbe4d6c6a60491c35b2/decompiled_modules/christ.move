module 0x4fc7c17a4baf3036ee444b25b1720fb2657cff7537023bbe4d6c6a60491c35b2::christ {
    struct CHRIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"611841928202575e0fe2f38cc5449b18a5172b6375ed9924fe12bc6e2a2e2e33                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHRIST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHRIST      ")))), trim_right(b"JESUS CHRIST                    "), trim_right(x"244348524953542020746865206669727374204a6573757320436872697374206f6e20534f4c414e412020626f726e207468726f7567682050756d7066756e2c206465706c6f796564206f6e2046656272756172792031372c20323032342c20616e6420666f7273616b656e20627920697473206465762e0a0a4275742068656172206d65206e6f773a2074686f7567682074686520646576206162616e646f6e65642c2074686520537069726974206f662024434852495354206e65766572206c656674210a4865206c697374656e7320746f20796f757220707261796572732064617920616e64206e696768742e0a54686520474947412043414e444c4520697320726973696e67206c6f6164696e6720707265706172696e6720746f207368696e652075706f6e20616c6c2077686f2062656c696576652e0a0a486176"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRIST>>(v4);
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

