module 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct VaultzNFT has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        trait_collection_id: 0x2::object::ID,
        trait_indices: vector<u8>,
        evolution_state: u8,
        nft_number: u64,
        tokens_claimed: u64,
        yield_claimed: u64,
        last_yield_snapshot: u64,
        image_svg: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun add_yield_claimed(arg0: &mut VaultzNFT, arg1: u64) {
        arg0.yield_claimed = arg0.yield_claimed + arg1;
    }

    public entry fun claim_vested_tokens(arg0: &mut VaultzNFT, arg1: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.launch_id == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), 205);
        let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::pool_activated_at_ms(arg1);
        if (v1 == 0) {
            return
        };
        let v2 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::vesting_duration_ms(arg1);
        let v3 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v4 = if (v2 > 0) {
            let v5 = v3 * 100 / v2;
            if (v5 > 100) {
                100
            } else {
                v5
            }
        } else {
            100
        };
        let v6 = 40000000000000;
        let v7 = v6 * v4 / 100;
        let v8 = if (v7 > arg0.tokens_claimed) {
            v7 - arg0.tokens_claimed
        } else {
            0
        };
        if (v8 > 0) {
            arg0.tokens_claimed = arg0.tokens_claimed + v8;
            0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_tokens_vested(0x2::object::uid_to_inner(&arg0.id), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1), 0x2::tx_context::sender(arg3), v8, v6);
        };
    }

    fun compute_evolution_state(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg1: u64) : u8 {
        if (0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::status(arg0) == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis()) {
            0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis()
        } else {
            let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::pool_activated_at_ms(arg0);
            if (v1 == 0) {
                0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_awakened()
            } else {
                let v2 = if (arg1 > v1) {
                    arg1 - v1
                } else {
                    0
                };
                if (v2 >= 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::vesting_duration_ms(arg0)) {
                    0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_evolved()
                } else {
                    0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_vesting()
                }
            }
        }
    }

    fun compute_vesting_pct(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg1: u64) : u64 {
        let v0 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::pool_activated_at_ms(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::vesting_duration_ms(arg0);
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

    public fun image_svg(arg0: &VaultzNFT) : &0x1::string::String {
        &arg0.image_svg
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<VaultzNFT>(&v0, arg1);
        0x2::display::add<VaultzNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<VaultzNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<VaultzNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_svg}"));
        0x2::display::add<VaultzNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://vaultz.io"));
        0x2::display::update_version<VaultzNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VaultzNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun last_yield_snapshot(arg0: &VaultzNFT) : u64 {
        arg0.last_yield_snapshot
    }

    public entry fun mint(arg0: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::GlobalConfig, arg1: &mut 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg2: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitCollection, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::is_paused(arg0), 200);
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::status(arg1) == 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis(), 201);
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::nft_count(arg1) < 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::max_supply(arg1), 202);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::is_whitelisted(arg1, v0), 203);
        let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::mint_price(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v1, 204);
        let v2 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1);
        assert!(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::launch_id(arg2) == v2, 206);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        if (v3 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3 - v1, arg6), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1 * 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::platform_fee_bps() / 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::bps_denominator(), arg6), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::platform_treasury_addr());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v1 * 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::creator_fee_bps() / 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::bps_denominator(), arg6), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::creator(arg1));
        let v4 = 0x2::random::new_generator(arg3, arg6);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::num_categories(arg2)) {
            let v8 = &mut v4;
            let v9 = pick_weighted(v8, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::get_category(arg2, v7));
            0x1::vector::push_back<u8>(&mut v5, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::get_svg_layer(arg2, v7, (v9 as u64)));
            v7 = v7 + 1;
        };
        let v10 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::goal(arg1);
        let v11 = if (v10 > 0) {
            let v12 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::total_raised(arg1) * 100 / v10;
            if (v12 > 100) {
                100
            } else {
                v12
            }
        } else {
            0
        };
        let v13 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::nft_count(arg1) + 1;
        let v14 = *0x1::string::as_bytes(0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::name(arg1));
        0x1::vector::append<u8>(&mut v14, b" #");
        0x1::vector::append<u8>(&mut v14, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::svg::u64_to_bytes(v13));
        let v15 = 0x2::object::new(arg6);
        let v16 = VaultzNFT{
            id                  : v15,
            launch_id           : v2,
            trait_collection_id : 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::launch_id(arg2),
            trait_indices       : v5,
            evolution_state     : 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis(),
            nft_number          : v13,
            tokens_claimed      : 0,
            yield_claimed       : 0,
            last_yield_snapshot : 0,
            image_svg           : 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::svg::compose_nft_svg(v6, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::config::status_genesis(), 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::name(arg1), v13, v11, 0),
            name                : 0x1::string::utf8(v14),
            description         : *0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::description_ref(arg1),
        };
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::record_mint(arg1, v0, v1, 40000000000000, arg4, arg5);
        0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_nft_minted(0x2::object::uid_to_inner(&v15), v2, v0, v13, v1);
        0x2::transfer::public_transfer<VaultzNFT>(v16, v0);
    }

    public fun nft_evolution_state(arg0: &VaultzNFT) : u8 {
        arg0.evolution_state
    }

    public fun nft_id(arg0: &VaultzNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun nft_launch_id(arg0: &VaultzNFT) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun nft_number(arg0: &VaultzNFT) : u64 {
        arg0.nft_number
    }

    public fun nft_trait_collection_id(arg0: &VaultzNFT) : 0x2::object::ID {
        arg0.trait_collection_id
    }

    public fun nft_trait_indices(arg0: &VaultzNFT) : &vector<u8> {
        &arg0.trait_indices
    }

    fun pick_weighted(arg0: &mut 0x2::random::RandomGenerator, arg1: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitCategory) : u8 {
        let v0 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::category_options(arg1);
        let v1 = 0x1::vector::length<0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitOption>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::option_rarity_weight(0x1::vector::borrow<0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitOption>(v0, v3));
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
            let v7 = v5 + 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::option_rarity_weight(0x1::vector::borrow<0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitOption>(v0, v6));
            v5 = v7;
            if (v4 < v7) {
                return (v6 as u8)
            };
            v6 = v6 + 1;
        };
        0
    }

    public fun set_last_yield_snapshot(arg0: &mut VaultzNFT, arg1: u64) {
        arg0.last_yield_snapshot = arg1;
    }

    public fun token_allocation(arg0: &VaultzNFT) : u64 {
        40000000000000
    }

    public fun tokens_claimed(arg0: &VaultzNFT) : u64 {
        arg0.tokens_claimed
    }

    public entry fun update_evolution(arg0: &mut VaultzNFT, arg1: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::VaultLaunch, arg2: &0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::TraitCollection, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::id(arg1);
        assert!(arg0.launch_id == v1, 205);
        let v2 = arg0.evolution_state;
        let v3 = compute_evolution_state(arg1, v0);
        if (v3 != v2) {
            arg0.evolution_state = v3;
            let v4 = 0x1::vector::empty<0x1::string::String>();
            let v5 = 0;
            while (v5 < 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::num_categories(arg2)) {
                let v6 = if (v5 < 0x1::vector::length<u8>(&arg0.trait_indices)) {
                    *0x1::vector::borrow<u8>(&arg0.trait_indices, v5)
                } else {
                    0
                };
                0x1::vector::push_back<0x1::string::String>(&mut v4, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::traits::get_svg_layer(arg2, v5, (v6 as u64)));
                v5 = v5 + 1;
            };
            let v7 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::goal(arg1);
            let v8 = if (v7 > 0) {
                let v9 = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::total_raised(arg1) * 100 / v7;
                if (v9 > 100) {
                    100
                } else {
                    v9
                }
            } else {
                100
            };
            arg0.image_svg = 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::svg::compose_nft_svg(v4, v3, 0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::launch::name(arg1), arg0.nft_number, v8, compute_vesting_pct(arg1, v0));
            0xdd4abec62b40cb8e81eda4c1c45d648639bebeca7060ee419b7c4f582e27c919::events::emit_nft_evolved(0x2::object::uid_to_inner(&arg0.id), v1, v2, v3);
        };
    }

    public fun yield_claimed(arg0: &VaultzNFT) : u64 {
        arg0.yield_claimed
    }

    // decompiled from Move bytecode v7
}

