module 0x4f96fe132a8108881452047f72f713ff3271e24e30c441eda0656e84152d1e51::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ec9685f5cd6541e67e5dc09d7504e7e5906d215dece2856e4473567f725b18ab                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XXX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XXX         ")))), trim_right(b"XXX AI                          "), trim_right(x"5858582041492069732061207261772c20756e63656e736f7265642c2066756c6c79204e53465720766f6963652041492e2043686174207769746820796f7572206661766f7269746520706f726e7374617220616e642066756c66696c6c20796f75722077696c646573742066616e7461736965732e0a0a5469657265642041636365737320746f206f7572204149204261736564206f6e2057616c6c657420486f6c64696e6773200a0a2042617369632054696572202846524545290a4c696d697465642061636365737320746f206f757220626173696320756e63656e736f72656420766f6963652041492e0a0a2042726f6e7a6520546965722028354d2024585858290a556e6c696d697465642061636365737320746f206f757220756e63656e736f72656420766f6963652041490a0a2053696c7665722054696572"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v4);
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

