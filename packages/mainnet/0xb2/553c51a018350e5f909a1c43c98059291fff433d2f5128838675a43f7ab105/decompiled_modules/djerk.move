module 0xb2553c51a018350e5f909a1c43c98059291fff433d2f5128838675a43f7ab105::djerk {
    struct DJERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJERK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6512f87917fdf08a675ff8181bf37ee5c80e17525ea63bf72b45463e09e74b92                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DJERK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DJERK       ")))), trim_right(b"DickJerky                       "), trim_right(x"42726f7567687420746f20796f752062792032204e6f6e2d566567616e732e0a496e6772656469656e747320666f72206120444a45524b204578706c6f73696f6e3a20207374617274207769746820612064617368206f6620736d617274732c206164642062756e6368206f6620536f6c20746f2061206c65617374206f6e652068616e642066756c6c206f66206469636b206a65726b792061206461792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJERK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJERK>>(v4);
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

