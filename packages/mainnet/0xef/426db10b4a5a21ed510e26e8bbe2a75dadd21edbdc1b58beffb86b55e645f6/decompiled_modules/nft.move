module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct VaultzNFT has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        rarity: u8,
        token_allocation: u64,
        nft_number: u64,
        tokens_claimed: u64,
        yield_claimed: u64,
        last_yield_snapshot: u64,
        image_svg: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun id(arg0: &VaultzNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_yield_claimed(arg0: &mut VaultzNFT, arg1: u64) {
        arg0.yield_claimed = arg0.yield_claimed + arg1;
    }

    public entry fun claim_vested_tokens(arg0: &mut VaultzNFT, arg1: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.launch_id == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0);
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::status(arg1) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_live(), 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::pool_activated_at_ms(arg1);
        let v2 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::vesting_duration_ms(arg1);
        let v3 = if (v0 > v1) {
            v0 - v1
        } else {
            0
        };
        let v4 = if (v3 >= v2) {
            0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator()
        } else {
            v3 * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator() / v2
        };
        let v5 = arg0.token_allocation * v4 / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator();
        let v6 = if (v5 > arg0.tokens_claimed) {
            v5 - arg0.tokens_claimed
        } else {
            0
        };
        arg0.tokens_claimed = arg0.tokens_claimed + v6;
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_tokens_vested(arg0.launch_id, 0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), v6);
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
        0x2::transfer::public_transfer<0x2::display::Display<VaultzNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun last_yield_snapshot(arg0: &VaultzNFT) : u64 {
        arg0.last_yield_snapshot
    }

    public fun launch_id(arg0: &VaultzNFT) : 0x2::object::ID {
        arg0.launch_id
    }

    public entry fun mint(arg0: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::GlobalConfig, arg1: &mut 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::is_paused(arg0), 0);
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::status(arg1) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::status_funding(), 200);
        let v0 = if (arg2 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::rarity_mythic()) {
            true
        } else if (arg2 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::rarity_rare()) {
            true
        } else {
            arg2 == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::rarity_common()
        };
        assert!(v0, 203);
        let v1 = 0x2::tx_context::sender(arg5);
        if (0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::whitelist_enabled(arg1)) {
            assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::is_whitelisted(arg1, v1), 201);
        };
        let v2 = token_allocation_for_rarity(arg2);
        let v3 = mint_price_for_rarity(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v3, 204);
        assert!(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::wallet_allocation(arg1, v1) + v2 <= 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::total_supply() * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::depositor_alloc_bps() / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator() * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::max_wallet_bps() / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator(), 202);
        let v4 = v3 * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::platform_fee_bps() / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator();
        let v5 = v3 * 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::creator_fee_bps() / 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::bps_denominator();
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4, arg5), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::platform_treasury(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg5), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::creator(arg1));
        let v6 = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::nft_count(arg1) + 1;
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::record_mint(arg1, v1, v3, v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3 - v4 - v5, arg5), arg4);
        let v7 = if (0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::nft_type(arg1) == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config::nft_type_dynamic()) {
            0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::svg::generate_dynamic(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::name(arg1), arg2, v2, v6, 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::total_raised(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::goal(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::nft_count(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::status(arg1))
        } else {
            0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::svg::generate_static(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::name(arg1), arg2, v2, v6)
        };
        if (arg2 == 0) {
        };
        let v8 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v8, *0x1::string::bytes(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::name(arg1)));
        0x1::vector::append<u8>(&mut v8, b" #");
        0x1::vector::append<u8>(&mut v8, num_to_bytes(v6));
        let v9 = 0x2::object::new(arg5);
        let v10 = VaultzNFT{
            id                  : v9,
            launch_id           : 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1),
            rarity              : arg2,
            token_allocation    : v2,
            nft_number          : v6,
            tokens_claimed      : 0,
            yield_claimed       : 0,
            last_yield_snapshot : 0,
            image_svg           : v7,
            name                : 0x1::string::utf8(v8),
            description         : *0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::name(arg1),
        };
        0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events::emit_nft_minted(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0x2::object::uid_to_inner(&v9), v1, v2, arg2, v3);
        0x2::transfer::transfer<VaultzNFT>(v10, v1);
    }

    public fun mint_price_for_rarity(arg0: u8) : u64 {
        if (arg0 == 0) {
            5000000000
        } else if (arg0 == 1) {
            2000000000
        } else {
            500000000
        }
    }

    public fun nft_number(arg0: &VaultzNFT) : u64 {
        arg0.nft_number
    }

    fun num_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun rarity(arg0: &VaultzNFT) : u8 {
        arg0.rarity
    }

    public entry fun refresh_image(arg0: &mut VaultzNFT, arg1: &0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::VaultLaunch) {
        assert!(arg0.launch_id == 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::id(arg1), 0);
        arg0.image_svg = 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::svg::generate_dynamic(0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::name(arg1), arg0.rarity, arg0.token_allocation, arg0.nft_number, 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::total_raised(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::goal(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::nft_count(arg1), 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::launch::status(arg1));
    }

    public fun set_last_yield_snapshot(arg0: &mut VaultzNFT, arg1: u64) {
        arg0.last_yield_snapshot = arg1;
    }

    public fun token_allocation(arg0: &VaultzNFT) : u64 {
        arg0.token_allocation
    }

    public fun token_allocation_for_rarity(arg0: u8) : u64 {
        if (arg0 == 0) {
            4000000000000000
        } else if (arg0 == 1) {
            800000000000000
        } else {
            200000000000000
        }
    }

    public fun tokens_claimed(arg0: &VaultzNFT) : u64 {
        arg0.tokens_claimed
    }

    public fun yield_claimed(arg0: &VaultzNFT) : u64 {
        arg0.yield_claimed
    }

    // decompiled from Move bytecode v7
}

