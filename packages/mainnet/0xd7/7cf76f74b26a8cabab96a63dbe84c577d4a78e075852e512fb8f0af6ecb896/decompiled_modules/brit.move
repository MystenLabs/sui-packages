module 0xd77cf76f74b26a8cabab96a63dbe84c577d4a78e075852e512fb8f0af6ecb896::brit {
    struct BRIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c5e21c1b3acbb3484da6ea48683f58520583038ae8f45f584fc67e2332101bf7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRIT        ")))), trim_right(b"BritCard                        "), trim_right(x"24425249542020546865204469676974616c2049442054686579204469646e742041736b20466f720a0a41732074686520554b20726f6c6c73206f7574206469676974616c204944732c2074686520676f7665726e6d656e742077616e747320746f2070757420796f7572206e616d652c206e756d6265722c20616e64206e6f73652073697a6520696e206f6e65206e656174206c6974746c6520515220636f64652e20427574207768792073746f702074686572653f20576974682024425249542c20796f752063616e2066696e616c6c792070726f766520796f757265206120747275652042726974207468652070726f706572207761792020627920686f646c696e672061206d656d65636f696e207468617473206d6f726520736563757265207468616e2074686520486f6d65204f6666696365732057692d466920"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIT>>(v4);
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

