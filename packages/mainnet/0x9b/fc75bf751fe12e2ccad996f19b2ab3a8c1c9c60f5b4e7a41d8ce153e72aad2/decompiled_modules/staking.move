module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::staking {
    struct StakedBox has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    struct UserStats has store {
        total_points_earned: u64,
        staked_nft_ids: vector<0x2::object::ID>,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        staked_count: u64,
        stakes: 0x2::table::Table<0x2::object::ID, StakeInfo>,
        end_staking_ms: u64,
        stop_earning_ms: u64,
        min_stake_duration: u64,
        total_points_distributed: u64,
        leaderboard: 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::Leaderboard,
    }

    struct StakeInfo has store {
        owner: address,
        start_time_ms: u64,
        nft_id: 0x2::object::ID,
        serial_number: u64,
        level: u16,
        rarity: u8,
        hashed_code: 0x1::string::String,
    }

    struct ReceiptStaking has store, key {
        id: 0x2::object::UID,
        points: u64,
        from_nft_serial: u64,
        start_time: u64,
        end_time: u64,
    }

    struct NftUnstaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        points: u64,
        at_time: u64,
    }

    struct NftStaked has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        at_time: u64,
    }

    struct EmptyBoxView has copy, drop {
        id: 0x2::object::ID,
        serial_number: u64,
        level: u16,
        rarity: 0x1::option::Option<u8>,
        hashed_code: 0x1::string::String,
    }

    struct StakeInfoView has copy, drop {
        owner: address,
        start_time_ms: u64,
        nft_id: 0x2::object::ID,
    }

    public(friend) fun add_points(arg0: &mut StakingPool, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, UserStats>(&mut arg0.id, arg1);
            if (v0.total_points_earned > 0) {
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::remove_score(&mut arg0.leaderboard, v0.total_points_earned, arg1);
            };
            v0.total_points_earned = v0.total_points_earned + arg2;
            0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_score(&mut arg0.leaderboard, v0.total_points_earned, arg1);
        } else {
            let v1 = UserStats{
                total_points_earned : arg2,
                staked_nft_ids      : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<address, UserStats>(&mut arg0.id, arg1, v1);
            0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_score(&mut arg0.leaderboard, arg2, arg1);
        };
        arg0.total_points_distributed = arg0.total_points_distributed + arg2;
    }

    entry fun generate_ref_code_action(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg2: &mut StakingPool, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg0);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_phase1_enabled(arg0);
        let (v0, v1) = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::generate_ref_code(arg1, arg3, arg4);
        let v2 = v1;
        assert!(v0, 7);
        add_points(arg2, 0x2::tx_context::sender(arg4), 2000);
        if (0x1::option::is_some<address>(&v2)) {
            add_points(arg2, 0x1::option::destroy_some<address>(v2), 600);
        };
    }

    public fun get_leaderboard(arg0: &StakingPool, arg1: u64) : (vector<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::Record>, u64) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::get_paged_leaderboard(&arg0.leaderboard, arg1, 10)
    }

    public fun get_total_points(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            0x2::dynamic_field::borrow<address, UserStats>(&arg0.id, arg1).total_points_earned
        } else {
            0
        }
    }

    entry fun get_user_staked_nfts(arg0: &StakingPool, arg1: address) : (vector<EmptyBoxView>, vector<StakeInfoView>) {
        let v0 = 0x1::vector::empty<EmptyBoxView>();
        let v1 = 0x1::vector::empty<StakeInfoView>();
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            let v2 = 0;
            let v3 = &0x2::dynamic_field::borrow<address, UserStats>(&arg0.id, arg1).staked_nft_ids;
            while (v2 < 0x1::vector::length<0x2::object::ID>(v3)) {
                let v4 = 0x1::vector::borrow<0x2::object::ID>(v3, v2);
                if (0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, *v4)) {
                    let v5 = 0x2::table::borrow<0x2::object::ID, StakeInfo>(&arg0.stakes, *v4);
                    let v6 = EmptyBoxView{
                        id            : *v4,
                        serial_number : v5.serial_number,
                        level         : v5.level,
                        rarity        : 0x1::option::some<u8>(v5.rarity),
                        hashed_code   : v5.hashed_code,
                    };
                    0x1::vector::push_back<EmptyBoxView>(&mut v0, v6);
                    let v7 = StakeInfoView{
                        owner         : v5.owner,
                        start_time_ms : v5.start_time_ms,
                        nft_id        : *v4,
                    };
                    0x1::vector::push_back<StakeInfoView>(&mut v1, v7);
                };
                v2 = v2 + 1;
            };
        };
        (v0, v1)
    }

    entry fun get_user_stats(arg0: &StakingPool, arg1: address) : (u64, u64) {
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow<address, UserStats>(&arg0.id, arg1);
            (v2.total_points_earned, 0x1::vector::length<0x2::object::ID>(&v2.staked_nft_ids))
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                       : 0x2::object::new(arg0),
            staked_count             : 0,
            stakes                   : 0x2::table::new<0x2::object::ID, StakeInfo>(arg0),
            end_staking_ms           : 0,
            stop_earning_ms          : 0,
            min_stake_duration       : 2592000000,
            total_points_distributed : 0,
            leaderboard              : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::empty(),
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun set_time_config(arg0: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg1: &mut StakingPool, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_admin(arg0, arg5);
        arg1.end_staking_ms = arg2;
        arg1.stop_earning_ms = arg3;
        arg1.min_stake_duration = arg4;
    }

    public fun stake(arg0: &mut StakingPool, arg1: 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox, arg2: 0x2::transfer_policy::TransferRequest<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>, arg3: &mut 0x2::transfer_policy::TransferPolicy<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>, arg4: &0x2::clock::Clock, arg5: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg5);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_stake_enabled(arg5);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.end_staking_ms == 0 || v1 < arg0.end_staking_ms, 2);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::rules::pay_royalty_rule<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(arg3, &mut arg2, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(arg3, arg2);
        let v5 = 0x2::object::id<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(&arg1);
        let v6 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::box_level(&arg1);
        assert!(v6 > 0, 6);
        let v7 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::box_rarity(&arg1);
        let v8 = StakedBox{
            id     : 0x2::object::new(arg6),
            nft_id : v5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(&mut v8.id, v5, arg1);
        if (!0x2::dynamic_field::exists<address>(&arg0.id, v0)) {
            let v9 = UserStats{
                total_points_earned : 0,
                staked_nft_ids      : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_field::add<address, UserStats>(&mut arg0.id, v0, v9);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut 0x2::dynamic_field::borrow_mut<address, UserStats>(&mut arg0.id, v0).staked_nft_ids, v5);
        let v10 = StakeInfo{
            owner         : v0,
            start_time_ms : v1,
            nft_id        : v5,
            serial_number : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::box_serial(&arg1),
            level         : v6,
            rarity        : 0x1::option::get_with_default<u8>(&v7, 1),
            hashed_code   : 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::box_hashed_code(&arg1),
        };
        0x2::table::add<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v5, v10);
        arg0.staked_count = arg0.staked_count + 1;
        let v11 = NftStaked{
            nft_id  : v5,
            owner   : v0,
            at_time : v1,
        };
        0x2::event::emit<NftStaked>(v11);
        0x2::transfer::transfer<StakedBox>(v8, v0);
    }

    public fun unstake(arg0: &mut StakingPool, arg1: StakedBox, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::transfer_policy::TransferPolicy<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>, arg5: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::ReferralRegistry, arg6: &0x2::clock::Clock, arg7: &0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::AppConfig, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_version(arg7);
        0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config::check_unstake_enabled(arg7);
        let StakedBox {
            id     : v0,
            nft_id : v1,
        } = arg1;
        let v2 = v1;
        let v3 = v0;
        0x2::object::delete(v3);
        assert!(0x2::table::contains<0x2::object::ID, StakeInfo>(&arg0.stakes, v2), 1);
        let v4 = 0x2::tx_context::sender(arg8);
        let StakeInfo {
            owner         : v5,
            start_time_ms : v6,
            nft_id        : _,
            serial_number : v8,
            level         : v9,
            rarity        : v10,
            hashed_code   : _,
        } = 0x2::table::remove<0x2::object::ID, StakeInfo>(&mut arg0.stakes, v2);
        arg0.staked_count = arg0.staked_count - 1;
        assert!(v4 == v5, 0);
        let v12 = 0x2::clock::timestamp_ms(arg6);
        assert!(v12 >= v6 + arg0.min_stake_duration, 5);
        let v13 = if (arg0.stop_earning_ms > 0 && v12 > arg0.stop_earning_ms) {
            arg0.stop_earning_ms
        } else {
            v12
        };
        let v14 = if (v13 > v6) {
            v13 - v6
        } else {
            0
        };
        let v15 = if (v8 < 10000) {
            10000 - v8
        } else {
            0
        };
        let v16 = ((v10 as u64) + 1) * (v9 as u64) * (1 + (v9 as u64) / 1000) * v14 / 1000 / 3600 + v15;
        arg0.total_points_distributed = arg0.total_points_distributed + v16;
        if (0x2::dynamic_field::exists<address>(&arg0.id, v4)) {
            let v17 = 0x2::dynamic_field::borrow_mut<address, UserStats>(&mut arg0.id, v4);
            if (v17.total_points_earned > 0) {
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::remove_score(&mut arg0.leaderboard, v17.total_points_earned, v4);
            };
            v17.total_points_earned = v17.total_points_earned + v16;
            0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_score(&mut arg0.leaderboard, v17.total_points_earned, v4);
            let (v18, v19) = 0x1::vector::index_of<0x2::object::ID>(&v17.staked_nft_ids, &v2);
            if (v18) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut v17.staked_nft_ids, v19);
            };
        };
        let v20 = NftUnstaked{
            nft_id  : v2,
            owner   : v4,
            points  : v16,
            at_time : v12,
        };
        0x2::event::emit<NftUnstaked>(v20);
        let v21 = 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::referral::get_referrer(arg5, v4);
        if (0x1::option::is_some<address>(&v21)) {
            let v22 = 0x1::option::destroy_some<address>(v21);
            let v23 = v16 * 15 / 100;
            if (0x2::dynamic_field::exists<address>(&arg0.id, v22)) {
                let v24 = 0x2::dynamic_field::borrow_mut<address, UserStats>(&mut arg0.id, v22);
                if (v24.total_points_earned > 0) {
                    0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::remove_score(&mut arg0.leaderboard, v24.total_points_earned, v22);
                };
                v24.total_points_earned = v24.total_points_earned + v23;
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_score(&mut arg0.leaderboard, v24.total_points_earned, v22);
            } else {
                let v25 = UserStats{
                    total_points_earned : v23,
                    staked_nft_ids      : 0x1::vector::empty<0x2::object::ID>(),
                };
                0x2::dynamic_field::add<address, UserStats>(&mut arg0.id, v22, v25);
                0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::leaderboard::add_score(&mut arg0.leaderboard, v23, v22);
            };
            arg0.total_points_distributed = arg0.total_points_distributed + v23;
        };
        0x2::kiosk::lock<0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg4, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::tebc_box::EmptyBox>(&mut v3, v2));
        let v26 = ReceiptStaking{
            id              : 0x2::object::new(arg8),
            points          : v16,
            from_nft_serial : v8,
            start_time      : v6,
            end_time        : v13,
        };
        0x2::transfer::transfer<ReceiptStaking>(v26, v4);
    }

    // decompiled from Move bytecode v7
}

