module 0x9586546450db1f34c1c9d645bc63372b6277c2947f3cc65a9665a3246b6230dc::nft {
    struct Hero has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun batch_mint(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = Hero{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<Hero>(v1, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PHANTOM VOUCHER"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://phantomsui.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeih774xs5hhuq7li73evqbhraga2ufyu47bvl7n5th7dbxpwypkf7u.ipfs.w3s.link/PVOUCHER.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"f09f8c90207375697068616e746f6d2e636f6d202d206f6e2074686973207369746520796f752077696c6c2062652061626c6520746f20636f6e7665727420796f757220766f756368657220696e746f2053554920746f6b656e7320616674657220746865206f6666696369616c2072656c65617365206f6620746865206e6574776f726b20696e207068616e746f6d2077616c6c6574212054686973204e465420697320616e2053554920746f6b656e20766f7563686572206372656174656420746f2063656c6562726174652074686520736f6f6e2d746f2d62652d6c61756e6368656420535549206e6574776f726b20696e205068616e746f6d2057616c6c65742e"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://phantomsui.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Phantom Wallet"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Hero{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Hero>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

