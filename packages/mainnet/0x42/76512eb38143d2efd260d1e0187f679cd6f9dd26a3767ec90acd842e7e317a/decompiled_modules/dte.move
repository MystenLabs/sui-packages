module 0x4276512eb38143d2efd260d1e0187f679cd6f9dd26a3767ec90acd842e7e317a::dte {
    struct DTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ab99f5657187bf2771d22228c7875781b62ca669756e4866801a9040bcd6c325                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DTE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DTE         ")))), trim_right(b"Donald Trump Era                "), trim_right(x"54686973206973206d6f7265207468616e206120636f696e2c207468697320697320616e20657261206f66206120636f696e2c2074686520657261206f6620706f6c69746963732c2054484520444f4e414c44205452554d50204552412023445472756d704572610a0a5468697320636f696e2773206c6f72652077696c6c2062652061637469766520666f7220746865206e65787420342079656172732c207769746820656e646c657373206e6577732066726f6d205472756d702e2054686973206973206e6f206c6f6e676572205550746f6d6f626572206f72204d6f6f6e76656d626572206974277320445445206d6f6e7468206576657279206d6f6e74682e200a0a546865206f6e6c79207175657374696f6e2077686174206572612077696c6c2069742062653f205468652050656163656d616b6572204572612c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTE>>(v4);
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

