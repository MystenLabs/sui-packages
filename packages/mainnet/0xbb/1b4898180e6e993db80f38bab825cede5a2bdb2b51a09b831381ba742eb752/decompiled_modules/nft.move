module 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::nft {
    struct NewNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_hash: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        minter: address,
        mint_timestampms: u64,
    }

    struct RevealedNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
        revealer: address,
        revealer_payout: u64,
        minter_payout: u64,
    }

    struct WWWNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_hash: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        minter: address,
        mint_timestampms: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://walrus.tusky.io/{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WWWNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<WWWNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WWWNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_revealed(arg0: &WWWNFT) : bool {
        let v0 = 0x1::string::utf8(b"revealed");
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0) == 0x1::string::utf8(b"true")
    }

    public fun mint(arg0: &mut 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<WWWNFT>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::is_minted_nft_by_walrus_hash(arg0, arg2), 0);
        let v0 = WWWNFT{
            id               : 0x2::object::new(arg8),
            name             : arg1,
            image_hash       : arg2,
            description      : arg3,
            project_url      : 0x1::string::utf8(b"https://coin.worldwidewalrus.com"),
            minter           : 0x2::tx_context::sender(arg8),
            mint_timestampms : 0x2::clock::timestamp_ms(arg7),
            attributes       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v1 = NewNftEvent{
            nft_id           : 0x2::object::id<WWWNFT>(&v0),
            name             : arg1,
            image_hash       : arg2,
            description      : arg3,
            project_url      : v0.project_url,
            minter           : v0.minter,
            mint_timestampms : v0.mint_timestampms,
        };
        0x2::event::emit<NewNftEvent>(v1);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"revealed"), 0x1::string::utf8(b"false"));
        0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::add_minted_nft(arg0, 0x2::object::id<WWWNFT>(&v0), arg2, 0x2::clock::timestamp_ms(arg7));
        0x2::kiosk::lock<WWWNFT>(arg4, arg5, arg6, v0);
    }

    entry fun reveal(arg0: &mut 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::Config, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::clock::Clock, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<WWWNFT>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg1);
        assert!(!is_revealed(v0), 0);
        assert!(0x2::clock::timestamp_ms(arg4) > v0.mint_timestampms + 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::get_time_to_reveal(arg0), 1);
        assert!(!0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::is_blacklisted_nft(arg0, arg1), 2);
        assert!(0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::is_finalized_proposal(arg0, arg1), 3);
        let v1 = 0x2::random::new_generator(arg5, arg6);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::get_min_payout(arg0), 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::get_max_payout(arg0));
        let v3 = 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config::payout(arg0, v2, arg6);
        let v4 = 0x1::string::utf8(b"revealed");
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.attributes, &v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(b"revealed"), 0x1::string::utf8(b"true"));
        let v7 = v2 / 10;
        let v8 = RevealedNftEvent{
            nft_id          : 0x2::object::id<WWWNFT>(v0),
            revealer        : 0x2::tx_context::sender(arg6),
            revealer_payout : v2 - v7,
            minter_payout   : v7,
        };
        0x2::event::emit<RevealedNftEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>>(0x2::coin::split<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut v3, v7, arg6), v0.minter);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>>(v3, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

