module 0xd4e4e630df3ac54341b11a055f90ea677cd0117c61159668a311fd2590dc914f::helpcoinaa {
    struct HELPCOINAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELPCOINAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/RUhPQMTK5QPhLAC9FhwxvB4BSU9f7SfV56Pfvmjpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HELPCOINAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Helpcoin    ")))), trim_right(b"Help coin                       "), trim_right(x"41626f7574207468652050726f6a6563740a0a546869732070726f6a65637420776173206372656174656420746f2068656c702070656f706c652077686f2061726520676f696e67207468726f75676820646966666963756c74206c69666520736974756174696f6e732e204173207468652063726561746f722c204920616d20666163696e6720736572696f7573206368616c6c656e6765732c20696e636c7564696e672074686520746872656174206f6620696d707269736f6e6d656e742c20616e6420492077696c6c207368617265207468652066756c6c2073746f7279207769746820796f7520736f6f6e2e20496e20746869732070726f6a6563742c2074686572652077696c6c206265206e6f20616767726573736976652073616c65732066726f6d20746865207465616d2e20496e73746561642c2077652066"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELPCOINAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELPCOINAA>>(v4);
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

