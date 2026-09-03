module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::humming {
    struct HUMMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMMING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HUMMING>(arg0, arg1);
        let v1 = 0x2::display::new<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>(&v0, arg1);
        0x2::display::add<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"@{name}"));
        0x2::display::add<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Humming username @{name}. Holding this object is ownership of the name."));
        0x2::display::update_version<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform::new(0, v4, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v4);
        0x2::transfer::public_transfer<0x2::display::Display<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>>(v1, v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace::Username>>(v3, v4);
    }

    // decompiled from Move bytecode v7
}

