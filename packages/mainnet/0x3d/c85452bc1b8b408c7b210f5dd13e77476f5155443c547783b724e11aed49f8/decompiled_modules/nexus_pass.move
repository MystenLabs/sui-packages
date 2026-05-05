module 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nexus_pass {
    struct NexusPassMinted has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        content_id: 0x1::string::String,
        minter: address,
    }

    struct NEXUS_PASS has drop {
        dummy_field: bool,
    }

    struct NexusPass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        description: 0x1::string::String,
        content_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintNexusPassRequest has drop {
        price: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        description: 0x1::string::String,
        content_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        nonce: vector<u8>,
        timestamp: u64,
        recipient: address,
    }

    struct AdminMintNexusPassRequest has drop {
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        description: 0x1::string::String,
        content_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        nonce: vector<u8>,
        timestamp: u64,
        recipient: address,
    }

    public fun admin_mint_nexus_pass(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: address, arg7: vector<u8>, arg8: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg9: vector<u8>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminMintNexusPassRequest{
            name          : arg0,
            image_url     : arg1,
            thumbnail_url : arg2,
            description   : arg3,
            content_id    : arg4,
            attributes    : arg5,
            nonce         : arg9,
            timestamp     : arg10,
            recipient     : arg6,
        };
        0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::check_and_mark_nonce(&arg9, arg10, arg11, arg12);
        assert!(0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::verify_ed25519_signature<AdminMintNexusPassRequest>(&v0, &arg7, arg8), 0);
        let v1 = create_nexus_pass(v0.name, v0.image_url, v0.thumbnail_url, v0.description, v0.content_id, v0.attributes, arg13);
        emit_nexus_pass_minted_event(0x2::object::id<NexusPass>(&v1), v0.recipient, v0.content_id, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<NexusPass>(v1, v0.recipient);
    }

    public(friend) fun create_nexus_pass(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : NexusPass {
        NexusPass{
            id            : 0x2::object::new(arg6),
            name          : arg0,
            image_url     : arg1,
            thumbnail_url : arg2,
            description   : arg3,
            content_id    : arg4,
            attributes    : arg5,
        }
    }

    public(friend) fun emit_nexus_pass_minted_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: address) {
        let v0 = NexusPassMinted{
            id         : arg0,
            recipient  : arg1,
            content_id : arg2,
            minter     : arg3,
        };
        0x2::event::emit<NexusPassMinted>(v0);
    }

    fun init(arg0: NEXUS_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://warped.games/store/nexus-pass/{content_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://warped.games"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Warped Games"));
        let v4 = 0x2::package::claim<NEXUS_PASS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NexusPass>(&v4, v0, v2, arg1);
        0x2::display::update_version<NexusPass>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NexusPass>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nexus_pass_with_koju(arg0: vector<0x2::token::Token<0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::koju::KOJU>>, arg1: &mut 0x2::token::TokenPolicy<0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::koju::KOJU>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: address, arg10: vector<u8>, arg11: &0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::MintAuthority, arg12: vector<u8>, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::UsedNonces, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = MintNexusPassRequest{
            price         : arg2,
            name          : arg3,
            image_url     : arg4,
            thumbnail_url : arg5,
            description   : arg6,
            content_id    : arg7,
            attributes    : arg8,
            nonce         : arg12,
            timestamp     : arg13,
            recipient     : arg9,
        };
        0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::nonces::check_and_mark_nonce(&arg12, arg13, arg14, arg15);
        assert!(0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::mint_authority::verify_ed25519_signature<MintNexusPassRequest>(&v0, &arg10, arg11), 0);
        0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::koju::spend_koju(arg0, arg1, v0.price, arg16);
        let v1 = create_nexus_pass(v0.name, v0.image_url, v0.thumbnail_url, v0.description, v0.content_id, v0.attributes, arg16);
        emit_nexus_pass_minted_event(0x2::object::id<NexusPass>(&v1), v0.recipient, v0.content_id, 0x2::tx_context::sender(arg16));
        0x2::transfer::public_transfer<NexusPass>(v1, v0.recipient);
    }

    // decompiled from Move bytecode v7
}

