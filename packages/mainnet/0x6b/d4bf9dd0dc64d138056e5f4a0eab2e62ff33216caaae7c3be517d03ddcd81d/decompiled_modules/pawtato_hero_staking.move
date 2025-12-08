module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking {
    struct HeroStaked has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct HeroUnstakeInitiated has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        cooldown_duration_ms: u64,
    }

    struct HeroWithdrawn has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct HeroCooldownCancelled has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct InfluenceClaimed has copy, drop {
        user: address,
        land_id: 0x2::object::ID,
        influence_amount: u64,
        carry_over: u128,
    }

    struct UrrFound has copy, drop {
        user: address,
        resource_type: 0x1::string::String,
        amount: u64,
        roll: u128,
    }

    struct FragmentFound has copy, drop {
        user: address,
        fragment_type: 0x1::string::String,
        amount: u64,
        roll: u128,
    }

    struct UrrRolled has copy, drop {
        user: address,
        roll: u128,
        chances: vector<u128>,
    }

    struct FragmentRolled has copy, drop {
        user: address,
        roll: u128,
        chances: vector<u128>,
    }

    struct UserRegistered has copy, drop {
        user: address,
    }

    struct RepresentingPlayerSet has copy, drop {
        user: address,
        rep_player: address,
    }

    struct RepresentingPlayerSetV2 has copy, drop {
        user: address,
        prev_rep_player: address,
        rep_player: address,
    }

    struct PatrollingStarted has copy, drop {
        user: address,
        hero_ids: vector<0x2::object::ID>,
    }

    struct PatrollingEnded has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
    }

    struct DebugEvent has copy, drop {
        messages: vector<0x1::string::String>,
    }

    struct ConsumableUsed has copy, drop {
        user: address,
        consumable_type: 0x1::string::String,
        remaining_uses: u8,
    }

    struct ConsumableBoost has drop, store {
        remaining_uses: u8,
        boost_value: u64,
        consumed_at: u64,
    }

    struct PAWTATO_HERO_STAKING has drop {
        dummy_field: bool,
    }

    struct HeroInfo has drop, store {
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
        status: u8,
        cached_traits: vector<u16>,
    }

    struct HeroInfoDto has copy, drop, store {
        nft_id: 0x2::object::ID,
        stake_ts: u64,
        cooldown_ts: 0x1::option::Option<u64>,
        status: u8,
        health_status: u8,
    }

    struct HeroUserInfo has store, key {
        id: 0x2::object::UID,
        heroes: vector<HeroInfo>,
        last_patrol_claim_ts: u64,
        last_urr_raffle_ts: u64,
        influence_carry: u128,
        rep_player: address,
        last_rep_player_change_ts: u64,
    }

    struct HeroStakingPool has key {
        id: 0x2::object::UID,
        admin_address: address,
        treasury_address: address,
        users: 0x2::table::Table<address, HeroUserInfo>,
        stakers: vector<address>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        pawtato_package_cap: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap,
        urr_coin_types: vector<0x1::string::String>,
        fragment_coin_types: vector<0x1::string::String>,
        version: u64,
        paused: bool,
    }

    struct HeroDashboardInfo has copy, drop {
        staked_heroes: vector<HeroInfoDto>,
        total_heroes_count: u64,
        pending_influence: u64,
        influence_rate_per_day: u64,
        last_patrol_claim_ts: u64,
        last_urr_raffle_ts: u64,
        rep_player: address,
        rep_land_id: 0x1::option::Option<0x2::object::ID>,
        last_rep_player_change_ts: u64,
    }

    fun address_to_consumable_key(arg0: address, arg1: 0x1::string::String) : vector<u8> {
        let v0 = b"consumable_boost_";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(&arg1));
        v0
    }

    fun attempt_fragment_finding<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_user_registered(arg0, v0), 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg0.fragment_coin_types) >= 9, 10);
        let v1 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 1);
        let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 2);
        let v4 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 3);
        let v5 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 4);
        let v6 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 5);
        let v7 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 6);
        let v8 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 7);
        let v9 = *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 8);
        assert!(v1 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 10);
        assert!(v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>(), 10);
        assert!(v3 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>(), 10);
        assert!(v4 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T3>(), 10);
        assert!(v5 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T4>(), 10);
        assert!(v6 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T5>(), 10);
        assert!(v7 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T6>(), 10);
        assert!(v8 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T7>(), 10);
        assert!(v9 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T8>(), 10);
        let (v10, _, _, v13) = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::get_runic_resonator_and_consume_durability(&arg0.pawtato_package_cap, arg1, v0, 0x2::clock::timestamp_ms(arg3));
        if (!v10 || v13 == 0) {
            return
        };
        let (v14, _) = get_and_consume_boost(arg0, v0, 0x1::string::utf8(b"prism_of_tenacity"), arg3, 0);
        let (v16, _) = get_and_consume_boost(arg0, v0, 0x1::string::utf8(b"prism_of_cognition"), arg3, 0);
        let (v18, _) = get_and_consume_boost(arg0, v0, 0x1::string::utf8(b"prism_of_equilibrium"), arg3, 0);
        let (_, v21) = get_patrolling_heroes_multiplier_sum(&0x2::table::borrow<address, HeroUserInfo>(&arg0.users, v0).heroes);
        let v22 = 100 * v21;
        let v23 = 0x1::vector::empty<u128>();
        let v24 = 0;
        let v25 = 0;
        while (v25 < v13) {
            let v26 = v22;
            if (v25 == 0 && v14 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            } else if (v25 == 1 && v16 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            } else if (v25 == 2 && v18 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            } else if (v25 == 3 && v14 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            } else if (v25 == 4 && v16 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            } else if (v25 == 5 && v18 > 0) {
                v26 = v22 + (250 as u128) * 1000000 * 10000 / 10000;
            };
            v24 = v24 + v26;
            0x1::vector::push_back<u128>(&mut v23, v26);
            v25 = v25 + 1;
        };
        let v27 = 0x2::random::new_generator(arg4, arg5);
        let v28 = 0x2::random::generate_u128(&mut v27) % 1000000;
        let v29 = 0x1::vector::empty<u128>();
        let v30 = 0;
        while (v30 < 0x1::vector::length<u128>(&v23)) {
            0x1::vector::push_back<u128>(&mut v29, *0x1::vector::borrow<u128>(&v23, v30) / 10000);
            v30 = v30 + 1;
        };
        let v31 = FragmentRolled{
            user    : v0,
            roll    : v28,
            chances : v29,
        };
        0x2::event::emit<FragmentRolled>(v31);
        if (v28 < v24 / 10000) {
            let v32 = 1000000000;
            let v33 = 0;
            let v34 = 0;
            while (v34 < v13) {
                v33 = v33 + *0x1::vector::borrow<u128>(&v23, v34) / 10000;
                if (v28 < v33) {
                    break
                };
                v34 = v34 + 1;
            };
            if (v34 == 0) {
                mint_and_transfer_coin<T0>(arg0, arg2, v32, v0, arg5);
                let v35 = FragmentFound{
                    user          : v0,
                    fragment_type : v1,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v35);
            } else if (v34 == 1) {
                mint_and_transfer_coin<T1>(arg0, arg2, v32, v0, arg5);
                let v36 = FragmentFound{
                    user          : v0,
                    fragment_type : v2,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v36);
            } else if (v34 == 2) {
                mint_and_transfer_coin<T2>(arg0, arg2, v32, v0, arg5);
                let v37 = FragmentFound{
                    user          : v0,
                    fragment_type : v3,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v37);
            } else if (v34 == 3) {
                mint_and_transfer_coin<T3>(arg0, arg2, v32, v0, arg5);
                let v38 = FragmentFound{
                    user          : v0,
                    fragment_type : v4,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v38);
            } else if (v34 == 4) {
                mint_and_transfer_coin<T4>(arg0, arg2, v32, v0, arg5);
                let v39 = FragmentFound{
                    user          : v0,
                    fragment_type : v5,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v39);
            } else if (v34 == 5) {
                mint_and_transfer_coin<T5>(arg0, arg2, v32, v0, arg5);
                let v40 = FragmentFound{
                    user          : v0,
                    fragment_type : v6,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v40);
            } else if (v34 == 6) {
                mint_and_transfer_coin<T6>(arg0, arg2, v32, v0, arg5);
                let v41 = FragmentFound{
                    user          : v0,
                    fragment_type : v7,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v41);
            } else if (v34 == 7) {
                mint_and_transfer_coin<T7>(arg0, arg2, v32, v0, arg5);
                let v42 = FragmentFound{
                    user          : v0,
                    fragment_type : v8,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v42);
            } else if (v34 == 8) {
                mint_and_transfer_coin<T8>(arg0, arg2, v32, v0, arg5);
                let v43 = FragmentFound{
                    user          : v0,
                    fragment_type : v9,
                    amount        : v32,
                    roll          : v28,
                };
                0x2::event::emit<FragmentFound>(v43);
            };
        };
    }

    fun attempt_urr_finding<T0, T1, T2>(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) : bool {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_user_registered(arg0, v0), 3);
        assert!(0x1::vector::length<0x1::string::String>(&arg0.urr_coin_types) >= 3, 10);
        let v1 = *0x1::vector::borrow<0x1::string::String>(&arg0.urr_coin_types, 0);
        let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.urr_coin_types, 1);
        let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0.urr_coin_types, 2);
        assert!(v1 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>(), 10);
        assert!(v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T1>(), 10);
        assert!(v3 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T2>(), 10);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = 0x2::table::borrow<address, HeroUserInfo>(&arg0.users, v0);
        let (v6, v7) = if (v4 < v5.last_urr_raffle_ts + 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::get_urr_interval(v0)) {
            let _ = 0;
            (false, 0)
        } else {
            let (v9, v10) = get_patrolling_heroes_multiplier_sum(&v5.heroes);
            let _ = v9;
            (true, v10)
        };
        if (!v6) {
            return true
        };
        let v11 = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::get_idol_boost_and_consume_durability(&arg0.pawtato_package_cap, arg1, v0, v4);
        0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0).last_urr_raffle_ts = v4;
        let v12 = 50 * v7 * v11 / 10000 * 10000;
        let v13 = 50 * v7 * v11 / 10000 * 10000;
        let v14 = 5 * v7 * v11 / 10000 * 10000;
        let v15 = 0x2::random::new_generator(arg4, arg5);
        let v16 = 0x2::random::generate_u128(&mut v15) % 1000000;
        let v17 = 0x1::vector::empty<u128>();
        let v18 = &mut v17;
        0x1::vector::push_back<u128>(v18, v14);
        0x1::vector::push_back<u128>(v18, v12);
        0x1::vector::push_back<u128>(v18, v13);
        let v19 = UrrRolled{
            user    : v0,
            roll    : v16,
            chances : v17,
        };
        0x2::event::emit<UrrRolled>(v19);
        let v20 = 1000000000;
        if (v16 < v14) {
            mint_and_transfer_coin<T2>(arg0, arg2, v20, v0, arg5);
            let v21 = UrrFound{
                user          : v0,
                resource_type : v3,
                amount        : v20,
                roll          : v16,
            };
            0x2::event::emit<UrrFound>(v21);
            return true
        };
        if (v16 < v14 + v12) {
            mint_and_transfer_coin<T0>(arg0, arg2, v20, v0, arg5);
            let v22 = UrrFound{
                user          : v0,
                resource_type : v1,
                amount        : v20,
                roll          : v16,
            };
            0x2::event::emit<UrrFound>(v22);
            return true
        };
        if (v16 < v14 + v12 + v13) {
            mint_and_transfer_coin<T1>(arg0, arg2, v20, v0, arg5);
            let v23 = UrrFound{
                user          : v0,
                resource_type : v2,
                amount        : v20,
                roll          : v16,
            };
            0x2::event::emit<UrrFound>(v23);
            return true
        };
        false
    }

    fun auto_claim_influence(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &0x2::clock::Clock, arg3: address) {
        if (!is_user_registered(arg0, arg3)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, arg3);
        if (0x1::vector::length<HeroInfo>(&v0.heroes) == 0) {
            return
        };
        let v1 = v0.rep_player;
        let v2 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg1, v1);
        if (0x1::option::is_none<0x2::object::ID>(&v2)) {
            return
        };
        process_influence_claim(&arg0.pawtato_package_cap, arg1, v0, arg3, v1, 0x1::option::destroy_some<0x2::object::ID>(v2), 0x2::clock::timestamp_ms(arg2), true);
    }

    public(friend) fun borrow_hero_mut(arg0: &mut HeroStakingPool, arg1: 0x2::object::ID) : &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO {
        0x2::kiosk::borrow_mut<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg1)
    }

    fun calculate_total_influence_with_decimals(arg0: &vector<HeroInfo>, arg1: u64, arg2: u64, arg3: u128) : u128 {
        let v0 = arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeroInfo>(arg0)) {
            let v2 = 0x1::vector::borrow<HeroInfo>(arg0, v1);
            if (v2.status == 2) {
                v0 = v0 + (get_hero_level(&v2.cached_traits) as u128) * 1000000000 / 864000 * ((arg2 - arg1) as u128) / 1000;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun cancel_hero_cooldown(arg0: &mut HeroStakingPool, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_user_registered(arg0, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<HeroInfo>(&v1.heroes)) {
            let v4 = 0x1::vector::borrow_mut<HeroInfo>(&mut v1.heroes, v2);
            if (v4.nft_id == arg1) {
                assert!(0x1::option::is_some<u64>(&v4.cooldown_ts), 9);
                v4.cooldown_ts = 0x1::option::none<u64>();
                v4.stake_ts = 0x2::clock::timestamp_ms(arg2);
                v4.status = 0;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 4);
        let v5 = HeroCooldownCancelled{
            user   : v0,
            nft_id : arg1,
        };
        0x2::event::emit<HeroCooldownCancelled>(v5);
    }

    public fun check_not_paused(arg0: &HeroStakingPool) {
        assert!(!arg0.paused, 2);
    }

    public fun check_version(arg0: &HeroStakingPool) {
        assert!(arg0.version == 1, 1);
    }

    public entry fun claim_influence<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: &0x2::clock::Clock, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_user_registered(arg0, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        assert!(0x1::vector::length<HeroInfo>(&v1.heroes) > 0, 8);
        let v2 = v1.rep_player;
        let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg1, v2);
        if (0x1::option::is_none<0x2::object::ID>(&v3)) {
            v1.last_patrol_claim_ts = 0x2::clock::timestamp_ms(arg3);
            v1.influence_carry = 0;
            let v4 = InfluenceClaimed{
                user             : v0,
                land_id          : 0x2::object::id_from_address(@0x0),
                influence_amount : 0,
                carry_over       : 0,
            };
            0x2::event::emit<InfluenceClaimed>(v4);
        } else {
            process_influence_claim(&arg0.pawtato_package_cap, arg1, v1, v0, v2, 0x1::option::destroy_some<0x2::object::ID>(v3), 0x2::clock::timestamp_ms(arg3), false);
        };
        let v5 = attempt_urr_finding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (!v5) {
            attempt_fragment_finding<T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0, arg1, arg2, arg3, arg4, arg5);
        };
    }

    public entry fun consume_resource<T0>(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_user_registered(arg0, v0), 3);
        assert!(0x2::coin::value<T0>(&arg2) >= 1000000000, 0);
        let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::get_coin_type_string_with_0x<T0>();
        let (v2, v3, v4) = get_consumable_params(arg0, v1);
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::burn_coin<T0>(arg1, arg2);
        let v5 = address_to_consumable_key(v0, v2);
        let v6 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v5)) {
            let v7 = 0x2::dynamic_field::borrow_mut<vector<u8>, ConsumableBoost>(&mut arg0.id, v5);
            if (v4 > 0) {
                v7.remaining_uses = v7.remaining_uses + v4;
            };
            v7.consumed_at = 0x2::clock::timestamp_ms(arg3);
            v7.remaining_uses
        } else {
            let v8 = ConsumableBoost{
                remaining_uses : v4,
                boost_value    : v3,
                consumed_at    : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::dynamic_field::add<vector<u8>, ConsumableBoost>(&mut arg0.id, v5, v8);
            v4
        };
        let v9 = ConsumableUsed{
            user            : v0,
            consumable_type : v1,
            remaining_uses  : v6,
        };
        0x2::event::emit<ConsumableUsed>(v9);
    }

    fun count_patrolling_heroes(arg0: &vector<HeroInfo>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeroInfo>(arg0)) {
            if (0x1::vector::borrow<HeroInfo>(arg0, v1).status == 2) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun end_patrolling(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_user_registered(arg0, v0), 3);
        auto_claim_influence(arg0, arg1, arg3, v0);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v4 = find_hero_index(&v1.heroes, v3);
            assert!(0x1::option::is_some<u64>(&v4), 4);
            let v5 = 0x1::vector::borrow_mut<HeroInfo>(&mut v1.heroes, 0x1::option::destroy_some<u64>(v4));
            assert!(v5.status == 2, 12);
            v5.status = 0;
            let v6 = PatrollingEnded{
                user   : v0,
                nft_id : v3,
            };
            0x2::event::emit<PatrollingEnded>(v6);
            v2 = v2 + 1;
        };
    }

    fun find_hero_for_withdraw(arg0: &mut HeroStakingPool, arg1: 0x2::object::ID, arg2: u64, arg3: address) : u64 {
        let v0 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeroInfo>(&v0.heroes)) {
            let v2 = 0x1::vector::borrow<HeroInfo>(&v0.heroes, v1);
            if (v2.nft_id == arg1) {
                assert!(0x1::option::is_some<u64>(&v2.cooldown_ts), 9);
                assert!(arg2 >= *0x1::option::borrow<u64>(&v2.cooldown_ts), 5);
                return v1
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    fun find_hero_index(arg0: &vector<HeroInfo>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<HeroInfo>(arg0)) {
            if (0x1::vector::borrow<HeroInfo>(arg0, v0).nft_id == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_and_consume_boost(arg0: &mut HeroStakingPool, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64) : (u64, bool) {
        let v0 = address_to_consumable_key(arg1, arg2);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            return (0, false)
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, ConsumableBoost>(&mut arg0.id, v0);
        if (v1.remaining_uses > 0) {
            v1.remaining_uses = v1.remaining_uses - 1;
            if (v1.remaining_uses == 0) {
                let ConsumableBoost {
                    remaining_uses : _,
                    boost_value    : _,
                    consumed_at    : _,
                } = 0x2::dynamic_field::remove<vector<u8>, ConsumableBoost>(&mut arg0.id, v0);
            };
            return (v1.boost_value, true)
        };
        if (v1.remaining_uses == 0 && arg4 > 0) {
            if (0x2::clock::timestamp_ms(arg3) < v1.consumed_at + arg4) {
                return (v1.boost_value, true)
            };
        };
        (0, false)
    }

    fun get_consumable_params(arg0: &HeroStakingPool, arg1: 0x1::string::String) : (0x1::string::String, u64, u8) {
        assert!(0x1::vector::length<0x1::string::String>(&arg0.fragment_coin_types) >= 15, 10);
        let v0 = if (arg1 == *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 12)) {
            b"prism_of_tenacity"
        } else if (arg1 == *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 13)) {
            b"prism_of_cognition"
        } else {
            assert!(arg1 == *0x1::vector::borrow<0x1::string::String>(&arg0.fragment_coin_types, 14), 17);
            b"prism_of_equilibrium"
        };
        (0x1::string::utf8(v0), 250, 3)
    }

    public(friend) fun get_hero_cached_trait(arg0: &HeroStakingPool, arg1: address, arg2: 0x2::object::ID, arg3: u64) : u16 {
        assert!(0x2::table::contains<address, HeroUserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<address, HeroUserInfo>(&arg0.users, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeroInfo>(&v0.heroes)) {
            let v2 = 0x1::vector::borrow<HeroInfo>(&v0.heroes, v1);
            if (v2.nft_id == arg2) {
                return *0x1::vector::borrow<u16>(&v2.cached_traits, arg3)
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    public fun get_hero_dashboard_info(arg0: &HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: &0x2::clock::Clock) : HeroDashboardInfo {
        assert!(0x2::table::contains<address, HeroUserInfo>(&arg0.users, arg2), 3);
        let v0 = 0x2::table::borrow<address, HeroUserInfo>(&arg0.users, arg2);
        let v1 = 0x1::vector::length<HeroInfo>(&v0.heroes);
        let (v2, v3) = if (count_patrolling_heroes(&v0.heroes) > 0) {
            let v4 = 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::get_banner_flag_boost_readonly(&arg0.pawtato_package_cap, arg1, arg2);
            let v5 = 0;
            let v6 = 0;
            while (v6 < v1) {
                let v7 = 0x1::vector::borrow<HeroInfo>(&v0.heroes, v6);
                if (v7.status == 2) {
                    v5 = v5 + (get_hero_level(&v7.cached_traits) as u128) * 1000000000 / 10;
                };
                v6 = v6 + 1;
            };
            (((calculate_total_influence_with_decimals(&v0.heroes, v0.last_patrol_claim_ts, 0x2::clock::timestamp_ms(arg3), v0.influence_carry) * (v4 as u128) / (10000 as u128)) as u64), ((v5 * (v4 as u128) / (10000 as u128)) as u64))
        } else {
            (0, 0)
        };
        let v8 = 0x1::vector::empty<HeroInfoDto>();
        let v9 = 0;
        while (v9 < v1) {
            let v10 = 0x1::vector::borrow<HeroInfo>(&v0.heroes, v9);
            let v11 = HeroInfoDto{
                nft_id        : v10.nft_id,
                stake_ts      : v10.stake_ts,
                cooldown_ts   : v10.cooldown_ts,
                status        : v10.status,
                health_status : (get_hero_health_status(&v10.cached_traits) as u8),
            };
            0x1::vector::push_back<HeroInfoDto>(&mut v8, v11);
            v9 = v9 + 1;
        };
        HeroDashboardInfo{
            staked_heroes             : v8,
            total_heroes_count        : v1,
            pending_influence         : v2,
            influence_rate_per_day    : v3,
            last_patrol_claim_ts      : v0.last_patrol_claim_ts,
            last_urr_raffle_ts        : v0.last_urr_raffle_ts,
            rep_player                : v0.rep_player,
            rep_land_id               : 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg1, v0.rep_player),
            last_rep_player_change_ts : v0.last_rep_player_change_ts,
        }
    }

    fun get_hero_health_status(arg0: &vector<u16>) : u16 {
        *0x1::vector::borrow<u16>(arg0, 10)
    }

    fun get_hero_level(arg0: &vector<u16>) : u16 {
        *0x1::vector::borrow<u16>(arg0, 9)
    }

    fun get_patrolling_heroes_multiplier_sum(arg0: &vector<HeroInfo>) : (u128, u128) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<HeroInfo>(arg0)) {
            let v3 = 0x1::vector::borrow<HeroInfo>(arg0, v2);
            if (v3.status == 2) {
                v0 = v0 + 1;
                v1 = v1 + 10000 + ((get_hero_level(&v3.cached_traits) as u128) - 1) * 2000;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_staked_heroes(arg0: &HeroStakingPool, arg1: address) : vector<HeroInfoDto> {
        assert!(0x2::table::contains<address, HeroUserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<address, HeroUserInfo>(&arg0.users, arg1);
        let v1 = 0x1::vector::empty<HeroInfoDto>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<HeroInfo>(&v0.heroes)) {
            let v3 = 0x1::vector::borrow<HeroInfo>(&v0.heroes, v2);
            let v4 = HeroInfoDto{
                nft_id        : v3.nft_id,
                stake_ts      : v3.stake_ts,
                cooldown_ts   : v3.cooldown_ts,
                status        : v3.status,
                health_status : (get_hero_health_status(&v3.cached_traits) as u8),
            };
            0x1::vector::push_back<HeroInfoDto>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun get_urr_coin_types(arg0: &HeroStakingPool) : vector<0x1::string::String> {
        arg0.urr_coin_types
    }

    public entry fun initialize_hero_staking_pool(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = HeroStakingPool{
            id                  : 0x2::object::new(arg2),
            admin_address       : 0x2::tx_context::sender(arg2),
            treasury_address    : @0x844dd285ddfc12628f51f1091e22495657230b188c260ae692ad6bfa20aa0b2,
            users               : 0x2::table::new<address, HeroUserInfo>(arg2),
            stakers             : 0x1::vector::empty<address>(),
            kiosk               : v0,
            kiosk_owner_cap     : v1,
            pawtato_package_cap : arg1,
            urr_coin_types      : 0x1::vector::empty<0x1::string::String>(),
            fragment_coin_types : 0x1::vector::empty<0x1::string::String>(),
            version             : 1,
            paused              : false,
        };
        0x2::transfer::share_object<HeroStakingPool>(v2);
    }

    fun is_user_registered(arg0: &HeroStakingPool, arg1: address) : bool {
        0x2::table::contains<address, HeroUserInfo>(&arg0.users, arg1)
    }

    fun mint_and_transfer_coin<T0>(arg0: &HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::mint_coin_with_cap<T0>(&arg0.pawtato_package_cap, arg1, 0x2::object::id<HeroStakingPool>(arg0), arg2, arg4), arg3);
    }

    fun parse_class(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : u16 {
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Class");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &v0)) {
            let v2 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, &v0);
            if (*0x1::string::bytes(v2) == b"Knight") {
                (0 as u16)
            } else if (*0x1::string::bytes(v2) == b"Mage") {
                (1 as u16)
            } else if (*0x1::string::bytes(v2) == b"Rogue") {
                (2 as u16)
            } else if (*0x1::string::bytes(v2) == b"Archer") {
                (3 as u16)
            } else if (*0x1::string::bytes(v2) == b"Druid") {
                (4 as u16)
            } else {
                (0 as u16)
            }
        } else {
            (0 as u16)
        }
    }

    fun parse_hero_attributes(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : vector<u16> {
        let v0 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        *0x1::vector::borrow_mut<u16>(&mut v0, 0) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Vitality"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 1) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Agility"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 2) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Strength"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 3) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Dexterity"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 4) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Intelligence"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 5) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Luck"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 6) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Stamina"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 7) = parse_class(arg0);
        *0x1::vector::borrow_mut<u16>(&mut v0, 8) = parse_tier(arg0);
        *0x1::vector::borrow_mut<u16>(&mut v0, 9) = parse_numeric_stat(arg0, 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Level"));
        *0x1::vector::borrow_mut<u16>(&mut v0, 10) = 0;
        v0
    }

    fun parse_numeric_stat(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg1: 0x1::string::String) : u16 {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &arg1)) {
            let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::string_to_u64(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, &arg1));
            if (v1 > 65535) {
                65535
            } else {
                (v1 as u16)
            }
        } else {
            0
        }
    }

    fun parse_tier(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : u16 {
        let v0 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Tier");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &v0)) {
            let v2 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, &v0);
            if (*0x1::string::bytes(v2) == b"Common") {
                (0 as u16)
            } else if (*0x1::string::bytes(v2) == b"Uncommon") {
                (1 as u16)
            } else if (*0x1::string::bytes(v2) == b"Rare") {
                (2 as u16)
            } else if (*0x1::string::bytes(v2) == b"Epic") {
                (3 as u16)
            } else if (*0x1::string::bytes(v2) == b"Legendary") {
                (4 as u16)
            } else if (*0x1::string::bytes(v2) == b"Mythic") {
                (5 as u16)
            } else {
                (0 as u16)
            }
        } else {
            (0 as u16)
        }
    }

    fun process_influence_claim(arg0: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut HeroUserInfo, arg3: address, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: bool) {
        let v0 = calculate_total_influence_with_decimals(&arg2.heroes, arg2.last_patrol_claim_ts, arg6, arg2.influence_carry);
        let (v1, v2, v3) = if (arg7 && ((v0 / 1000000000) as u64) > 0 || true) {
            0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::calculate_boosted_influence_reward(arg0, arg1, arg3, v0, 1000000000, arg6)
        } else {
            (0, v0 % 1000000000, 10000)
        };
        let v4 = v2 * (10000 as u128) / (v3 as u128);
        arg2.last_patrol_claim_ts = arg6;
        arg2.influence_carry = v4;
        if (v1 > 0) {
            0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::hero_helpers::add_land_influence(arg0, arg1, arg4, arg5, v1);
            let v5 = InfluenceClaimed{
                user             : arg3,
                land_id          : arg5,
                influence_amount : v1,
                carry_over       : v4,
            };
            0x2::event::emit<InfluenceClaimed>(v5);
        };
    }

    fun register_user(arg0: &mut HeroStakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!is_user_registered(arg0, arg1)) {
            let v0 = HeroUserInfo{
                id                        : 0x2::object::new(arg2),
                heroes                    : 0x1::vector::empty<HeroInfo>(),
                last_patrol_claim_ts      : 0,
                last_urr_raffle_ts        : 0,
                influence_carry           : 0,
                rep_player                : arg1,
                last_rep_player_change_ts : 0,
            };
            0x2::table::add<address, HeroUserInfo>(&mut arg0.users, arg1, v0);
            0x1::vector::push_back<address>(&mut arg0.stakers, arg1);
            let v1 = UserRegistered{user: arg1};
            0x2::event::emit<UserRegistered>(v1);
        };
    }

    fun remove_hero_from_user(arg0: &mut HeroStakingPool, arg1: address, arg2: u64) {
        0x1::vector::remove<HeroInfo>(&mut 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, arg1).heroes, arg2);
    }

    public entry fun reset_rep_player(arg0: &mut HeroStakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_user_registered(arg0, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        assert!(v1.rep_player != v0, 14);
        v1.rep_player = v0;
        v1.last_rep_player_change_ts = 0x2::clock::timestamp_ms(arg1);
        let v2 = RepresentingPlayerSetV2{
            user            : v0,
            prev_rep_player : v1.rep_player,
            rep_player      : v0,
        };
        0x2::event::emit<RepresentingPlayerSetV2>(v2);
    }

    public entry fun set_fragment_coin_types(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fragment_coin_types = arg2;
    }

    public(friend) fun set_hero_cached_trait(arg0: &mut HeroStakingPool, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u16) {
        assert!(0x2::table::contains<address, HeroUserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<HeroInfo>(&v0.heroes)) {
            let v2 = 0x1::vector::borrow_mut<HeroInfo>(&mut v0.heroes, v1);
            if (v2.nft_id == arg2) {
                *0x1::vector::borrow_mut<u16>(&mut v2.cached_traits, arg3) = arg4;
                return
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    public entry fun set_paused(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun set_rep_player(arg0: &mut HeroStakingPool, arg1: &0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_user_registered(arg0, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= v1.last_rep_player_change_ts + 259200000, 13);
        let v3 = 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_rep_land_id(arg1, arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v3), 7);
        v1.rep_player = arg2;
        v1.last_rep_player_change_ts = v2;
        let v4 = RepresentingPlayerSetV2{
            user            : v0,
            prev_rep_player : v1.rep_player,
            rep_player      : arg2,
        };
        0x2::event::emit<RepresentingPlayerSetV2>(v4);
    }

    public entry fun set_urr_coin_types(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.urr_coin_types = arg2;
    }

    public entry fun stake_hero(arg0: &mut HeroStakingPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        register_user(arg0, v0, arg6);
        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::direct_transfer<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(arg1, arg2, &mut arg0.kiosk, &arg0.kiosk_owner_cap, arg3, arg4, arg6);
        let v1 = HeroInfo{
            nft_id        : arg3,
            stake_ts      : 0x2::clock::timestamp_ms(arg5),
            cooldown_ts   : 0x1::option::none<u64>(),
            status        : 0,
            cached_traits : parse_hero_attributes(0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::get_attributes(0x2::kiosk::borrow<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(&arg0.kiosk, &arg0.kiosk_owner_cap, arg3))),
        };
        0x1::vector::push_back<HeroInfo>(&mut 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0).heroes, v1);
        let v2 = HeroStaked{
            user   : v0,
            nft_id : arg3,
        };
        0x2::event::emit<HeroStaked>(v2);
    }

    public entry fun start_patrolling(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_user_registered(arg0, v0), 3);
        auto_claim_influence(arg0, arg1, arg3, v0);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = find_hero_index(&v1.heroes, *0x1::vector::borrow<0x2::object::ID>(&arg2, v2));
            assert!(0x1::option::is_some<u64>(&v3), 4);
            let v4 = 0x1::vector::borrow_mut<HeroInfo>(&mut v1.heroes, 0x1::option::destroy_some<u64>(v3));
            assert!(v4.status == 0, 11);
            assert!(get_hero_health_status(&v4.cached_traits) == 0, 15);
            v4.status = 2;
            v2 = v2 + 1;
        };
        if (count_patrolling_heroes(&v1.heroes) == 0) {
            v1.last_patrol_claim_ts = 0x2::clock::timestamp_ms(arg3);
        };
        let v5 = PatrollingStarted{
            user     : v0,
            hero_ids : arg2,
        };
        0x2::event::emit<PatrollingStarted>(v5);
    }

    public entry fun unstake_hero(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_user_registered(arg0, v0), 3);
        auto_claim_influence(arg0, arg1, arg3, v0);
        let v1 = 0x2::table::borrow_mut<address, HeroUserInfo>(&mut arg0.users, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<HeroInfo>(&v1.heroes)) {
            let v3 = 0x1::vector::borrow_mut<HeroInfo>(&mut v1.heroes, v2);
            if (v3.nft_id == arg2) {
                assert!(v3.status == 0, 11);
                assert!(get_hero_health_status(&v3.cached_traits) == 0, 15);
                assert!(0x1::option::is_none<u64>(&v3.cooldown_ts), 16);
                v3.cooldown_ts = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3) + 259200000);
                v3.status = 1;
                let v4 = HeroUnstakeInitiated{
                    user                 : v0,
                    nft_id               : arg2,
                    cooldown_duration_ms : 259200000,
                };
                0x2::event::emit<HeroUnstakeInitiated>(v4);
                return
            };
            v2 = v2 + 1;
        };
        abort 4
    }

    public entry fun update_admin_address(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin_address = arg2;
    }

    public entry fun update_treasury_address(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
    }

    public entry fun upgrade_version(arg0: &0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HeroAdminCap, arg1: &mut HeroStakingPool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 13906841681946214399);
        arg1.version = 1;
    }

    public entry fun withdraw_hero(arg0: &mut HeroStakingPool, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(is_user_registered(arg0, v0), 3);
        auto_claim_influence(arg0, arg1, arg6, v0);
        let v1 = find_hero_for_withdraw(arg0, arg4, 0x2::clock::timestamp_ms(arg6), v0);
        0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_kiosk_helpers::direct_transfer<0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes::HERO>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg2, arg3, arg4, arg5, arg7);
        remove_hero_from_user(arg0, v0, v1);
        let v2 = HeroWithdrawn{
            user   : v0,
            nft_id : arg4,
        };
        0x2::event::emit<HeroWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

