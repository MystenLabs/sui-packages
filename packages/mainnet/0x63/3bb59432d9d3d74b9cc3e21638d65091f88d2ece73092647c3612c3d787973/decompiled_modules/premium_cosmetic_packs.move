module 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic_packs {
    struct PremiumCosmeticPackMinted has copy, drop {
        recipient: address,
        content_ids: vector<0x1::string::String>,
        minter: address,
    }

    struct PremiumCosmeticPackRequest has drop, store {
        price: u64,
        recipient: address,
        items: vector<PremiumCosmeticPackItemRequest>,
        nonce: vector<u8>,
        timestamp: u64,
    }

    struct PremiumCosmeticPackItemRequest has drop, store {
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        description: 0x1::string::String,
        content_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun mint_premium_cosmetic_pack_with_koju(arg0: vector<0x2::token::Token<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>>, arg1: &mut 0x2::token::TokenPolicy<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::MintAuthority, arg5: &0x2::clock::Clock, arg6: &mut 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::UsedNonces, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x1::vector::empty<PremiumCosmeticPackItemRequest>();
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v5 = 0;
            while (v5 < 0x2::bcs::peel_vec_length(&mut v0)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)));
                v5 = v5 + 1;
            };
            let v6 = PremiumCosmeticPackItemRequest{
                name          : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                image_url     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                thumbnail_url : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                description   : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                content_id    : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                attributes    : v4,
            };
            0x1::vector::push_back<PremiumCosmeticPackItemRequest>(&mut v2, v6);
            v3 = v3 + 1;
        };
        let v7 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v8 = 0x2::bcs::peel_u64(&mut v0);
        assert!(v1 > 0, 1);
        let v9 = PremiumCosmeticPackRequest{
            price     : v1,
            recipient : 0x2::bcs::peel_address(&mut v0),
            items     : v2,
            nonce     : v7,
            timestamp : v8,
        };
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::check_and_mark_nonce(&v7, v8, arg5, arg6);
        assert!(0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::verify_ed25519_signature<PremiumCosmeticPackRequest>(&v9, &arg3, arg4), 0);
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::spend_koju(arg0, arg1, v9.price, arg7);
        let v10 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::vector::is_empty<PremiumCosmeticPackItemRequest>(&v9.items)) {
            let v11 = 0x1::vector::pop_back<PremiumCosmeticPackItemRequest>(&mut v9.items);
            let v12 = 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic::create_premium_cosmetic(v11.name, v11.image_url, v11.thumbnail_url, v11.description, v11.content_id, v11.attributes, arg7);
            0x1::vector::push_back<0x1::string::String>(&mut v10, v11.content_id);
            0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic::emit_premium_cosmetic_minted_event(0x2::object::id<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic::PremiumCosmetic>(&v12), v9.recipient, v11.content_id, 0x2::tx_context::sender(arg7));
            0x2::transfer::public_transfer<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic::PremiumCosmetic>(v12, v9.recipient);
        };
        let v13 = PremiumCosmeticPackMinted{
            recipient   : v9.recipient,
            content_ids : v10,
            minter      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<PremiumCosmeticPackMinted>(v13);
    }

    // decompiled from Move bytecode v7
}

