module 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::display {
    public entry fun init_display(arg0: &mut 0x2::display::Display<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"#{token_id} {name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Euterpe IP NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeidwp32l3htpl7xu2wts2olrcx2hzyjqoujnskjtl5tjlw6vkspylu/{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://eut.io"));
        update_display(arg0, v0, v2, arg1);
    }

    public entry fun update_display(arg0: &mut 0x2::display::Display<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg1, v1);
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(arg0), &v2)) {
                if (0x1::string::is_empty(&v3)) {
                    0x2::display::remove<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(arg0, v2);
                } else {
                    0x2::display::edit<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(arg0, v2, v3);
                };
            } else {
                0x2::display::add<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(arg0, v2, v3);
            };
            v1 = v1 + 1;
        };
        0x2::display::update_version<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(arg0);
    }

    // decompiled from Move bytecode v6
}

