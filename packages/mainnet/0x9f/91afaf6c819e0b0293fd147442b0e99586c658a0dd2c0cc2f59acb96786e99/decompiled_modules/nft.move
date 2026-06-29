module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct SuiArtNFT has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        creator: address,
        trait_collection_id: 0x2::object::ID,
        trait_indices: vector<u8>,
        evolution_state: u8,
        token_allocation: u64,
        nft_number: u64,
        tokens_claimed: u64,
        yield_claimed: u64,
        last_yield_snapshot: u64,
        image_svg: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public(friend) fun add_yield_claimed(arg0: &mut SuiArtNFT, arg1: u64) {
        arg0.yield_claimed = arg0.yield_claimed + arg1;
    }

    entry fun claim_vested_tokens<T0>(arg0: &mut SuiArtNFT, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.launch_id == 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1), 205);
        let v1 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::pool_activated_at_ms<T0>(arg1);
        if (v1 == 0) {
            return
        };
        let v2 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::vesting_duration_ms<T0>(arg1);
        let v3 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v4 = if (v2 > 0) {
            let v5 = (v3 as u128) * 100 / (v2 as u128);
            if (v5 > 100) {
                100
            } else {
                (v5 as u64)
            }
        } else {
            100
        };
        let v6 = arg0.token_allocation;
        let v7 = (((v6 as u128) * (v4 as u128) / 100) as u64);
        let v8 = if (v7 > arg0.tokens_claimed) {
            v7 - arg0.tokens_claimed
        } else {
            0
        };
        if (v8 > 0) {
            arg0.tokens_claimed = arg0.tokens_claimed + v8;
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_tokens_vested(0x2::object::uid_to_inner(&arg0.id), 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1), 0x2::tx_context::sender(arg3), v8, v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::withdraw_holder_tokens<T0>(arg1, v8, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun compute_evolution_state<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg1: u64) : u8 {
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::stage<T0>(arg0)
    }

    fun compute_vesting_pct<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg1: u64) : u64 {
        let v0 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::pool_activated_at_ms<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::vesting_duration_ms<T0>(arg0);
        if (v1 == 0) {
            return 100
        };
        let v2 = if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        };
        let v3 = v2 * 100 / v1;
        if (v3 > 100) {
            100
        } else {
            v3
        }
    }

    fun do_mint<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::GlobalConfig, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::is_paused(arg0), 200);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::stage<T0>(arg1) == 0, 201);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::nft_count<T0>(arg1) < 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::max_supply<T0>(arg1), 202);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::is_whitelisted<T0>(arg1, v0), 203);
        let v1 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::mint_price<T0>(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v1, 204);
        let v2 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::launch_id(arg2) == v2, 206);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::is_finalized(arg2), 207);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        if (v3 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3 - v1, arg6), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1 * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::platform_fee_bps() / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator(), arg6), 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::get_platform_treasury(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1 * 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::creator_fee_bps() / 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::bps_denominator(), arg6), 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::creator<T0>(arg1));
        let v4 = 0x2::random::new_generator(arg3, arg6);
        let v5 = b"";
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::num_categories(arg2)) {
            let v8 = &mut v4;
            let v9 = pick_weighted(v8, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::get_category(arg2, v7));
            0x1::vector::push_back<u8>(&mut v5, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::get_svg_layer(arg2, v7, (v9 as u64), 0));
            v7 = v7 + 1;
        };
        let v10 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::goal<T0>(arg1);
        let v11 = if (v10 > 0) {
            let v12 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::total_raised<T0>(arg1) * 100 / v10;
            if (v12 > 100) {
                100
            } else {
                v12
            }
        } else {
            0
        };
        let v13 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::nft_count<T0>(arg1) + 1;
        let v14 = *0x1::string::as_bytes(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::name<T0>(arg1));
        0x1::vector::append<u8>(&mut v14, b" #");
        0x1::vector::append<u8>(&mut v14, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::svg::u64_to_bytes(v13));
        let v15 = 0x2::object::new(arg6);
        let v16 = SuiArtNFT{
            id                  : v15,
            launch_id           : v2,
            creator             : 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::creator<T0>(arg1),
            trait_collection_id : 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::id(arg2),
            trait_indices       : v5,
            evolution_state     : 0,
            token_allocation    : 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::record_mint<T0>(arg1, v0, v1, arg4, arg5),
            nft_number          : v13,
            tokens_claimed      : 0,
            yield_claimed       : 0,
            last_yield_snapshot : 0,
            image_svg           : 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::svg::compose_nft_svg(v6, 0, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::name<T0>(arg1), v13, v11, 0),
            name                : 0x1::string::utf8(v14),
            description         : *0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::description_ref<T0>(arg1),
        };
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_nft_minted(0x2::object::uid_to_inner(&v15), v2, v0, v13, v1);
        0x2::transfer::public_transfer<SuiArtNFT>(v16, v0);
    }

    entry fun fix_image_uri(arg0: &mut SuiArtNFT) {
        let v0 = 0x1::string::as_bytes(&arg0.image_svg);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = b"data:image/svg+xml;utf8,";
        let v3 = 0x1::vector::length<u8>(&v2);
        if (v1 < v3) {
            return
        };
        let v4 = 0;
        while (v4 < v3) {
            if (*0x1::vector::borrow<u8>(v0, v4) != *0x1::vector::borrow<u8>(&v2, v4)) {
                return
            };
            v4 = v4 + 1;
        };
        let v5 = b"data:image/svg+xml;charset=utf-8,";
        while (v3 < v1) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v0, v3));
            v3 = v3 + 1;
        };
        arg0.image_svg = 0x1::string::utf8(v5);
    }

    entry fun fix_percent_encoding(arg0: &mut SuiArtNFT) {
        let v0 = 0x1::string::as_bytes(&arg0.image_svg);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = b"";
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            if (v4 == 37) {
                let v5 = if (v3 + 2 < v1) {
                    if (is_hex_byte(*0x1::vector::borrow<u8>(v0, v3 + 1))) {
                        is_hex_byte(*0x1::vector::borrow<u8>(v0, v3 + 2))
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v5) {
                    0x1::vector::push_back<u8>(&mut v2, v4);
                } else {
                    0x1::vector::push_back<u8>(&mut v2, 37);
                    0x1::vector::push_back<u8>(&mut v2, 50);
                    0x1::vector::push_back<u8>(&mut v2, 53);
                };
            } else {
                0x1::vector::push_back<u8>(&mut v2, v4);
            };
            v3 = v3 + 1;
        };
        arg0.image_svg = 0x1::string::utf8(v2);
    }

    public fun image_svg(arg0: &SuiArtNFT) : &0x1::string::String {
        &arg0.image_svg
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<SuiArtNFT>(&v0, arg1);
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_svg}"));
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiart.xyz"));
        0x2::display::add<SuiArtNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://suiart.xyz/collection/{launch_id}"));
        0x2::display::update_version<SuiArtNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<SuiArtNFT>(&v0, arg1);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v4);
        0x2::transfer::public_transfer<0x2::display::Display<SuiArtNFT>>(v1, v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiArtNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiArtNFT>>(v3, v4);
    }

    fun is_hex_byte(arg0: u8) : bool {
        if (arg0 >= 48 && arg0 <= 57) {
            true
        } else if (arg0 >= 65 && arg0 <= 70) {
            true
        } else {
            arg0 >= 97 && arg0 <= 102
        }
    }

    public fun last_yield_snapshot(arg0: &SuiArtNFT) : u64 {
        arg0.last_yield_snapshot
    }

    entry fun mint<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::GlobalConfig, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::nft_count<T0>(arg1) + 1 < 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::max_supply<T0>(arg1), 208);
        do_mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun mint_final<T0>(arg0: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config::GlobalConfig, arg1: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::phronis_amm::PhronisRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::nft_count<T0>(arg1) + 1 == 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::max_supply<T0>(arg1), 209);
        do_mint<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::locked_lp::do_settle<T0>(arg5, arg1, arg6, arg7);
    }

    public fun nft_evolution_state(arg0: &SuiArtNFT) : u8 {
        arg0.evolution_state
    }

    public fun nft_id(arg0: &SuiArtNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun nft_launch_id(arg0: &SuiArtNFT) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun nft_number(arg0: &SuiArtNFT) : u64 {
        arg0.nft_number
    }

    public fun nft_trait_collection_id(arg0: &SuiArtNFT) : 0x2::object::ID {
        arg0.trait_collection_id
    }

    public fun nft_trait_indices(arg0: &SuiArtNFT) : &vector<u8> {
        &arg0.trait_indices
    }

    fun pick_weighted(arg0: &mut 0x2::random::RandomGenerator, arg1: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCategory) : u8 {
        let v0 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::category_options(arg1);
        let v1 = 0x1::vector::length<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitOption>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::option_rarity_weight(0x1::vector::borrow<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitOption>(v0, v3));
            v3 = v3 + 1;
        };
        let v4 = if (v2 > 1) {
            0x2::random::generate_u64_in_range(arg0, 0, v2 - 1)
        } else {
            0
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = v5 + 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::option_rarity_weight(0x1::vector::borrow<0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitOption>(v0, v6));
            v5 = v7;
            if (v4 < v7) {
                return (v6 as u8)
            };
            v6 = v6 + 1;
        };
        0
    }

    public fun token_allocation(arg0: &SuiArtNFT) : u64 {
        arg0.token_allocation
    }

    public fun tokens_claimed(arg0: &SuiArtNFT) : u64 {
        arg0.tokens_claimed
    }

    entry fun update_evolution<T0>(arg0: &mut SuiArtNFT, arg1: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::Launch<T0>, arg2: &0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::TraitCollection, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::id<T0>(arg1);
        assert!(arg0.launch_id == v1, 205);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::launch_id(arg2) == v1, 206);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::id(arg2) == arg0.trait_collection_id, 206);
        assert!(0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::is_finalized(arg2), 207);
        let v2 = arg0.evolution_state;
        let v3 = compute_evolution_state<T0>(arg1, v0);
        if (v3 != v2) {
            arg0.evolution_state = v3;
            let v4 = 0x1::vector::empty<0x1::string::String>();
            let v5 = 0;
            while (v5 < 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::num_categories(arg2)) {
                let v6 = if (v5 < 0x1::vector::length<u8>(&arg0.trait_indices)) {
                    *0x1::vector::borrow<u8>(&arg0.trait_indices, v5)
                } else {
                    0
                };
                0x1::vector::push_back<0x1::string::String>(&mut v4, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::traits::get_svg_layer(arg2, v5, (v6 as u64), v3));
                v5 = v5 + 1;
            };
            let v7 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::goal<T0>(arg1);
            let v8 = if (v7 > 0) {
                let v9 = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::total_raised<T0>(arg1) * 100 / v7;
                if (v9 > 100) {
                    100
                } else {
                    v9
                }
            } else {
                100
            };
            arg0.image_svg = 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::svg::compose_nft_svg(v4, v3, 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::launch::name<T0>(arg1), arg0.nft_number, v8, compute_vesting_pct<T0>(arg1, v0));
            0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events::emit_nft_evolved(0x2::object::uid_to_inner(&arg0.id), v1, v2, v3);
        };
    }

    public fun yield_claimed(arg0: &SuiArtNFT) : u64 {
        arg0.yield_claimed
    }

    // decompiled from Move bytecode v7
}

