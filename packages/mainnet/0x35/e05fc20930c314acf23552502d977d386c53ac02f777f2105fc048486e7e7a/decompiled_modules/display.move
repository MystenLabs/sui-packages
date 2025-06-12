module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::display {
    fun NFT2_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT2>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"treasury_address"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Artist"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT2 Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh_jRcCOxXj0vreIAqUDqW1z1wz61kPyltrYiBUBuDfUR3tP8TY4XvU55FUat24pDgNuA&usqp=CAU"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"LA Com-EYE-con Guy"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.testproject.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"testproject"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentified"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5%"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0xb73f130f70ce3fda909699b2978da240d73d1c6c85a2ef3624819b42641bd681"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"snow girl"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a92032303234206e6674"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-MA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        let v4 = 0x2::display::new_with_fields<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT2>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT2>>(&mut v4);
        v4
    }

    fun nft1_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT1>> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"intellectual_property"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"category"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sub_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"royalty"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"treasury_address"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Artist"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"copyright"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"age_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"NFT1 Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMGJ97IOwWg54lkYPYgnn9mQx1UIkdJHL4bS3w10Ok3sKIEGLvim3QTkbNEJRLy6m0xec&usqp=CAU"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYE-dea Man"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.testproject.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"testproject"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"nft"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Collectible"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Portrait"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"EYEdentified"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5%"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0xb73f130f70ce3fda909699b2978da240d73d1c6c85a2ef3624819b42641bd681"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"snow girl"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"c2a92032303234206e6674"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"TV-MA"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Limited"));
        let v4 = 0x2::display::new_with_fields<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT1>>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT1>>(&mut v4);
        v4
    }

    public(friend) fun setup_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::Counter>(arg0), 0);
        let v0 = nft1_display(arg0, arg1);
        let v1 = NFT2_display(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT1>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::Portrait<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT2>>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

