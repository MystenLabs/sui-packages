module 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::premium_cosmetic {
    struct PremiumCosmeticMinted has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        content_id: 0x1::string::String,
        minter: address,
    }

    struct PremiumCosmeticSentToKiosk has copy, drop {
        id: 0x2::object::ID,
        from: address,
        recipient: address,
        kiosk_id: 0x2::object::ID,
        content_id: 0x1::string::String,
    }

    struct PremiumCosmeticDelisted has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct PREMIUM_COSMETIC has drop {
        dummy_field: bool,
    }

    struct PremiumCosmetic has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        description: 0x1::string::String,
        content_id: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintPremiumCosmeticRequest has drop {
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

    struct AdminMintPremiumCosmeticRequest has drop {
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

    struct TransferCosmeticRequest has drop {
        price: u64,
        content_id: 0x1::string::String,
        object_id: address,
        nonce: vector<u8>,
        timestamp: u64,
        from: address,
        to: address,
    }

    public fun admin_mint_premium_cosmetic(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: address, arg7: vector<u8>, arg8: &0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::MintAuthority, arg9: vector<u8>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::UsedNonces, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminMintPremiumCosmeticRequest{
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
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::check_and_mark_nonce(&arg9, arg10, arg11, arg12);
        assert!(0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::verify_ed25519_signature<AdminMintPremiumCosmeticRequest>(&v0, &arg7, arg8), 0);
        let v1 = create_premium_cosmetic(v0.name, v0.image_url, v0.thumbnail_url, v0.description, v0.content_id, v0.attributes, arg13);
        emit_premium_cosmetic_minted_event(0x2::object::id<PremiumCosmetic>(&v1), v0.recipient, v0.content_id, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<PremiumCosmetic>(v1, v0.recipient);
    }

    public(friend) fun create_premium_cosmetic(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : PremiumCosmetic {
        PremiumCosmetic{
            id            : 0x2::object::new(arg6),
            name          : arg0,
            image_url     : arg1,
            thumbnail_url : arg2,
            description   : arg3,
            content_id    : arg4,
            attributes    : arg5,
        }
    }

    public fun delist_with_event(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::kiosk::delist<PremiumCosmetic>(arg0, arg1, arg2);
        let v0 = PremiumCosmeticDelisted{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            item_id  : arg2,
        };
        0x2::event::emit<PremiumCosmeticDelisted>(v0);
    }

    public(friend) fun emit_premium_cosmetic_minted_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: address) {
        let v0 = PremiumCosmeticMinted{
            id         : arg0,
            recipient  : arg1,
            content_id : arg2,
            minter     : arg3,
        };
        0x2::event::emit<PremiumCosmeticMinted>(v0);
    }

    fun init(arg0: PREMIUM_COSMETIC, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://warped.games/store/premium-cosmetics/{content_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://warped.games"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Warped Games"));
        let v4 = 0x2::package::claim<PREMIUM_COSMETIC>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PremiumCosmetic>(&v4, v0, v2, arg1);
        0x2::display::update_version<PremiumCosmetic>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PremiumCosmetic>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun lock_cosmetic_with_koju(arg0: PremiumCosmetic, arg1: vector<0x2::token::Token<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>>, arg2: &mut 0x2::token::TokenPolicy<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>, arg3: &0x2::transfer_policy::TransferPolicy<PremiumCosmetic>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: address, arg8: vector<u8>, arg9: &0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::MintAuthority, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::UsedNonces, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 1);
        let v0 = 0x2::object::id<PremiumCosmetic>(&arg0);
        let v1 = TransferCosmeticRequest{
            price      : arg6,
            content_id : arg0.content_id,
            object_id  : 0x2::object::id_to_address(&v0),
            nonce      : arg10,
            timestamp  : arg11,
            from       : 0x2::tx_context::sender(arg14),
            to         : arg7,
        };
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::check_and_mark_nonce(&arg10, arg11, arg12, arg13);
        assert!(0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::verify_ed25519_signature<TransferCosmeticRequest>(&v1, &arg8, arg9), 0);
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::spend_koju(arg1, arg2, arg6, arg14);
        0x2::kiosk::lock<PremiumCosmetic>(arg4, arg5, arg3, arg0);
        let v2 = PremiumCosmeticSentToKiosk{
            id         : v0,
            from       : 0x2::tx_context::sender(arg14),
            recipient  : arg7,
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            content_id : v1.content_id,
        };
        0x2::event::emit<PremiumCosmeticSentToKiosk>(v2);
    }

    public fun mint_premium_cosmetic_with_koju(arg0: vector<0x2::token::Token<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>>, arg1: &mut 0x2::token::TokenPolicy<0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::KOJU>, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg9: address, arg10: vector<u8>, arg11: &0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::MintAuthority, arg12: vector<u8>, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::UsedNonces, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = MintPremiumCosmeticRequest{
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
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::nonces::check_and_mark_nonce(&arg12, arg13, arg14, arg15);
        assert!(0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::mint_authority::verify_ed25519_signature<MintPremiumCosmeticRequest>(&v0, &arg10, arg11), 0);
        0x633bb59432d9d3d74b9cc3e21638d65091f88d2ece73092647c3612c3d787973::koju::spend_koju(arg0, arg1, v0.price, arg16);
        let v1 = create_premium_cosmetic(v0.name, v0.image_url, v0.thumbnail_url, v0.description, v0.content_id, v0.attributes, arg16);
        emit_premium_cosmetic_minted_event(0x2::object::id<PremiumCosmetic>(&v1), v0.recipient, v0.content_id, 0x2::tx_context::sender(arg16));
        0x2::transfer::public_transfer<PremiumCosmetic>(v1, v0.recipient);
    }

    // decompiled from Move bytecode v7
}

