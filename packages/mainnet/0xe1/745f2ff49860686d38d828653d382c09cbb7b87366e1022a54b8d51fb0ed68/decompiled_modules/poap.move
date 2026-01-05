module 0xe1745f2ff49860686d38d828653d382c09cbb7b87366e1022a54b8d51fb0ed68::poap {
    struct POAP_NFT has key {
        id: 0x2::object::UID,
        campaign_id: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        display_url: 0x1::string::String,
    }

    struct PoapCreated has copy, drop {
        poap_id: 0x2::object::ID,
        campaign_id: u64,
        title: 0x1::string::String,
        display_url: 0x1::string::String,
    }

    struct PoapAwarded has copy, drop {
        poap_id: 0x2::object::ID,
        campaign_id: u64,
        to: address,
    }

    struct POAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{display_url}"));
        let v4 = 0x2::package::claim<POAP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<POAP_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<POAP_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<POAP_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_poap(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &0xe1745f2ff49860686d38d828653d382c09cbb7b87366e1022a54b8d51fb0ed68::campaign::OrganizerCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = POAP_NFT{
            id          : 0x2::object::new(arg6),
            campaign_id : arg0,
            title       : arg1,
            description : arg2,
            display_url : arg3,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = PoapCreated{
            poap_id     : v1,
            campaign_id : arg0,
            title       : arg1,
            display_url : arg3,
        };
        0x2::event::emit<PoapCreated>(v2);
        0x2::transfer::transfer<POAP_NFT>(v0, arg4);
        let v3 = PoapAwarded{
            poap_id     : v1,
            campaign_id : arg0,
            to          : arg4,
        };
        0x2::event::emit<PoapAwarded>(v3);
    }

    public fun mint_poap_to_addresses(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<address>, arg5: &0xe1745f2ff49860686d38d828653d382c09cbb7b87366e1022a54b8d51fb0ed68::campaign::OrganizerCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            let v1 = *0x1::vector::borrow<address>(&arg4, v0);
            let v2 = POAP_NFT{
                id          : 0x2::object::new(arg6),
                campaign_id : arg0,
                title       : arg1,
                description : arg2,
                display_url : arg3,
            };
            let v3 = 0x2::object::uid_to_inner(&v2.id);
            let v4 = PoapCreated{
                poap_id     : v3,
                campaign_id : arg0,
                title       : arg1,
                display_url : arg3,
            };
            0x2::event::emit<PoapCreated>(v4);
            0x2::transfer::transfer<POAP_NFT>(v2, v1);
            let v5 = PoapAwarded{
                poap_id     : v3,
                campaign_id : arg0,
                to          : v1,
            };
            0x2::event::emit<PoapAwarded>(v5);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

