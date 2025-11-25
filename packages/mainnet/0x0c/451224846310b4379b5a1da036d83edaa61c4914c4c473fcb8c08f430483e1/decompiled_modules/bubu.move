module 0xc451224846310b4379b5a1da036d83edaa61c4914c4c473fcb8c08f430483e1::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1a445eccf082f67936e16400ada9c7ef0e27b0b85bc7b9e83e35e6f34db6c1bf                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUBU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUBU        ")))), trim_right(b"BUBU COIN                       "), trim_right(x"43757465206368616f73206f6e2074686520626c6f636b636861696e200a5468652074696e79206772656d6c696e2077697468206d617373697665206d6f6f6e20656e657267792e0a23425542552020426f726e20746f20627265616b2074686520696e7465726e65742e0a446f6e74207361792049206469646e74207761726e20796f752e0a5468652074696e79206772656d6c696e2069732077616b696e672075700a244255425520736561736f6e20697320686572652e200a5468652024425542552061726d792069732067726f77696e6720666173742e0a4a6f696e207573206e6f77206f72206368617365206c617465722e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBU>>(v4);
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

