module 0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::display {
    struct DISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISPLAY>(arg0, arg1);
        let v1 = 0x2::display::new<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&v0, arg1);
        0x2::display::add<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1, 0x1::string::utf8(b"image"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://sui.io"));
        0x2::display::update_version<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xa706f41fae7b9918ce1e73fe6baf82525f8b1e04aad55c5961b3052ec8839376::nfttest_tests::DevNetNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

