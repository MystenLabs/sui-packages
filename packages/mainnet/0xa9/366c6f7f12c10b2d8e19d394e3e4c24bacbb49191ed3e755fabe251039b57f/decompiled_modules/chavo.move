module 0xa9366c6f7f12c10b2d8e19d394e3e4c24bacbb49191ed3e755fabe251039b57f::chavo {
    struct CHAVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BEC7R7S32sQiXKoPJwNUG8ANEzXRAYWLqJxioUcKkray.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAVO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHAVO       ")))), trim_right(b"El Chavo de Ocho!               "), trim_right(x"24434841564f2020204c6120766563696e64616420676f6573206f6e2d636861696e210a4120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e20696e73706972656420627920456c20436861766f2064656c204f63686f2c20626c656e64696e67206e6f7374616c6769612c2068756d6f722c20616e642063727970746f2063756c747572652e204275696c74206f6e20536f6c616e6120666f7220737065656420616e64206c6f7720666565732c2024434841564f20756e697465732066616e7320776f726c6477696465207468726f7567682072656c617461626c6520636861726163746572732c204c6174696e20416d65726963616e2063756c747572616c20726f6f74732c20616e64206d656d652d776f72746879206d6f6d656e74732e0a0a4e465420636f6c6c656374696f6e7320616e6420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAVO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAVO>>(v4);
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

