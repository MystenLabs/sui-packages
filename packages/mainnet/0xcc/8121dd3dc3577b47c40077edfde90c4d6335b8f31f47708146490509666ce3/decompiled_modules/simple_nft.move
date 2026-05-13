module 0xcc8121dd3dc3577b47c40077edfde90c4d6335b8f31f47708146490509666ce3::simple_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<NFT>(&mut v9, &v8);
        let v10 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v10);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v8, v10);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v9);
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : NFT {
        NFT{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        }
    }

    public fun mint_to(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(mint(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    // decompiled from Move bytecode v7
}

