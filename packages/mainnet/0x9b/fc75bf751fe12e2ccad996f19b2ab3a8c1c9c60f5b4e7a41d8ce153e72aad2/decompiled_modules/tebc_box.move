module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box {
    struct EmptyBox has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        level: u16,
        rarity: 0x1::option::Option<u8>,
        hashed_code: 0x1::string::String,
        original_code: 0x1::string::String,
        open: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MintTracker has key {
        id: 0x2::object::UID,
    }

    struct BOX_COLLECTION has key {
        id: 0x2::object::UID,
        owner: address,
        role_prices: vector<u64>,
        role_limits: vector<u64>,
        mint_counts: 0x2::table::Table<address, u64>,
        referral_counts: 0x2::table::Table<address, u64>,
        referral_revenues: 0x2::table::Table<address, u64>,
        referral_leaderboard: 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::ReferralLeaderboard,
        rarity_counts: vector<u16>,
        upgrade_cost: u64,
        image_storage: 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::ImageStorage,
        start_upgrade_time_ms: u64,
        start_mint_time_ms: u64,
    }

    struct NftMinted has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        serial_number: u64,
        with_referral: bool,
    }

    struct NftUpgraded has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        new_level: u16,
        rarity_revealed: 0x1::option::Option<u8>,
    }

    struct ReferralRewardEvent has copy, drop {
        referrer: address,
        reward_amount: u64,
        total_revenue_updated: u64,
        total_count_updated: u64,
        timestamp: u64,
    }

    struct NftBurned has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        serial_number: u64,
        level: u16,
    }

    struct NftTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        serial_number: u64,
    }

    struct OwnerUpdated has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct TEBC_BOX has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: EmptyBox, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = NftTransferred{
            nft_id        : 0x2::object::id<EmptyBox>(&arg0),
            from          : 0x2::tx_context::sender(arg2),
            to            : arg1,
            serial_number : arg0.serial_number,
        };
        0x2::event::emit<NftTransferred>(v0);
        0x2::transfer::public_transfer<EmptyBox>(arg0, arg1);
    }

    public fun add_nft_stages(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>, arg4: vector<vector<0x1::string::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg5);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 14);
        assert!(v0 == 0x1::vector::length<vector<0x1::string::String>>(&arg4), 14);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg3, v1);
            let v3 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v1);
            let v4 = 0x1::vector::length<u8>(v2);
            assert!(v4 == 0x1::vector::length<0x1::string::String>(v3), 14);
            let v5 = 0;
            while (v5 < v4) {
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::add_nft_stage(&mut arg1.image_storage, *0x1::vector::borrow<0x1::string::String>(&arg2, v1), *0x1::vector::borrow<u8>(v2, v5), *0x1::vector::borrow<0x1::string::String>(v3, v5));
                v5 = v5 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun add_nft_templates(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: &mut MintTracker, arg3: u8, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg7);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg4);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg2.id, b"total_nft_templates");
        *v1 = *v1 + (v0 as u64);
        let v2 = 0x1::vector::empty<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>();
        let v3 = 0;
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg5) == v0, 14);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg6) == v0, 14);
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg5, v3);
            let v5 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg6, v3);
            let v6 = 0x1::vector::length<0x1::string::String>(v4);
            assert!(0x1::vector::length<0x1::string::String>(v5) == v6, 14);
            let v7 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v8 = 0;
            while (v8 < v6) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v7, *0x1::vector::borrow<0x1::string::String>(v4, v8), *0x1::vector::borrow<0x1::string::String>(v5, v8));
                v8 = v8 + 1;
            };
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v2, v7);
            v3 = v3 + 1;
        };
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::add_items(&mut arg1.image_storage, arg3, arg4, v2);
    }

    public fun batch_burn(arg0: vector<EmptyBox>, arg1: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<EmptyBox>(&arg0)) {
            burn(0x1::vector::pop_back<EmptyBox>(&mut arg0), arg1);
        };
        0x1::vector::destroy_empty<EmptyBox>(arg0);
    }

    public fun batch_lock_into_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &0x2::transfer_policy::TransferPolicy<EmptyBox>, arg3: vector<EmptyBox>) {
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1);
        while (!0x1::vector::is_empty<EmptyBox>(&arg3)) {
            0x2::kiosk::lock<EmptyBox>(arg0, v0, arg2, 0x1::vector::pop_back<EmptyBox>(&mut arg3));
        };
        0x1::vector::destroy_empty<EmptyBox>(arg3);
    }

    public fun batch_transfer(arg0: vector<EmptyBox>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<EmptyBox>(&arg0)) {
            transfer(0x1::vector::pop_back<EmptyBox>(&mut arg0), arg1, arg2);
        };
        0x1::vector::destroy_empty<EmptyBox>(arg0);
    }

    public fun box_attributes(arg0: &EmptyBox) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun box_hashed_code(arg0: &EmptyBox) : 0x1::string::String {
        arg0.hashed_code
    }

    public fun box_id(arg0: &EmptyBox) : 0x2::object::ID {
        0x2::object::id<EmptyBox>(arg0)
    }

    public fun box_level(arg0: &EmptyBox) : u16 {
        arg0.level
    }

    public fun box_open(arg0: &EmptyBox) : bool {
        arg0.open
    }

    public fun box_original_code(arg0: &EmptyBox) : 0x1::string::String {
        arg0.original_code
    }

    public fun box_rarity(arg0: &EmptyBox) : 0x1::option::Option<u8> {
        arg0.rarity
    }

    public fun box_serial(arg0: &EmptyBox) : u64 {
        arg0.serial_number
    }

    public fun burn(arg0: EmptyBox, arg1: &0x2::tx_context::TxContext) {
        let EmptyBox {
            id            : v0,
            serial_number : v1,
            level         : v2,
            rarity        : _,
            hashed_code   : _,
            original_code : _,
            open          : _,
            attributes    : _,
        } = arg0;
        let v8 = v0;
        let v9 = NftBurned{
            nft_id        : 0x2::object::uid_to_inner(&v8),
            owner         : 0x2::tx_context::sender(arg1),
            serial_number : v1,
            level         : v2,
        };
        0x2::event::emit<NftBurned>(v9);
        0x2::object::delete(v8);
    }

    public fun get_owner(arg0: &BOX_COLLECTION) : address {
        arg0.owner
    }

    public fun get_referral_leaderboard(arg0: &BOX_COLLECTION, arg1: u64) : (vector<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::ReferralRecord>, u64) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::get_paged_referral_leaderboard(&arg0.referral_leaderboard, arg1, 10)
    }

    public fun get_role(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg1: address) : u8 {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_user_role(arg0, arg1)
    }

    public fun get_role_info(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg1: &BOX_COLLECTION, arg2: address) : (u64, u8, u64, u64) {
        let v0 = get_role(arg0, arg2);
        let v1 = *0x1::vector::borrow<u64>(&arg1.role_limits, (v0 as u64));
        let v2 = if (v1 == 0) {
            0
        } else {
            let v3 = if (0x2::table::contains<address, u64>(&arg1.mint_counts, arg2)) {
                *0x2::table::borrow<address, u64>(&arg1.mint_counts, arg2)
            } else {
                0
            };
            if (v3 >= v1) {
                0
            } else {
                v1 - v3
            }
        };
        (v2, v0, *0x1::vector::borrow<u64>(&arg1.role_prices, (v0 as u64)), *0x1::vector::borrow<u64>(&arg1.role_prices, (2 as u64)))
    }

    entry fun get_total_minted(arg0: &MintTracker) : (u64, u64) {
        (*0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"total_minted"), *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"total_nft_templates"))
    }

    public fun get_user_ranking(arg0: &BOX_COLLECTION, arg1: address) : (u64, u64, u64) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::get_referral_rank(&arg0.referral_leaderboard, arg1)
    }

    fun init(arg0: TEBC_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = BOX_COLLECTION{
            id                    : 0x2::object::new(arg1),
            owner                 : v0,
            role_prices           : vector[1000000000, 3000000000, 5000000000],
            role_limits           : vector[0, 0, 18446744073709551615],
            mint_counts           : 0x2::table::new<address, u64>(arg1),
            referral_counts       : 0x2::table::new<address, u64>(arg1),
            referral_revenues     : 0x2::table::new<address, u64>(arg1),
            referral_leaderboard  : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::empty_referral(arg1),
            rarity_counts         : vector[0, 0, 0, 0],
            upgrade_cost          : 1000000000,
            image_storage         : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::new_storage(arg1),
            start_upgrade_time_ms : 0,
            start_mint_time_ms    : 0,
        };
        let v3 = MintTracker{id: 0x2::object::new(arg1)};
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v3.id, b"total_minted", 0);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v3.id, b"total_nft_templates", 0);
        let v4 = 0x2::package::claim<TEBC_BOX>(arg0, arg1);
        let v5 = 0x2::display::new<EmptyBox>(&v4, arg1);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"display"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Empty box #{serial_number}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"EmptyBox is a genesis collection of 10,000 dynamic MBTI NFT avatars on the SUI network. Owners can exhibit their avatars in Cosmo Expeditions to harvest rare materials and visually evolve their on-chain identity up to Level 10,000."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/{hashed_code}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://theemptyboxclub.com/"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"TEBC Co., LTD"));
        0x2::display::add_multiple<EmptyBox>(&mut v5, v6, v8);
        0x2::display::update_version<EmptyBox>(&mut v5);
        let (v10, v11) = 0x2::transfer_policy::new<EmptyBox>(&v4, arg1);
        let v12 = v11;
        let v13 = v10;
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::add_royalty_rule<EmptyBox>(&mut v13, &v12, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::new_royalty_config(500, 0));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::display::Display<EmptyBox>>(v5, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EmptyBox>>(v12, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EmptyBox>>(v13);
        0x2::transfer::share_object<BOX_COLLECTION>(v2);
        0x2::transfer::share_object<MintTracker>(v3);
    }

    entry fun is_valid_referral(arg0: &BOX_COLLECTION, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.mint_counts, arg1)
    }

    public fun lock_into_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &0x2::transfer_policy::TransferPolicy<EmptyBox>, arg3: EmptyBox) {
        0x2::kiosk::lock<EmptyBox>(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg2, arg3);
    }

    public fun max_supply(arg0: &MintTracker) : u64 {
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"total_nft_templates")
    }

    entry fun mint(arg0: &mut BOX_COLLECTION, arg1: &mut MintTracker, arg2: &mut 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoPool, arg3: &mut 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::reward::RewardPool, arg4: &mut 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0x1::option::Option<0x1::string::String>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg11: &0x2::transfer_policy::TransferPolicy<EmptyBox>, arg12: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg13: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg12);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_mint_enabled(arg12);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 >= arg0.start_mint_time_ms, 13);
        assert!(arg6 > 0, 0);
        let v2 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_user_code(arg4, v0);
        if (0x1::option::is_none<0x1::string::String>(&v2)) {
            let (_, _) = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::generate_ref_code(arg4, 0x1::option::none<0x1::string::String>(), arg13);
        };
        assert!(*0x2::dynamic_field::borrow<vector<u8>, u64>(&arg1.id, b"total_minted") + arg6 <= *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg1.id, b"total_nft_templates"), 16);
        let v5 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_user_role(arg4, v0);
        let v6 = if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.mint_counts, v0)
        } else {
            0
        };
        let v7 = v6;
        let v8 = 0;
        let v9 = 0;
        while (v9 < arg6) {
            let v10 = if (v7 < *0x1::vector::borrow<u64>(&arg0.role_limits, (v5 as u64))) {
                *0x1::vector::borrow<u64>(&arg0.role_prices, (v5 as u64))
            } else {
                *0x1::vector::borrow<u64>(&arg0.role_prices, (2 as u64))
            };
            v8 = v8 + v10;
            v7 = v7 + 1;
            v9 = v9 + 1;
        };
        let v11 = v8;
        let v12 = false;
        let v13 = @0x0;
        let v14 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_referrer(arg4, v0);
        if (0x1::option::is_some<address>(&v14)) {
            v13 = 0x1::option::destroy_some<address>(v14);
            v12 = true;
            v11 = v8 * 90 / 100;
        } else if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            v13 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::add_referrer(arg4, v0, 0x1::option::destroy_some<0x1::string::String>(arg7));
            v12 = true;
            v11 = v8 * 90 / 100;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) >= v11, 3);
        let v15 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg5), v11), arg13);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::record_profit(arg2, v11 * 20 / 100);
        if (v12) {
            let v16 = v11 * 10 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v15, v16, arg13), v13);
            let v17 = if (0x2::table::contains<address, u64>(&arg0.referral_counts, v13)) {
                let v18 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_counts, v13);
                *v18 = *v18 + arg6;
                *v18
            } else {
                0x2::table::add<address, u64>(&mut arg0.referral_counts, v13, arg6);
                arg6
            };
            let v19 = if (0x2::table::contains<address, u64>(&arg0.referral_revenues, v13)) {
                let v20 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_revenues, v13);
                *v20 = *v20 + v16;
                *v20
            } else {
                0x2::table::add<address, u64>(&mut arg0.referral_revenues, v13, v16);
                v16
            };
            0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_referral_score(&mut arg0.referral_leaderboard, v19, v17, v13);
            let v21 = ReferralRewardEvent{
                referrer              : v13,
                reward_amount         : v16,
                total_revenue_updated : v19,
                total_count_updated   : v17,
                timestamp             : v1,
            };
            0x2::event::emit<ReferralRewardEvent>(v21);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v15, arg0.owner);
        let v22 = 0;
        while (v22 < arg6) {
            let v23 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"total_minted");
            *v23 = *v23 + 1;
            let v24 = *v23;
            let v25 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::reward::check_reward_amount(v24);
            if (v25 > 0) {
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::reward::mint_winner_nft(arg3, v0, v24, v25, arg8, arg13);
            };
            let (v26, v27) = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::get_level0_metadata();
            let v28 = EmptyBox{
                id            : 0x2::object::new(arg13),
                serial_number : v24,
                level         : 0,
                rarity        : 0x1::option::none<u8>(),
                hashed_code   : v26,
                original_code : v26,
                open          : false,
                attributes    : v27,
            };
            let v29 = NftMinted{
                nft_id        : 0x2::object::id<EmptyBox>(&v28),
                minter        : v0,
                serial_number : v24,
                with_referral : v12,
            };
            0x2::event::emit<NftMinted>(v29);
            0x2::kiosk::lock<EmptyBox>(arg9, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg10), arg11, v28);
            v22 = v22 + 1;
        };
        if (0x2::table::contains<address, u64>(&arg0.mint_counts, v0)) {
            let v30 = 0x2::table::borrow_mut<address, u64>(&mut arg0.mint_counts, v0);
            *v30 = *v30 + arg6;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mint_counts, v0, arg6);
        };
    }

    fun select_rarity(arg0: &BOX_COLLECTION, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::get_remaining_supply(&arg0.image_storage, 0);
        let v1 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::get_remaining_supply(&arg0.image_storage, 1);
        let v2 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::get_remaining_supply(&arg0.image_storage, 2);
        let v3 = v0 + v1 + v2 + 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::get_remaining_supply(&arg0.image_storage, 3);
        assert!(v3 > 0, 5);
        let v4 = 0x2::random::new_generator(arg1, arg2);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, 1, v3);
        if (v5 <= v0) {
            0
        } else if (v5 <= v0 + v1) {
            1
        } else if (v5 <= v0 + v1 + v2) {
            2
        } else {
            3
        }
    }

    entry fun set_mint_time(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.start_mint_time_ms = arg2;
    }

    entry fun set_owner(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.owner = arg2;
        let v0 = OwnerUpdated{
            old_owner : arg1.owner,
            new_owner : arg2,
        };
        0x2::event::emit<OwnerUpdated>(v0);
    }

    public fun set_role_config(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        assert!(0x1::vector::length<u64>(&arg2) == 3, 14);
        assert!(0x1::vector::length<u64>(&arg3) == 3, 14);
        arg1.role_prices = arg2;
        arg1.role_limits = arg3;
    }

    entry fun set_upgrade_cost(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.upgrade_cost = arg2;
    }

    entry fun set_upgrade_time(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut BOX_COLLECTION, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg3);
        arg1.start_upgrade_time_ms = arg2;
    }

    public fun update_display(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut 0x2::display::Display<EmptyBox>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg4);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 14);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v1);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<EmptyBox>(arg1), &v2)) {
                0x2::display::edit<EmptyBox>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            } else {
                0x2::display::add<EmptyBox>(arg1, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            };
            v1 = v1 + 1;
        };
        0x2::display::update_version<EmptyBox>(arg1);
    }

    entry fun upgrade(arg0: &mut BOX_COLLECTION, arg1: &mut 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>, arg5: 0x2::object::ID, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg12: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg11);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_upgrade_enabled(arg11);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = 0x2::kiosk::borrow_mut<EmptyBox>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg5);
        assert!(v1 >= arg0.start_upgrade_time_ms, 12);
        assert!(arg7 > 0, 0);
        assert!((v2.level as u64) + arg7 <= (10000 as u64), 10);
        let v3 = arg0.upgrade_cost * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= v3, 3);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg6), v3), arg12);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::record_profit(arg1, v3 * 20 / 100);
        let v5 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_referrer(arg8, v0);
        if (0x1::option::is_some<address>(&v5)) {
            let v6 = 0x1::option::destroy_some<address>(v5);
            let v7 = v3 * 10 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v7, arg12), v6);
            let v8 = if (0x2::table::contains<address, u64>(&arg0.referral_counts, v6)) {
                *0x2::table::borrow<address, u64>(&arg0.referral_counts, v6)
            } else {
                0
            };
            let v9 = if (0x2::table::contains<address, u64>(&arg0.referral_revenues, v6)) {
                let v10 = 0x2::table::borrow_mut<address, u64>(&mut arg0.referral_revenues, v6);
                *v10 = *v10 + v7;
                *v10
            } else {
                0x2::table::add<address, u64>(&mut arg0.referral_revenues, v6, v7);
                v7
            };
            0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_referral_score(&mut arg0.referral_leaderboard, v9, v8, v6);
            let v11 = ReferralRewardEvent{
                referrer              : v6,
                reward_amount         : v7,
                total_revenue_updated : v9,
                total_count_updated   : v8,
                timestamp             : v1,
            };
            0x2::event::emit<ReferralRewardEvent>(v11);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, arg0.owner);
        let v12 = 0x1::vector::empty<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>();
        let v13 = 0;
        while (v13 < arg7) {
            0x1::vector::push_back<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>(&mut v12, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::register_ticket(arg1, arg12));
            v2.level = v2.level + 1;
            let v14 = 0x1::option::none<u8>();
            if (v2.level == 1) {
                let v15 = select_rarity(arg0, arg10, arg12);
                v2.rarity = 0x1::option::some<u8>(v15);
                v14 = 0x1::option::some<u8>(v15);
                let (v16, v17) = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::nft_manager::reveal_nft(&mut arg0.image_storage, v15, arg10, arg12);
                v2.attributes = v17;
                v2.hashed_code = v16;
                v2.original_code = v16;
                let v18 = 0x1::vector::borrow_mut<u16>(&mut arg0.rarity_counts, (v15 as u64));
                *v18 = *v18 + 1;
            };
            let v19 = NftUpgraded{
                nft_id          : 0x2::object::id<EmptyBox>(v2),
                owner           : v0,
                new_level       : v2.level,
                rarity_revealed : v14,
            };
            0x2::event::emit<NftUpgraded>(v19);
            v13 = v13 + 1;
        };
        while (!0x1::vector::is_empty<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>(&v12)) {
            0x2::kiosk::place<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), 0x1::vector::pop_back<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>(&mut v12));
        };
        0x1::vector::destroy_empty<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::cosmo::CosmoTicket>(v12);
    }

    // decompiled from Move bytecode v7
}

