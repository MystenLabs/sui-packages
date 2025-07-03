module 0x246d19f0e524457cf65424ce40b79b139298cea2f935db2ce28e2b1045f0f4f::nft {
    struct PoapNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        event_key: 0x1::string::String,
        description: 0x1::string::String,
        image_path: 0x1::string::String,
        created_by: address,
        created_at: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PoapNFT {
        PoapNFT{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            event_key   : arg1,
            description : arg2,
            image_path  : arg3,
            created_by  : 0x2::tx_context::sender(arg5),
            created_at  : 0x2::clock::timestamp_ms(arg4),
        }
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suipo.app/events/{event_key}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://assets.suipo.app/{image_path}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suipo.app/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui POAP"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PoapNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<PoapNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PoapNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun uid_mut_as_owner(arg0: &mut PoapNFT) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

