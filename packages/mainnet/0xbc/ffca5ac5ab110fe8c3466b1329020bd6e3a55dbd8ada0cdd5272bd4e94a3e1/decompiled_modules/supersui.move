module 0xbcffca5ac5ab110fe8c3466b1329020bd6e3a55dbd8ada0cdd5272bd4e94a3e1::supersui {
    struct Registry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, UserInfo>,
        id_to_address: 0x2::table::Table<u64, address>,
        level_prices: 0x2::table::Table<u8, u64>,
        last_user_id: u64,
        owner: address,
        marketing_wallets: vector<address>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        mining_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        token_exchange_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        ssui_treasury: 0x2::balance::Balance<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>,
        x3_earnings: 0x2::table::Table<address, u64>,
        x6_earnings: 0x2::table::Table<address, u64>,
        x8_earnings: 0x2::table::Table<address, u64>,
        ssui_earnings: 0x2::table::Table<address, u64>,
        ssui_exchanged: 0x2::table::Table<address, u64>,
        weekly_supersui_distributed: u64,
        last_leader_distribution_ts: u64,
        paused: bool,
        pending_owner: address,
    }

    struct UserInfo has store {
        user_id: u64,
        referrer: address,
        partners_count: u64,
        mining_balance: u64,
        total_withdrawn: u64,
        last_withdrawal: u64,
        active_x3_levels: 0x2::table::Table<u8, bool>,
        active_x6_levels: 0x2::table::Table<u8, bool>,
        active_x8_levels: 0x2::table::Table<u8, bool>,
        x3_matrices: 0x2::table::Table<u8, X3Matrix>,
        x6_matrices: 0x2::table::Table<u8, X6Matrix>,
        x8_matrices: 0x2::table::Table<u8, X8Matrix>,
        referrals: vector<address>,
        total_team_count: u64,
    }

    struct X3Matrix has copy, drop, store {
        current_referrer: address,
        referrals: vector<address>,
        blocked: bool,
        reinvest_count: u64,
    }

    struct X6Matrix has copy, drop, store {
        current_referrer: address,
        first_level_referrals: vector<address>,
        second_level_referrals: vector<address>,
        blocked: bool,
        reinvest_count: u64,
        closed_part: address,
    }

    struct X8Matrix has copy, drop, store {
        current_referrer: address,
        current_referrer_index: u8,
        first_level_referrals: vector<address>,
        second_level_referrals: vector<address>,
        third_level_referrals: vector<address>,
        blocked: bool,
        reinvest_count: u64,
        closed_part: address,
    }

    struct RegistrationEvent has copy, drop {
        user: address,
        referrer: address,
        user_id: u64,
        referrer_id: u64,
    }

    struct UpgradeEvent has copy, drop {
        user: address,
        referrer: address,
        matrix: u8,
        level: u8,
    }

    struct ReinvestEvent has copy, drop {
        user: address,
        current_referrer: address,
        caller: address,
        matrix: u8,
        level: u8,
    }

    struct NewUserPlaceEvent has copy, drop {
        user: address,
        referrer: address,
        matrix: u8,
        level: u8,
        place: u8,
    }

    struct MiningWithdrawalEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct MarketingFeeDistributedEvent has copy, drop {
        amount: u64,
    }

    struct X3DistributionEvent has copy, drop {
        user: address,
        referrer: address,
        amount: u64,
    }

    struct X6DistributionEvent has copy, drop {
        user: address,
        referrer: address,
        amount: u64,
    }

    struct X8DistributionEvent has copy, drop {
        user: address,
        referrer: address,
        amount: u64,
    }

    struct ExchangeSupersuiToSuiEvent has copy, drop {
        user: address,
        supersui_amount: u64,
        sui_amount: u64,
    }

    struct ExchangeSuiToSupersuiEvent has copy, drop {
        user: address,
        sui_amount: u64,
        supersui_amount: u64,
    }

    struct LeaderRewardsDistributedEvent has copy, drop {
        weekly_total: u64,
        first_caller: address,
        first_caller_reward: u64,
    }

    struct OwnershipTransferProposedEvent has copy, drop {
        current_owner: address,
        pending_owner: address,
    }

    struct OwnershipTransferredEvent has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct MarketingWalletsUpdatedEvent has copy, drop {
        wallet: address,
    }

    struct SsuiTreasuryDepositEvent has copy, drop {
        depositor: address,
        amount: u64,
    }

    struct ReplaceIdAddressEvent has copy, drop {
        user_id: u64,
        old_address: address,
        new_address: address,
    }

    public entry fun accept_ownership(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner != @0x0, 23);
        assert!(0x2::tx_context::sender(arg1) == arg0.pending_owner, 22);
        assert!(is_user_exists(arg0, arg0.pending_owner), 3);
        arg0.owner = arg0.pending_owner;
        arg0.pending_owner = @0x0;
        let v0 = OwnershipTransferredEvent{
            old_owner : arg0.owner,
            new_owner : arg0.owner,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    fun activate_user_level_for_matrix(arg0: &mut Registry, arg1: address, arg2: u8, arg3: u8) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1);
        if (arg2 == 1) {
            assert!(*0x2::table::borrow<u8, bool>(&v0.active_x3_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v0.active_x3_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v0.active_x3_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v0.active_x3_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v0.active_x3_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X3Matrix>(&v0.x3_matrices, arg3)) {
                let v1 = X3Matrix{
                    current_referrer : @0x0,
                    referrals        : 0x1::vector::empty<address>(),
                    blocked          : false,
                    reinvest_count   : 0,
                };
                0x2::table::add<u8, X3Matrix>(&mut v0.x3_matrices, arg3, v1);
            };
        } else if (arg2 == 2) {
            assert!(*0x2::table::borrow<u8, bool>(&v0.active_x6_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v0.active_x6_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v0.active_x6_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v0.active_x6_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v0.active_x6_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X6Matrix>(&v0.x6_matrices, arg3)) {
                let v2 = X6Matrix{
                    current_referrer       : @0x0,
                    first_level_referrals  : 0x1::vector::empty<address>(),
                    second_level_referrals : 0x1::vector::empty<address>(),
                    blocked                : false,
                    reinvest_count         : 0,
                    closed_part            : @0x0,
                };
                0x2::table::add<u8, X6Matrix>(&mut v0.x6_matrices, arg3, v2);
            };
        } else {
            assert!(*0x2::table::borrow<u8, bool>(&v0.active_x8_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v0.active_x8_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v0.active_x8_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v0.active_x8_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v0.active_x8_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X8Matrix>(&v0.x8_matrices, arg3)) {
                let v3 = X8Matrix{
                    current_referrer       : @0x0,
                    current_referrer_index : 0,
                    first_level_referrals  : 0x1::vector::empty<address>(),
                    second_level_referrals : 0x1::vector::empty<address>(),
                    third_level_referrals  : 0x1::vector::empty<address>(),
                    blocked                : false,
                    reinvest_count         : 0,
                    closed_part            : @0x0,
                };
                0x2::table::add<u8, X8Matrix>(&mut v0.x8_matrices, arg3, v3);
            };
        };
    }

    fun add_ssui_earnings(arg0: &mut Registry, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (!0x2::table::contains<address, u64>(&arg0.ssui_earnings, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.ssui_earnings, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.ssui_earnings, arg1);
        *v0 = *v0 + arg2;
    }

    fun add_ssui_exchanged(arg0: &mut Registry, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (!0x2::table::contains<address, u64>(&arg0.ssui_exchanged, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.ssui_exchanged, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.ssui_exchanged, arg1);
        *v0 = *v0 + arg2;
    }

    public entry fun admin_deposit_ssui_treasury(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        let v0 = 0x2::coin::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg1);
        assert!(v0 > 0, 15);
        0x2::balance::join<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&mut arg0.ssui_treasury, 0x2::coin::into_balance<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(arg1));
        let v1 = SsuiTreasuryDepositEvent{
            depositor : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<SsuiTreasuryDepositEvent>(v1);
    }

    public entry fun admin_grant_free_level_all_matrices(arg0: &mut Registry, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(is_user_exists(arg0, arg1), 3);
        assert!(arg2 > 1 && arg2 <= 16, 6);
        activate_user_level_for_matrix(arg0, arg1, 1, arg2);
        activate_user_level_for_matrix(arg0, arg1, 2, arg2);
        activate_user_level_for_matrix(arg0, arg1, 3, arg2);
        initialize_matrices(arg0, arg1, arg2);
        update_initialized_matrices(arg0, arg1, arg2);
        let v0 = UpgradeEvent{
            user     : arg1,
            referrer : arg1,
            matrix   : 1,
            level    : arg2,
        };
        0x2::event::emit<UpgradeEvent>(v0);
        let v1 = UpgradeEvent{
            user     : arg1,
            referrer : arg1,
            matrix   : 2,
            level    : arg2,
        };
        0x2::event::emit<UpgradeEvent>(v1);
        let v2 = UpgradeEvent{
            user     : arg1,
            referrer : arg1,
            matrix   : 3,
            level    : arg2,
        };
        0x2::event::emit<UpgradeEvent>(v2);
    }

    public entry fun admin_grant_free_level_matrix(arg0: &mut Registry, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 5);
        assert!(is_user_exists(arg0, arg1), 3);
        assert!(arg2 >= 1 && arg2 <= 3, 12);
        assert!(arg3 > 1 && arg3 <= 16, 6);
        activate_user_level_for_matrix(arg0, arg1, arg2, arg3);
        initialize_single_matrix(arg0, arg1, arg2, arg3);
        update_initialized_single_matrix(arg0, arg1, arg2, arg3);
        let v0 = UpgradeEvent{
            user     : arg1,
            referrer : arg1,
            matrix   : arg2,
            level    : arg3,
        };
        0x2::event::emit<UpgradeEvent>(v0);
    }

    public entry fun admin_register_full(arg0: &mut Registry, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 5);
        assert!(!is_user_exists(arg0, arg1), 1);
        let v0 = arg0.last_user_id;
        let v1 = arg0.owner;
        let v2 = UserInfo{
            user_id          : v0,
            referrer         : v1,
            partners_count   : 0,
            mining_balance   : 0,
            total_withdrawn  : 0,
            last_withdrawal  : 0x2::clock::timestamp_ms(arg3),
            active_x3_levels : 0x2::table::new<u8, bool>(arg4),
            active_x6_levels : 0x2::table::new<u8, bool>(arg4),
            active_x8_levels : 0x2::table::new<u8, bool>(arg4),
            x3_matrices      : 0x2::table::new<u8, X3Matrix>(arg4),
            x6_matrices      : 0x2::table::new<u8, X6Matrix>(arg4),
            x8_matrices      : 0x2::table::new<u8, X8Matrix>(arg4),
            referrals        : 0x1::vector::empty<address>(),
            total_team_count : 0,
        };
        let v3 = 1;
        while (v3 <= arg2 && v3 <= 16) {
            0x2::table::add<u8, bool>(&mut v2.active_x3_levels, v3, true);
            0x2::table::add<u8, bool>(&mut v2.active_x6_levels, v3, true);
            0x2::table::add<u8, bool>(&mut v2.active_x8_levels, v3, true);
            let v4 = X3Matrix{
                current_referrer : @0x0,
                referrals        : 0x1::vector::empty<address>(),
                blocked          : false,
                reinvest_count   : 0,
            };
            0x2::table::add<u8, X3Matrix>(&mut v2.x3_matrices, v3, v4);
            let v5 = X6Matrix{
                current_referrer       : @0x0,
                first_level_referrals  : 0x1::vector::empty<address>(),
                second_level_referrals : 0x1::vector::empty<address>(),
                blocked                : false,
                reinvest_count         : 0,
                closed_part            : @0x0,
            };
            0x2::table::add<u8, X6Matrix>(&mut v2.x6_matrices, v3, v5);
            let v6 = X8Matrix{
                current_referrer       : @0x0,
                current_referrer_index : 0,
                first_level_referrals  : 0x1::vector::empty<address>(),
                second_level_referrals : 0x1::vector::empty<address>(),
                third_level_referrals  : 0x1::vector::empty<address>(),
                blocked                : false,
                reinvest_count         : 0,
                closed_part            : @0x0,
            };
            0x2::table::add<u8, X8Matrix>(&mut v2.x8_matrices, v3, v6);
            v3 = v3 + 1;
        };
        0x2::table::add<address, UserInfo>(&mut arg0.users, arg1, v2);
        0x2::table::add<u64, address>(&mut arg0.id_to_address, v0, arg1);
        arg0.last_user_id = v0 + 1;
        0x2::table::add<address, u64>(&mut arg0.x3_earnings, arg1, 0);
        0x2::table::add<address, u64>(&mut arg0.x6_earnings, arg1, 0);
        0x2::table::add<address, u64>(&mut arg0.x8_earnings, arg1, 0);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1).referrals, arg1);
        increment_ancestor_team_counts(arg0, v1);
        v3 = 1;
        while (v3 <= arg2 && v3 <= 16) {
            initialize_matrices(arg0, arg1, v3);
            update_initialized_matrices(arg0, arg1, v3);
            v3 = v3 + 1;
        };
        let v7 = RegistrationEvent{
            user        : arg1,
            referrer    : v1,
            user_id     : v0,
            referrer_id : 1,
        };
        0x2::event::emit<RegistrationEvent>(v7);
    }

    public entry fun buy_supersui_with_sui(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.paused, 21);
        assert!(is_user_exists(arg0, v0), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 15);
        assert!(v1 >= 1000000000, 25);
        assert!(v1 <= 100000000000, 26);
        let v2 = (((v1 as u128) * 10 / 9) as u64);
        assert!(v2 > 0, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.token_exchange_treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg0.ssui_treasury) >= v2, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>>(0x2::coin::take<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&mut arg0.ssui_treasury, v2, arg2), v0);
        add_ssui_earnings(arg0, v0, v2);
        let v3 = ExchangeSuiToSupersuiEvent{
            user            : v0,
            sui_amount      : v1,
            supersui_amount : v2,
        };
        0x2::event::emit<ExchangeSuiToSupersuiEvent>(v3);
    }

    public fun calculate_roi(arg0: &Registry, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!is_user_exists(arg0, arg1)) {
            return 0
        };
        calculate_roi_internal(0x2::table::borrow<address, UserInfo>(&arg0.users, arg1), 0x2::clock::timestamp_ms(arg2))
    }

    public fun calculate_roi_internal(arg0: &UserInfo, arg1: u64) : u64 {
        let v0 = arg0.mining_balance;
        let v1 = v0 * 200 / 100;
        if (v1 <= arg0.total_withdrawn) {
            return 0
        };
        let v2 = arg1 - arg0.last_withdrawal;
        if (v2 < 86400000) {
            return 0
        };
        let v3 = v0 * 2 / 100 * v2 / 1000 / 86400;
        if (arg0.total_withdrawn + v3 > v1) {
            v1 - arg0.total_withdrawn
        } else {
            v3
        }
    }

    public entry fun distribute_leader_rewards(arg0: &mut Registry, arg1: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.last_leader_distribution_ts;
        let v2 = if (v1 == 0) {
            v0 / 604800000 * 604800000 + 151200000
        } else {
            get_next_thursday_1610_utc_ms(v1)
        };
        assert!(v0 >= v2, 18);
        assert!(arg0.weekly_supersui_distributed > 0, 19);
        let v3 = arg0.weekly_supersui_distributed;
        let v4 = v3 / 1000;
        if (v4 == 0) {
            arg0.weekly_supersui_distributed = 0;
            arg0.last_leader_distribution_ts = v0;
            return
        };
        let v5 = 0x2::tx_context::sender(arg3);
        let (v6, v7, v8) = find_top3_by_earned(arg0);
        let (v9, v10, v11) = find_top3_by_total_team(arg0);
        let (v12, v13, v14) = find_top3_by_referral_count(arg0);
        let v15 = 0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg0.ssui_treasury);
        let v16 = if (v4 * 10 > v15) {
            v15 / 10
        } else {
            v4
        };
        if (v16 == 0) {
            arg0.weekly_supersui_distributed = 0;
            arg0.last_leader_distribution_ts = v0;
            return
        };
        let v17 = 0x1::vector::empty<address>();
        let v18 = 0x1::vector::empty<u64>();
        let v19 = 0x1::vector::empty<address>();
        let v20 = &mut v19;
        0x1::vector::push_back<address>(v20, v6);
        0x1::vector::push_back<address>(v20, v7);
        0x1::vector::push_back<address>(v20, v8);
        0x1::vector::push_back<address>(v20, v9);
        0x1::vector::push_back<address>(v20, v10);
        0x1::vector::push_back<address>(v20, v11);
        0x1::vector::push_back<address>(v20, v12);
        0x1::vector::push_back<address>(v20, v13);
        0x1::vector::push_back<address>(v20, v14);
        0x1::vector::push_back<address>(v20, v5);
        let v21 = 0;
        while (v21 < 10) {
            let v22 = *0x1::vector::borrow<address>(&v19, v21);
            if (v22 != @0x0) {
                let v23 = false;
                let v24 = 0;
                while (v24 < 0x1::vector::length<address>(&v17)) {
                    if (*0x1::vector::borrow<address>(&v17, v24) == v22) {
                        let v25 = 0x1::vector::borrow_mut<u64>(&mut v18, v24);
                        *v25 = *v25 + 1;
                        v23 = true;
                        break
                    };
                    v24 = v24 + 1;
                };
                if (!v23) {
                    0x1::vector::push_back<address>(&mut v17, v22);
                    0x1::vector::push_back<u64>(&mut v18, 1);
                };
            };
            v21 = v21 + 1;
        };
        let v26 = 0;
        while (v26 < 0x1::vector::length<address>(&v17)) {
            let v27 = *0x1::vector::borrow<address>(&v17, v26);
            let v28 = v16 * *0x1::vector::borrow<u64>(&v18, v26);
            let v29 = 0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg0.ssui_treasury);
            let v30 = if (v28 > v29) {
                v29
            } else {
                v28
            };
            if (v30 > 0) {
                transfer_ssui_from_treasury(arg0, v27, v30, arg3);
                add_ssui_earnings(arg0, v27, v30);
            };
            v26 = v26 + 1;
        };
        arg0.weekly_supersui_distributed = 0;
        arg0.last_leader_distribution_ts = v0;
        let v31 = LeaderRewardsDistributedEvent{
            weekly_total        : v3,
            first_caller        : v5,
            first_caller_reward : v16,
        };
        0x2::event::emit<LeaderRewardsDistributedEvent>(v31);
    }

    fun distribute_marketing_fee_from_balance(arg0: &mut Registry, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<address>(&arg0.marketing_wallets) < 1) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, arg1);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg2), *0x1::vector::borrow<address>(&arg0.marketing_wallets, 0));
        let v0 = MarketingFeeDistributedEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<MarketingFeeDistributedEvent>(v0);
    }

    fun distribute_marketing_fee_from_mining_treasury(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<address>(&arg0.marketing_wallets) < 1 || 0x2::balance::value<0x2::sui::SUI>(&arg0.mining_treasury) < arg1) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.mining_treasury, arg1, arg2), *0x1::vector::borrow<address>(&arg0.marketing_wallets, 0));
        let v0 = MarketingFeeDistributedEvent{amount: arg1};
        0x2::event::emit<MarketingFeeDistributedEvent>(v0);
    }

    fun distribute_registration_fee(arg0: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg1: &mut Registry, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = v0 * 15 / 100;
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.users, arg2);
        v2.mining_balance = v2.mining_balance + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.mining_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.token_exchange_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 10 / 100));
        let v3 = 0x2::table::borrow<u8, X3Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x3_matrices, arg4).current_referrer;
        distribute_to_x3_matrix(arg1, arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 20 / 100), arg4, arg5);
        let v4 = 0x2::table::borrow<u8, X6Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x6_matrices, arg4).current_referrer;
        distribute_to_x6_matrix(arg1, arg2, v4, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 25 / 100), arg4, arg5);
        let v5 = 0x2::table::borrow<u8, X8Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x8_matrices, arg4).current_referrer;
        distribute_to_x8_matrix(arg1, arg2, v5, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 25 / 100), arg4, arg5);
        let v6 = 0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).referrer;
        distribute_supersui_tokens(arg0, arg1, arg2, v0, v6, arg5);
        distribute_marketing_fee_from_balance(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 5 / 100), arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, arg3);
    }

    fun distribute_supersui_tokens(arg0: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg1: &mut Registry, arg2: address, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * 3 / 100;
        let v1 = v0;
        let v2 = arg3 * 3 / 100;
        let v3 = v2;
        let v4 = arg3 * 3 / 100;
        let v5 = v4;
        let v6 = v0 + v2 + v4;
        let v7 = 0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg1.ssui_treasury);
        if (v7 == 0) {
            return
        };
        if (v6 > v7) {
            let v8 = (((v0 as u128) * (v7 as u128) / (v6 as u128)) as u64);
            v1 = v8;
            let v9 = (((v2 as u128) * (v7 as u128) / (v6 as u128)) as u64);
            v3 = v9;
            v5 = v7 - v8 - v9;
        };
        if (v1 > 0) {
            transfer_ssui_from_treasury(arg1, arg2, v1, arg5);
        };
        if (v3 > 0) {
            let v10 = arg1.owner;
            transfer_ssui_from_treasury(arg1, v10, v3, arg5);
        };
        if (v5 > 0 && arg4 != @0x0) {
            transfer_ssui_from_treasury(arg1, arg4, v5, arg5);
        };
        arg1.weekly_supersui_distributed = arg1.weekly_supersui_distributed + v1 + v3 + v5;
        add_ssui_earnings(arg1, arg2, v1);
        if (arg4 != @0x0) {
            add_ssui_earnings(arg1, arg4, v5);
        };
    }

    fun distribute_to_x3_matrix(arg0: &mut Registry, arg1: address, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = arg0.owner;
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg2);
        let v3 = if (0x1::vector::length<address>(&0x2::table::borrow<u8, X3Matrix>(&v2.x3_matrices, arg4).referrals) + 1 <= 2) {
            if (0x2::table::contains<u8, bool>(&v2.active_x3_levels, arg4) && *0x2::table::borrow<u8, bool>(&v2.active_x3_levels, arg4)) {
                arg2
            } else {
                find_free_x3_referrer(arg0, arg2, arg4)
            }
        } else {
            let v4 = v2.referrer;
            if (v4 != @0x0) {
                let v5 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v4);
                if (0x2::table::contains<u8, bool>(&v5.active_x3_levels, arg4) && *0x2::table::borrow<u8, bool>(&v5.active_x3_levels, arg4)) {
                    v4
                } else {
                    find_free_x3_referrer(arg0, v4, arg4)
                }
            } else {
                v1
            }
        };
        let v6 = if (v3 == @0x0) {
            v1
        } else {
            v3
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5), v6);
        let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.x3_earnings, v6);
        *v7 = *v7 + v0;
        let v8 = X3DistributionEvent{
            user     : arg1,
            referrer : arg2,
            amount   : v0,
        };
        0x2::event::emit<X3DistributionEvent>(v8);
    }

    fun distribute_to_x6_matrix(arg0: &mut Registry, arg1: address, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = arg0.owner;
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg2);
        let v3 = 0x2::table::borrow<u8, X6Matrix>(&v2.x6_matrices, arg4);
        let v4 = 0x1::vector::length<address>(&v3.first_level_referrals) + 0x1::vector::length<address>(&v3.second_level_referrals) + 1;
        let v5 = if (v4 <= 2 || v4 == 6) {
            let v6 = v2.referrer;
            if (v6 != @0x0) {
                let v7 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v6);
                if (0x2::table::contains<u8, bool>(&v7.active_x6_levels, arg4) && *0x2::table::borrow<u8, bool>(&v7.active_x6_levels, arg4)) {
                    v6
                } else {
                    find_free_x6_referrer(arg0, v6, arg4)
                }
            } else {
                v1
            }
        } else if (0x2::table::contains<u8, bool>(&v2.active_x6_levels, arg4) && *0x2::table::borrow<u8, bool>(&v2.active_x6_levels, arg4)) {
            arg2
        } else {
            find_free_x6_referrer(arg0, arg2, arg4)
        };
        let v8 = if (v5 == @0x0) {
            v1
        } else {
            v5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5), v8);
        let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg0.x6_earnings, v8);
        *v9 = *v9 + v0;
        let v10 = X6DistributionEvent{
            user     : arg1,
            referrer : arg2,
            amount   : v0,
        };
        0x2::event::emit<X6DistributionEvent>(v10);
    }

    fun distribute_to_x8_matrix(arg0: &mut Registry, arg1: address, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = arg0.owner;
        let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg2);
        let v3 = 0x2::table::borrow<u8, X8Matrix>(&v2.x8_matrices, arg4);
        let v4 = 0x1::vector::length<address>(&v3.first_level_referrals) + 0x1::vector::length<address>(&v3.second_level_referrals) + 0x1::vector::length<address>(&v3.third_level_referrals) + 1;
        let v5 = if (v4 <= 2) {
            let v6 = v2.referrer;
            if (v6 != @0x0) {
                let v7 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v6).referrer;
                if (v7 != @0x0) {
                    let v8 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v7);
                    if (0x2::table::contains<u8, bool>(&v8.active_x8_levels, arg4) && *0x2::table::borrow<u8, bool>(&v8.active_x8_levels, arg4)) {
                        v7
                    } else {
                        find_free_x8_referrer(arg0, v7, arg4)
                    }
                } else {
                    find_free_x8_referrer(arg0, v6, arg4)
                }
            } else {
                v1
            }
        } else if (v4 <= 6 || v4 == 14) {
            let v9 = v2.referrer;
            if (v9 != @0x0) {
                let v10 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v9);
                if (0x2::table::contains<u8, bool>(&v10.active_x8_levels, arg4) && *0x2::table::borrow<u8, bool>(&v10.active_x8_levels, arg4)) {
                    v9
                } else {
                    find_free_x8_referrer(arg0, v9, arg4)
                }
            } else {
                v1
            }
        } else if (0x2::table::contains<u8, bool>(&v2.active_x8_levels, arg4) && *0x2::table::borrow<u8, bool>(&v2.active_x8_levels, arg4)) {
            arg2
        } else {
            find_free_x8_referrer(arg0, arg2, arg4)
        };
        let v11 = if (v5 == @0x0) {
            v1
        } else {
            v5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5), v11);
        let v12 = 0x2::table::borrow_mut<address, u64>(&mut arg0.x8_earnings, v11);
        *v12 = *v12 + v0;
        let v13 = X8DistributionEvent{
            user     : arg1,
            referrer : arg2,
            amount   : v0,
        };
        0x2::event::emit<X8DistributionEvent>(v13);
    }

    fun distribute_upgrade_fee(arg0: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg1: &mut Registry, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = v0 * 15 / 100;
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.users, arg2);
        v2.mining_balance = v2.mining_balance + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.mining_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.token_exchange_treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 10 / 100));
        if (arg4 == 1) {
            let v3 = 0x2::table::borrow<u8, X3Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x3_matrices, arg5).current_referrer;
            distribute_to_x3_matrix(arg1, arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 70 / 100), arg5, arg6);
        } else if (arg4 == 2) {
            let v4 = 0x2::table::borrow<u8, X6Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x6_matrices, arg5).current_referrer;
            distribute_to_x6_matrix(arg1, arg2, v4, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 70 / 100), arg5, arg6);
        } else {
            let v5 = 0x2::table::borrow<u8, X8Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x8_matrices, arg5).current_referrer;
            distribute_to_x8_matrix(arg1, arg2, v5, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 70 / 100), arg5, arg6);
        };
        let v6 = if (arg4 == 1) {
            0x2::table::borrow<u8, X3Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x3_matrices, arg5).current_referrer
        } else if (arg4 == 2) {
            0x2::table::borrow<u8, X6Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x6_matrices, arg5).current_referrer
        } else {
            0x2::table::borrow<u8, X8Matrix>(&0x2::table::borrow<address, UserInfo>(&arg1.users, arg2).x8_matrices, arg5).current_referrer
        };
        distribute_supersui_tokens(arg0, arg1, arg2, v0, v6, arg6);
        distribute_marketing_fee_from_balance(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v0 * 5 / 100), arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, arg3);
    }

    public entry fun exchange_supersui_to_sui(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.paused, 21);
        assert!(is_user_exists(arg0, v0), 3);
        let v1 = 0x2::coin::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg1);
        assert!(v1 > 0, 15);
        assert!(v1 >= 1000000000, 25);
        assert!(v1 <= 100000000000, 26);
        if (v0 != arg0.owner) {
            let v2 = get_ssui_earnings(arg0, v0);
            let v3 = get_ssui_exchanged(arg0, v0);
            let v4 = if (v2 > v3) {
                v2 - v3
            } else {
                0
            };
            assert!(v1 <= v4, 20);
            add_ssui_exchanged(arg0, v0, v1);
        };
        let v5 = (((v1 as u128) * 9 / 10) as u64);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.token_exchange_treasury) >= v5, 13);
        0x2::balance::join<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&mut arg0.ssui_treasury, 0x2::coin::into_balance<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.token_exchange_treasury, v5), arg2), v0);
        let v6 = ExchangeSupersuiToSuiEvent{
            user            : v0,
            supersui_amount : v1,
            sui_amount      : v5,
        };
        0x2::event::emit<ExchangeSupersuiToSuiEvent>(v6);
    }

    public fun find_free_x3_referrer(arg0: &Registry, arg1: address, arg2: u8) : address {
        let v0 = arg1;
        let v1 = 0;
        loop {
            if (v1 >= 1000) {
                break
            };
            v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0).referrer;
            if (v0 == @0x0) {
                return arg0.owner
            };
            let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0);
            if (0x2::table::contains<u8, bool>(&v2.active_x3_levels, arg2) && *0x2::table::borrow<u8, bool>(&v2.active_x3_levels, arg2)) {
                return v0
            };
            v1 = v1 + 1;
        };
        arg0.owner
    }

    public fun find_free_x6_referrer(arg0: &Registry, arg1: address, arg2: u8) : address {
        let v0 = arg1;
        let v1 = 0;
        loop {
            if (v1 >= 1000) {
                break
            };
            v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0).referrer;
            if (v0 == @0x0) {
                return arg0.owner
            };
            let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0);
            if (0x2::table::contains<u8, bool>(&v2.active_x6_levels, arg2) && *0x2::table::borrow<u8, bool>(&v2.active_x6_levels, arg2)) {
                return v0
            };
            v1 = v1 + 1;
        };
        arg0.owner
    }

    public fun find_free_x8_referrer(arg0: &Registry, arg1: address, arg2: u8) : address {
        let v0 = arg1;
        let v1 = 0;
        loop {
            if (v1 >= 1000) {
                break
            };
            v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0).referrer;
            if (v0 == @0x0) {
                return arg0.owner
            };
            let v2 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v0);
            if (0x2::table::contains<u8, bool>(&v2.active_x8_levels, arg2) && *0x2::table::borrow<u8, bool>(&v2.active_x8_levels, arg2)) {
                return v0
            };
            v1 = v1 + 1;
        };
        arg0.owner
    }

    fun find_top3_by_earned(arg0: &Registry) : (address, address, address) {
        let v0 = @0x0;
        let v1 = v0;
        let v2 = @0x0;
        let v3 = v2;
        let v4 = @0x0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = if (arg0.last_user_id <= 100000) {
            arg0.last_user_id
        } else {
            100000
        };
        let v10 = 1;
        while (v10 < v9) {
            if (!0x2::table::contains<u64, address>(&arg0.id_to_address, v10)) {
                v10 = v10 + 1;
                continue
            };
            let v11 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, v10);
            if (v11 == @0x0 || !0x2::table::contains<address, UserInfo>(&arg0.users, v11)) {
                v10 = v10 + 1;
                continue
            };
            let v12 = if (v11 == v0) {
                true
            } else if (v11 == v2) {
                true
            } else {
                v11 == v4
            };
            if (v12) {
                v10 = v10 + 1;
                continue
            };
            if (v0 == @0x0) {
                v1 = v11;
            } else if (v2 == @0x0) {
                v3 = v11;
            } else if (v4 == @0x0) {
                v5 = v11;
            } else {
                let (v13, v14) = if (v6 <= v7 && v6 <= v8) {
                    (v6, 0)
                } else if (v7 <= v8) {
                    (v7, 1)
                } else {
                    (v8, 2)
                };
                if (get_x3_earnings(arg0, v11) + get_x6_earnings(arg0, v11) + get_x8_earnings(arg0, v11) + 0x2::table::borrow<address, UserInfo>(&arg0.users, v11).total_withdrawn > v13) {
                    if (v14 == 0) {
                        v1 = v11;
                    } else if (v14 == 1) {
                        v3 = v11;
                    } else {
                        v5 = v11;
                    };
                };
            };
            v10 = v10 + 1;
        };
        (v1, v3, v5)
    }

    fun find_top3_by_referral_count(arg0: &Registry) : (address, address, address) {
        let v0 = @0x0;
        let v1 = v0;
        let v2 = @0x0;
        let v3 = v2;
        let v4 = @0x0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = if (arg0.last_user_id <= 100000) {
            arg0.last_user_id
        } else {
            100000
        };
        let v10 = 1;
        while (v10 < v9) {
            if (!0x2::table::contains<u64, address>(&arg0.id_to_address, v10)) {
                v10 = v10 + 1;
                continue
            };
            let v11 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, v10);
            if (v11 == @0x0 || !0x2::table::contains<address, UserInfo>(&arg0.users, v11)) {
                v10 = v10 + 1;
                continue
            };
            let v12 = if (v11 == v0) {
                true
            } else if (v11 == v2) {
                true
            } else {
                v11 == v4
            };
            if (v12) {
                v10 = v10 + 1;
                continue
            };
            if (v0 == @0x0) {
                v1 = v11;
            } else if (v2 == @0x0) {
                v3 = v11;
            } else if (v4 == @0x0) {
                v5 = v11;
            } else {
                let (v13, v14) = if (v6 <= v7 && v6 <= v8) {
                    (v6, 0)
                } else if (v7 <= v8) {
                    (v7, 1)
                } else {
                    (v8, 2)
                };
                if (0x1::vector::length<address>(&0x2::table::borrow<address, UserInfo>(&arg0.users, v11).referrals) > v13) {
                    if (v14 == 0) {
                        v1 = v11;
                    } else if (v14 == 1) {
                        v3 = v11;
                    } else {
                        v5 = v11;
                    };
                };
            };
            v10 = v10 + 1;
        };
        (v1, v3, v5)
    }

    fun find_top3_by_total_team(arg0: &Registry) : (address, address, address) {
        let v0 = @0x0;
        let v1 = v0;
        let v2 = @0x0;
        let v3 = v2;
        let v4 = @0x0;
        let v5 = v4;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = if (arg0.last_user_id <= 100000) {
            arg0.last_user_id
        } else {
            100000
        };
        let v10 = 1;
        while (v10 < v9) {
            if (!0x2::table::contains<u64, address>(&arg0.id_to_address, v10)) {
                v10 = v10 + 1;
                continue
            };
            let v11 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, v10);
            if (v11 == @0x0 || !0x2::table::contains<address, UserInfo>(&arg0.users, v11)) {
                v10 = v10 + 1;
                continue
            };
            let v12 = if (v11 == v0) {
                true
            } else if (v11 == v2) {
                true
            } else {
                v11 == v4
            };
            if (v12) {
                v10 = v10 + 1;
                continue
            };
            if (v0 == @0x0) {
                v1 = v11;
            } else if (v2 == @0x0) {
                v3 = v11;
            } else if (v4 == @0x0) {
                v5 = v11;
            } else {
                let (v13, v14) = if (v6 <= v7 && v6 <= v8) {
                    (v6, 0)
                } else if (v7 <= v8) {
                    (v7, 1)
                } else {
                    (v8, 2)
                };
                if (0x2::table::borrow<address, UserInfo>(&arg0.users, v11).total_team_count > v13) {
                    if (v14 == 0) {
                        v1 = v11;
                    } else if (v14 == 1) {
                        v3 = v11;
                    } else {
                        v5 = v11;
                    };
                };
            };
            v10 = v10 + 1;
        };
        (v1, v3, v5)
    }

    public fun get_address_by_id(arg0: &Registry, arg1: u64) : address {
        if (!0x2::table::contains<u64, address>(&arg0.id_to_address, arg1)) {
            return @0x0
        };
        *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg1)
    }

    public fun get_all_active_x3_levels(arg0: &Registry, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v2 = 1;
        while (v2 <= 16) {
            if (0x2::table::contains<u8, bool>(&v1.active_x3_levels, v2) && *0x2::table::borrow<u8, bool>(&v1.active_x3_levels, v2)) {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_all_active_x6_levels(arg0: &Registry, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v2 = 1;
        while (v2 <= 16) {
            if (0x2::table::contains<u8, bool>(&v1.active_x6_levels, v2) && *0x2::table::borrow<u8, bool>(&v1.active_x6_levels, v2)) {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_all_active_x8_levels(arg0: &Registry, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        let v2 = 1;
        while (v2 <= 16) {
            if (0x2::table::contains<u8, bool>(&v1.active_x8_levels, v2) && *0x2::table::borrow<u8, bool>(&v1.active_x8_levels, v2)) {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_all_users_overview(arg0: &Registry, arg1: u64) : (vector<address>, vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = if (arg1 == 0 || arg1 >= arg0.last_user_id) {
            arg0.last_user_id
        } else {
            arg1 + 1
        };
        let v6 = 1;
        while (v6 < v5) {
            let v7 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, v6);
            let v8 = 0x2::table::borrow<address, UserInfo>(&arg0.users, v7);
            let v9 = if (0x2::table::contains<address, u64>(&arg0.x3_earnings, v7)) {
                *0x2::table::borrow<address, u64>(&arg0.x3_earnings, v7)
            } else {
                0
            };
            let v10 = if (0x2::table::contains<address, u64>(&arg0.x6_earnings, v7)) {
                *0x2::table::borrow<address, u64>(&arg0.x6_earnings, v7)
            } else {
                0
            };
            let v11 = if (0x2::table::contains<address, u64>(&arg0.x8_earnings, v7)) {
                *0x2::table::borrow<address, u64>(&arg0.x8_earnings, v7)
            } else {
                0
            };
            0x1::vector::push_back<address>(&mut v0, v7);
            0x1::vector::push_back<u64>(&mut v1, v8.user_id);
            0x1::vector::push_back<u64>(&mut v2, v9 + v10 + v11 + v8.total_withdrawn);
            0x1::vector::push_back<u64>(&mut v3, 0x1::vector::length<address>(&v8.referrals));
            0x1::vector::push_back<u64>(&mut v4, v8.partners_count);
            v6 = v6 + 1;
        };
        (v0, v1, v2, v3, v4)
    }

    public fun get_global_statistics(arg0: &Registry) : (u64, u64, u64, u64, u64, u64) {
        let v0 = if (arg0.last_user_id <= 1) {
            0
        } else {
            arg0.last_user_id - 1
        };
        (v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), 0x2::balance::value<0x2::sui::SUI>(&arg0.mining_treasury), 0x2::balance::value<0x2::sui::SUI>(&arg0.token_exchange_treasury), arg0.weekly_supersui_distributed, arg0.last_leader_distribution_ts)
    }

    public fun get_last_assigned_user_id(arg0: &Registry) : u64 {
        if (arg0.last_user_id <= 1) {
            return 0
        };
        arg0.last_user_id - 1
    }

    public fun get_last_leader_distribution_ts(arg0: &Registry) : u64 {
        arg0.last_leader_distribution_ts
    }

    public fun get_last_withdrawal(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).last_withdrawal
    }

    public fun get_level_price(arg0: &Registry, arg1: u8) : u64 {
        *0x2::table::borrow<u8, u64>(&arg0.level_prices, arg1)
    }

    public fun get_mining_balance(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).mining_balance
    }

    public fun get_mining_treasury_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.mining_treasury)
    }

    fun get_next_thursday_1610_utc_ms(arg0: u64) : u64 {
        let v0 = arg0 / 604800000 * 604800000 + 151200000;
        if (v0 <= arg0) {
            v0 + 604800000
        } else {
            v0
        }
    }

    public fun get_owner(arg0: &Registry) : address {
        arg0.owner
    }

    public fun get_partners_count(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).partners_count
    }

    public fun get_platform_cumulative_stats(arg0: &Registry, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = if (arg1 == 0 || arg1 >= arg0.last_user_id) {
            arg0.last_user_id
        } else {
            arg1 + 1
        };
        let v5 = 1;
        while (v5 < v4) {
            let v6 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, v5);
            if (0x2::table::contains<address, u64>(&arg0.x3_earnings, v6)) {
                v0 = v0 + *0x2::table::borrow<address, u64>(&arg0.x3_earnings, v6);
            };
            if (0x2::table::contains<address, u64>(&arg0.x6_earnings, v6)) {
                v1 = v1 + *0x2::table::borrow<address, u64>(&arg0.x6_earnings, v6);
            };
            if (0x2::table::contains<address, u64>(&arg0.x8_earnings, v6)) {
                v2 = v2 + *0x2::table::borrow<address, u64>(&arg0.x8_earnings, v6);
            };
            v3 = v3 + 0x2::table::borrow<address, UserInfo>(&arg0.users, v6).total_withdrawn;
            v5 = v5 + 1;
        };
        (v0, v1, v2, v3)
    }

    public fun get_referral_tree(arg0: &Registry, arg1: address, arg2: u64) : (vector<address>, vector<address>, vector<u64>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return (v0, v1, v2)
        };
        0x1::vector::push_back<address>(&mut v0, arg1);
        0x1::vector::push_back<address>(&mut v1, @0x0);
        0x1::vector::push_back<u64>(&mut v2, 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).user_id);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0) && 0x1::vector::length<address>(&v0) < arg2) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            v3 = v3 + 1;
            if (0x2::table::contains<address, UserInfo>(&arg0.users, v4)) {
                let v5 = &0x2::table::borrow<address, UserInfo>(&arg0.users, v4).referrals;
                let v6 = 0;
                while (v6 < 0x1::vector::length<address>(v5) && 0x1::vector::length<address>(&v0) < arg2) {
                    let v7 = *0x1::vector::borrow<address>(v5, v6);
                    if (0x2::table::contains<address, UserInfo>(&arg0.users, v7)) {
                        0x1::vector::push_back<address>(&mut v0, v7);
                        0x1::vector::push_back<address>(&mut v1, v4);
                        0x1::vector::push_back<u64>(&mut v2, 0x2::table::borrow<address, UserInfo>(&arg0.users, v7).user_id);
                    };
                    v6 = v6 + 1;
                };
            };
        };
        (v0, v1, v2)
    }

    public fun get_registration_fee() : u64 {
        1000000000
    }

    public fun get_ssui_earnings(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.ssui_earnings, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.ssui_earnings, arg1)
    }

    public fun get_ssui_exchangeable_remaining(arg0: &Registry, arg1: address) : u64 {
        let v0 = get_ssui_earnings(arg0, arg1);
        let v1 = get_ssui_exchanged(arg0, arg1);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun get_ssui_exchanged(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.ssui_exchanged, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.ssui_exchanged, arg1)
    }

    public fun get_ssui_treasury_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg0.ssui_treasury)
    }

    public fun get_token_exchange_treasury_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.token_exchange_treasury)
    }

    public fun get_total_team_count(arg0: &Registry, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        let v2 = &0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).referrals;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(v2)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v2, v3));
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v1) && v0 < arg2) {
            let v5 = *0x1::vector::borrow<address>(&v1, v4);
            v4 = v4 + 1;
            v0 = v0 + 1;
            if (0x2::table::contains<address, UserInfo>(&arg0.users, v5)) {
                let v6 = &0x2::table::borrow<address, UserInfo>(&arg0.users, v5).referrals;
                let v7 = 0;
                while (v7 < 0x1::vector::length<address>(v6)) {
                    0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v6, v7));
                    v7 = v7 + 1;
                };
            };
        };
        v0
    }

    public fun get_total_withdrawn(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).total_withdrawn
    }

    public fun get_treasury_balance(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun get_user_id(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).user_id
    }

    public fun get_user_overview(arg0: &Registry, arg1: address, arg2: &0x2::clock::Clock) : (u64, address, u64, u64, u64, u64, u64, u64, u64, u64, u64, vector<u8>, vector<u8>, vector<u8>) {
        let v0 = get_user_referrals(arg0, arg1);
        (get_user_id(arg0, arg1), get_user_referrer(arg0, arg1), get_partners_count(arg0, arg1), 0x1::vector::length<address>(&v0), get_mining_balance(arg0, arg1), get_total_withdrawn(arg0, arg1), get_last_withdrawal(arg0, arg1), calculate_roi(arg0, arg1, arg2), get_x3_earnings(arg0, arg1), get_x6_earnings(arg0, arg1), get_x8_earnings(arg0, arg1), get_all_active_x3_levels(arg0, arg1), get_all_active_x6_levels(arg0, arg1), get_all_active_x8_levels(arg0, arg1))
    }

    public fun get_user_referrals(arg0: &Registry, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return 0x1::vector::empty<address>()
        };
        let v0 = &0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).referrals;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_user_referrer(arg0: &Registry, arg1: address) : address {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return @0x0
        };
        0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).referrer
    }

    public fun get_users_per_level_counts(arg0: &Registry, arg1: u64) : (vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 16) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v1, 0);
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = if (arg1 == 0 || arg1 >= arg0.last_user_id) {
            arg0.last_user_id
        } else {
            arg1 + 1
        };
        let v5 = 1;
        while (v5 < v4) {
            let v6 = 0x2::table::borrow<address, UserInfo>(&arg0.users, *0x2::table::borrow<u64, address>(&arg0.id_to_address, v5));
            let v7 = 1;
            while (v7 <= 16) {
                let v8 = ((v7 - 1) as u64);
                if (0x2::table::contains<u8, bool>(&v6.active_x3_levels, v7) && *0x2::table::borrow<u8, bool>(&v6.active_x3_levels, v7)) {
                    let v9 = 0x1::vector::borrow_mut<u64>(&mut v0, v8);
                    *v9 = *v9 + 1;
                };
                if (0x2::table::contains<u8, bool>(&v6.active_x6_levels, v7) && *0x2::table::borrow<u8, bool>(&v6.active_x6_levels, v7)) {
                    let v10 = 0x1::vector::borrow_mut<u64>(&mut v1, v8);
                    *v10 = *v10 + 1;
                };
                if (0x2::table::contains<u8, bool>(&v6.active_x8_levels, v7) && *0x2::table::borrow<u8, bool>(&v6.active_x8_levels, v7)) {
                    let v11 = 0x1::vector::borrow_mut<u64>(&mut v2, v8);
                    *v11 = *v11 + 1;
                };
                v7 = v7 + 1;
            };
            v5 = v5 + 1;
        };
        (v0, v1, v2)
    }

    public fun get_weekly_supersui_distributed(arg0: &Registry) : u64 {
        arg0.weekly_supersui_distributed
    }

    public fun get_x3_earnings(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.x3_earnings, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.x3_earnings, arg1)
    }

    public fun get_x3_matrix(arg0: &Registry, arg1: address, arg2: u8) : (address, vector<address>, u64) {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        assert!(0x2::table::contains<u8, X3Matrix>(&v0.x3_matrices, arg2), 6);
        let v1 = 0x2::table::borrow<u8, X3Matrix>(&v0.x3_matrices, arg2);
        (v1.current_referrer, v1.referrals, v1.reinvest_count)
    }

    public fun get_x6_earnings(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.x6_earnings, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.x6_earnings, arg1)
    }

    public fun get_x6_matrix(arg0: &Registry, arg1: address, arg2: u8) : (address, vector<address>, vector<address>, u64) {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        assert!(0x2::table::contains<u8, X6Matrix>(&v0.x6_matrices, arg2), 6);
        let v1 = 0x2::table::borrow<u8, X6Matrix>(&v0.x6_matrices, arg2);
        (v1.current_referrer, v1.first_level_referrals, v1.second_level_referrals, v1.reinvest_count)
    }

    public fun get_x8_earnings(arg0: &Registry, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.x8_earnings, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.x8_earnings, arg1)
    }

    public fun get_x8_matrix(arg0: &Registry, arg1: address, arg2: u8) : (address, vector<address>, vector<address>, vector<address>, u64) {
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, arg1), 3);
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        assert!(0x2::table::contains<u8, X8Matrix>(&v0.x8_matrices, arg2), 6);
        let v1 = 0x2::table::borrow<u8, X8Matrix>(&v0.x8_matrices, arg2);
        (v1.current_referrer, v1.first_level_referrals, v1.second_level_referrals, v1.third_level_referrals, v1.reinvest_count)
    }

    fun increment_ancestor_team_counts(arg0: &mut Registry, arg1: address) {
        let v0 = 0;
        while (arg1 != @0x0 && v0 < 1000) {
            if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
                break
            };
            let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1);
            v1.total_team_count = v1.total_team_count + 1;
            arg1 = v1.referrer;
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id                          : 0x2::object::new(arg0),
            users                       : 0x2::table::new<address, UserInfo>(arg0),
            id_to_address               : 0x2::table::new<u64, address>(arg0),
            level_prices                : 0x2::table::new<u8, u64>(arg0),
            last_user_id                : 2,
            owner                       : v0,
            marketing_wallets           : vector[@0x846f4863c1eaff52854181d17c7caa061afa14ed767da3d02f43a23584753a1d],
            treasury                    : 0x2::balance::zero<0x2::sui::SUI>(),
            mining_treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            token_exchange_treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            ssui_treasury               : 0x2::balance::zero<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(),
            x3_earnings                 : 0x2::table::new<address, u64>(arg0),
            x6_earnings                 : 0x2::table::new<address, u64>(arg0),
            x8_earnings                 : 0x2::table::new<address, u64>(arg0),
            ssui_earnings               : 0x2::table::new<address, u64>(arg0),
            ssui_exchanged              : 0x2::table::new<address, u64>(arg0),
            weekly_supersui_distributed : 0,
            last_leader_distribution_ts : 0,
            paused                      : false,
            pending_owner               : @0x0,
        };
        let v2 = 1;
        let v3 = 1000000000;
        while (v2 <= 16) {
            0x2::table::add<u8, u64>(&mut v1.level_prices, v2, v3);
            v3 = v3 * 2;
            v2 = v2 + 1;
        };
        let v4 = UserInfo{
            user_id          : 1,
            referrer         : @0x0,
            partners_count   : 0,
            mining_balance   : 0,
            total_withdrawn  : 0,
            last_withdrawal  : 0,
            active_x3_levels : 0x2::table::new<u8, bool>(arg0),
            active_x6_levels : 0x2::table::new<u8, bool>(arg0),
            active_x8_levels : 0x2::table::new<u8, bool>(arg0),
            x3_matrices      : 0x2::table::new<u8, X3Matrix>(arg0),
            x6_matrices      : 0x2::table::new<u8, X6Matrix>(arg0),
            x8_matrices      : 0x2::table::new<u8, X8Matrix>(arg0),
            referrals        : 0x1::vector::empty<address>(),
            total_team_count : 0,
        };
        v2 = 1;
        while (v2 <= 16) {
            0x2::table::add<u8, bool>(&mut v4.active_x3_levels, v2, true);
            0x2::table::add<u8, bool>(&mut v4.active_x6_levels, v2, true);
            0x2::table::add<u8, bool>(&mut v4.active_x8_levels, v2, true);
            let v5 = X3Matrix{
                current_referrer : @0x0,
                referrals        : 0x1::vector::empty<address>(),
                blocked          : false,
                reinvest_count   : 0,
            };
            0x2::table::add<u8, X3Matrix>(&mut v4.x3_matrices, v2, v5);
            let v6 = X6Matrix{
                current_referrer       : @0x0,
                first_level_referrals  : 0x1::vector::empty<address>(),
                second_level_referrals : 0x1::vector::empty<address>(),
                blocked                : false,
                reinvest_count         : 0,
                closed_part            : @0x0,
            };
            0x2::table::add<u8, X6Matrix>(&mut v4.x6_matrices, v2, v6);
            let v7 = X8Matrix{
                current_referrer       : @0x0,
                current_referrer_index : 0,
                first_level_referrals  : 0x1::vector::empty<address>(),
                second_level_referrals : 0x1::vector::empty<address>(),
                third_level_referrals  : 0x1::vector::empty<address>(),
                blocked                : false,
                reinvest_count         : 0,
                closed_part            : @0x0,
            };
            0x2::table::add<u8, X8Matrix>(&mut v4.x8_matrices, v2, v7);
            v2 = v2 + 1;
        };
        0x2::table::add<address, UserInfo>(&mut v1.users, v0, v4);
        0x2::table::add<u64, address>(&mut v1.id_to_address, 1, v0);
        0x2::table::add<address, u64>(&mut v1.x3_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut v1.x6_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut v1.x8_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut v1.ssui_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut v1.ssui_exchanged, v0, 0);
        0x2::transfer::share_object<Registry>(v1);
    }

    fun initialize_matrices(arg0: &mut Registry, arg1: address, arg2: u8) {
        0x2::table::borrow_mut<u8, X3Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x3_matrices, arg2).current_referrer = find_free_x3_referrer(arg0, arg1, arg2);
        0x2::table::borrow_mut<u8, X6Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x6_matrices, arg2).current_referrer = find_free_x6_referrer(arg0, arg1, arg2);
        0x2::table::borrow_mut<u8, X8Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x8_matrices, arg2).current_referrer = find_free_x8_referrer(arg0, arg1, arg2);
    }

    fun initialize_single_matrix(arg0: &mut Registry, arg1: address, arg2: u8, arg3: u8) {
        if (arg2 == 1) {
            0x2::table::borrow_mut<u8, X3Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x3_matrices, arg3).current_referrer = find_free_x3_referrer(arg0, arg1, arg3);
        } else if (arg2 == 2) {
            0x2::table::borrow_mut<u8, X6Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x6_matrices, arg3).current_referrer = find_free_x6_referrer(arg0, arg1, arg3);
        } else if (arg2 == 3) {
            0x2::table::borrow_mut<u8, X8Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg1).x8_matrices, arg3).current_referrer = find_free_x8_referrer(arg0, arg1, arg3);
        };
    }

    public fun is_active_x3_level(arg0: &Registry, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        if (!0x2::table::contains<u8, bool>(&v0.active_x3_levels, arg2)) {
            return false
        };
        *0x2::table::borrow<u8, bool>(&v0.active_x3_levels, arg2)
    }

    public fun is_active_x6_level(arg0: &Registry, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        if (!0x2::table::contains<u8, bool>(&v0.active_x6_levels, arg2)) {
            return false
        };
        *0x2::table::borrow<u8, bool>(&v0.active_x6_levels, arg2)
    }

    public fun is_active_x8_level(arg0: &Registry, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
        if (!0x2::table::contains<u8, bool>(&v0.active_x8_levels, arg2)) {
            return false
        };
        *0x2::table::borrow<u8, bool>(&v0.active_x8_levels, arg2)
    }

    public fun is_user_exists(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, UserInfo>(&arg0.users, arg1)
    }

    public entry fun pause(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 5);
        arg0.paused = true;
        let v0 = PauseEvent{paused: true};
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun propose_owner(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        arg0.pending_owner = arg1;
        let v0 = OwnershipTransferProposedEvent{
            current_owner : arg0.owner,
            pending_owner : arg1,
        };
        0x2::event::emit<OwnershipTransferProposedEvent>(v0);
    }

    public entry fun register(arg0: &mut Registry, arg1: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.paused, 21);
        let v1 = if (arg2 == @0x0) {
            arg0.owner
        } else {
            arg2
        };
        assert!(v1 != @0x0, 2);
        assert!(!is_user_exists(arg0, v0), 1);
        assert!(is_user_exists(arg0, v1), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 1000000000, 4);
        let v2 = arg0.last_user_id;
        let v3 = UserInfo{
            user_id          : v2,
            referrer         : v1,
            partners_count   : 0,
            mining_balance   : 0,
            total_withdrawn  : 0,
            last_withdrawal  : 0x2::clock::timestamp_ms(arg4),
            active_x3_levels : 0x2::table::new<u8, bool>(arg5),
            active_x6_levels : 0x2::table::new<u8, bool>(arg5),
            active_x8_levels : 0x2::table::new<u8, bool>(arg5),
            x3_matrices      : 0x2::table::new<u8, X3Matrix>(arg5),
            x6_matrices      : 0x2::table::new<u8, X6Matrix>(arg5),
            x8_matrices      : 0x2::table::new<u8, X8Matrix>(arg5),
            referrals        : 0x1::vector::empty<address>(),
            total_team_count : 0,
        };
        0x2::table::add<u8, bool>(&mut v3.active_x3_levels, 1, true);
        0x2::table::add<u8, bool>(&mut v3.active_x6_levels, 1, true);
        0x2::table::add<u8, bool>(&mut v3.active_x8_levels, 1, true);
        let v4 = X3Matrix{
            current_referrer : @0x0,
            referrals        : 0x1::vector::empty<address>(),
            blocked          : false,
            reinvest_count   : 0,
        };
        0x2::table::add<u8, X3Matrix>(&mut v3.x3_matrices, 1, v4);
        let v5 = X6Matrix{
            current_referrer       : @0x0,
            first_level_referrals  : 0x1::vector::empty<address>(),
            second_level_referrals : 0x1::vector::empty<address>(),
            blocked                : false,
            reinvest_count         : 0,
            closed_part            : @0x0,
        };
        0x2::table::add<u8, X6Matrix>(&mut v3.x6_matrices, 1, v5);
        let v6 = X8Matrix{
            current_referrer       : @0x0,
            current_referrer_index : 0,
            first_level_referrals  : 0x1::vector::empty<address>(),
            second_level_referrals : 0x1::vector::empty<address>(),
            third_level_referrals  : 0x1::vector::empty<address>(),
            blocked                : false,
            reinvest_count         : 0,
            closed_part            : @0x0,
        };
        0x2::table::add<u8, X8Matrix>(&mut v3.x8_matrices, 1, v6);
        0x2::table::add<address, UserInfo>(&mut arg0.users, v0, v3);
        0x2::table::add<u64, address>(&mut arg0.id_to_address, v2, v0);
        arg0.last_user_id = v2 + 1;
        0x2::table::add<address, u64>(&mut arg0.x3_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut arg0.x6_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut arg0.x8_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut arg0.ssui_earnings, v0, 0);
        0x2::table::add<address, u64>(&mut arg0.ssui_exchanged, v0, 0);
        let v7 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1);
        v7.partners_count = v7.partners_count + 1;
        0x1::vector::push_back<address>(&mut v7.referrals, v0);
        increment_ancestor_team_counts(arg0, v1);
        initialize_matrices(arg0, v0, 1);
        distribute_registration_fee(arg1, arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), 1, arg5);
        update_initialized_matrices(arg0, v0, 1);
        let v8 = RegistrationEvent{
            user        : v0,
            referrer    : v1,
            user_id     : v2,
            referrer_id : v7.user_id,
        };
        0x2::event::emit<RegistrationEvent>(v8);
    }

    fun replace_address_in_vector(arg0: vector<address>, arg1: address, arg2: address) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<address>(&arg0, v1);
            let v3 = if (v2 == arg1) {
                arg2
            } else {
                v2
            };
            0x1::vector::push_back<address>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun replace_id_address(arg0: &mut Registry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        assert!(arg1 != 1, 17);
        assert!(0x2::table::contains<u64, address>(&arg0.id_to_address, arg1), 16);
        assert!(!is_user_exists(arg0, arg2), 1);
        let v0 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg1);
        let v1 = 0x2::table::remove<address, UserInfo>(&mut arg0.users, v0);
        v1.mining_balance = 0;
        v1.total_withdrawn = 0;
        v1.last_withdrawal = 0x2::tx_context::epoch_timestamp_ms(arg3);
        0x2::table::remove<u64, address>(&mut arg0.id_to_address, arg1);
        0x2::table::add<address, UserInfo>(&mut arg0.users, arg2, v1);
        0x2::table::add<u64, address>(&mut arg0.id_to_address, arg1, arg2);
        if (0x2::table::contains<address, u64>(&arg0.x3_earnings, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.x3_earnings, v0);
        };
        if (0x2::table::contains<address, u64>(&arg0.x6_earnings, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.x6_earnings, v0);
        };
        if (0x2::table::contains<address, u64>(&arg0.x8_earnings, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.x8_earnings, v0);
        };
        if (0x2::table::contains<address, u64>(&arg0.ssui_earnings, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.ssui_earnings, v0);
        };
        if (0x2::table::contains<address, u64>(&arg0.ssui_exchanged, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.ssui_exchanged, v0);
        };
        0x2::table::add<address, u64>(&mut arg0.x3_earnings, arg2, 0);
        0x2::table::add<address, u64>(&mut arg0.x6_earnings, arg2, 0);
        0x2::table::add<address, u64>(&mut arg0.x8_earnings, arg2, 0);
        0x2::table::add<address, u64>(&mut arg0.ssui_earnings, arg2, 0);
        0x2::table::add<address, u64>(&mut arg0.ssui_exchanged, arg2, 0);
        let v2 = ReplaceIdAddressEvent{
            user_id     : arg1,
            old_address : v0,
            new_address : arg2,
        };
        0x2::event::emit<ReplaceIdAddressEvent>(v2);
    }

    public entry fun replace_id_references_batch(arg0: &mut Registry, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 5);
        assert!(arg3 >= 1 && arg3 < arg4, 24);
        let v0 = if (arg4 > arg0.last_user_id) {
            arg0.last_user_id
        } else {
            arg4
        };
        while (arg3 < v0) {
            if (0x2::table::contains<u64, address>(&arg0.id_to_address, arg3)) {
                let v1 = *0x2::table::borrow<u64, address>(&arg0.id_to_address, arg3);
                if (0x2::table::contains<address, UserInfo>(&arg0.users, v1)) {
                    0x2::table::add<address, UserInfo>(&mut arg0.users, v1, update_user_references(0x2::table::remove<address, UserInfo>(&mut arg0.users, v1), arg1, arg2));
                };
            };
            arg3 = arg3 + 1;
        };
    }

    fun replace_in_x3_matrix(arg0: X3Matrix, arg1: address, arg2: address) : X3Matrix {
        let v0 = if (arg0.current_referrer == arg1) {
            arg2
        } else {
            arg0.current_referrer
        };
        X3Matrix{
            current_referrer : v0,
            referrals        : replace_address_in_vector(arg0.referrals, arg1, arg2),
            blocked          : arg0.blocked,
            reinvest_count   : arg0.reinvest_count,
        }
    }

    fun replace_in_x6_matrix(arg0: X6Matrix, arg1: address, arg2: address) : X6Matrix {
        let v0 = if (arg0.current_referrer == arg1) {
            arg2
        } else {
            arg0.current_referrer
        };
        let v1 = if (arg0.closed_part == arg1) {
            arg2
        } else {
            arg0.closed_part
        };
        X6Matrix{
            current_referrer       : v0,
            first_level_referrals  : replace_address_in_vector(arg0.first_level_referrals, arg1, arg2),
            second_level_referrals : replace_address_in_vector(arg0.second_level_referrals, arg1, arg2),
            blocked                : arg0.blocked,
            reinvest_count         : arg0.reinvest_count,
            closed_part            : v1,
        }
    }

    fun replace_in_x8_matrix(arg0: X8Matrix, arg1: address, arg2: address) : X8Matrix {
        let v0 = if (arg0.current_referrer == arg1) {
            arg2
        } else {
            arg0.current_referrer
        };
        let v1 = if (arg0.closed_part == arg1) {
            arg2
        } else {
            arg0.closed_part
        };
        X8Matrix{
            current_referrer       : v0,
            current_referrer_index : arg0.current_referrer_index,
            first_level_referrals  : replace_address_in_vector(arg0.first_level_referrals, arg1, arg2),
            second_level_referrals : replace_address_in_vector(arg0.second_level_referrals, arg1, arg2),
            third_level_referrals  : replace_address_in_vector(arg0.third_level_referrals, arg1, arg2),
            blocked                : arg0.blocked,
            reinvest_count         : arg0.reinvest_count,
            closed_part            : v1,
        }
    }

    public entry fun set_marketing_wallets(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 5);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg1);
        arg0.marketing_wallets = v0;
        let v1 = MarketingWalletsUpdatedEvent{wallet: arg1};
        0x2::event::emit<MarketingWalletsUpdatedEvent>(v1);
    }

    fun transfer_ssui_from_treasury(arg0: &mut Registry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0 || arg1 == @0x0) {
            return
        };
        if (0x2::balance::value<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&arg0.ssui_treasury) < arg2) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>>(0x2::coin::take<0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::SSUI>(&mut arg0.ssui_treasury, arg2, arg3), arg1);
    }

    public entry fun unpause(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 5);
        arg0.paused = false;
        let v0 = PauseEvent{paused: false};
        0x2::event::emit<PauseEvent>(v0);
    }

    fun update_initialized_matrices(arg0: &mut Registry, arg1: address, arg2: u8) {
        let v0 = 0x2::table::borrow<u8, X3Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x3_matrices, arg2).current_referrer;
        update_x3_referrer(arg0, arg1, v0, arg2);
        let v1 = 0x2::table::borrow<u8, X6Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x6_matrices, arg2).current_referrer;
        update_x6_referrer(arg0, arg1, v1, arg2);
        let v2 = 0x2::table::borrow<u8, X8Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x8_matrices, arg2).current_referrer;
        update_x8_referrer(arg0, arg1, v2, arg2);
    }

    fun update_initialized_single_matrix(arg0: &mut Registry, arg1: address, arg2: u8, arg3: u8) {
        if (arg2 == 1) {
            let v0 = 0x2::table::borrow<u8, X3Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x3_matrices, arg3).current_referrer;
            update_x3_referrer(arg0, arg1, v0, arg3);
        } else if (arg2 == 2) {
            let v1 = 0x2::table::borrow<u8, X6Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x6_matrices, arg3).current_referrer;
            update_x6_referrer(arg0, arg1, v1, arg3);
        } else {
            let v2 = 0x2::table::borrow<u8, X8Matrix>(&0x2::table::borrow<address, UserInfo>(&arg0.users, arg1).x8_matrices, arg3).current_referrer;
            update_x8_referrer(arg0, arg1, v2, arg3);
        };
    }

    fun update_user_references(arg0: UserInfo, arg1: address, arg2: address) : UserInfo {
        let v0 = if (arg0.referrer == arg1) {
            arg2
        } else {
            arg0.referrer
        };
        arg0.referrer = v0;
        arg0.referrals = replace_address_in_vector(arg0.referrals, arg1, arg2);
        let v1 = 1;
        while (v1 <= 16) {
            if (0x2::table::contains<u8, X3Matrix>(&arg0.x3_matrices, v1)) {
                0x2::table::add<u8, X3Matrix>(&mut arg0.x3_matrices, v1, replace_in_x3_matrix(0x2::table::remove<u8, X3Matrix>(&mut arg0.x3_matrices, v1), arg1, arg2));
            };
            if (0x2::table::contains<u8, X6Matrix>(&arg0.x6_matrices, v1)) {
                0x2::table::add<u8, X6Matrix>(&mut arg0.x6_matrices, v1, replace_in_x6_matrix(0x2::table::remove<u8, X6Matrix>(&mut arg0.x6_matrices, v1), arg1, arg2));
            };
            if (0x2::table::contains<u8, X8Matrix>(&arg0.x8_matrices, v1)) {
                0x2::table::add<u8, X8Matrix>(&mut arg0.x8_matrices, v1, replace_in_x8_matrix(0x2::table::remove<u8, X8Matrix>(&mut arg0.x8_matrices, v1), arg1, arg2));
            };
            v1 = v1 + 1;
        };
        arg0
    }

    fun update_x3_referrer(arg0: &mut Registry, arg1: address, arg2: address, arg3: u8) {
        let v0 = arg0.owner;
        let v1 = 0;
        while (v1 < 100) {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg2);
            assert!(0x2::table::contains<u8, bool>(&v2.active_x3_levels, arg3) && *0x2::table::borrow<u8, bool>(&v2.active_x3_levels, arg3), 500);
            let v3 = 0x2::table::borrow_mut<u8, X3Matrix>(&mut v2.x3_matrices, arg3);
            0x1::vector::push_back<address>(&mut v3.referrals, arg1);
            let v4 = 0x1::vector::length<address>(&v3.referrals);
            let v5 = NewUserPlaceEvent{
                user     : arg1,
                referrer : arg2,
                matrix   : 1,
                level    : arg3,
                place    : (v4 as u8),
            };
            0x2::event::emit<NewUserPlaceEvent>(v5);
            let v6 = if (v4 < 3) {
                false
            } else {
                v3.referrals = 0x1::vector::empty<address>();
                if (arg3 != 16) {
                    if (0x2::table::contains<u8, bool>(&v2.active_x3_levels, arg3 + 1)) {
                        if (!*0x2::table::borrow<u8, bool>(&v2.active_x3_levels, arg3 + 1)) {
                            v3.blocked = true;
                        };
                    } else {
                        v3.blocked = true;
                    };
                };
                true
            };
            if (!v6) {
                return
            };
            if (arg2 != v0) {
                let v7 = find_free_x3_referrer(arg0, arg2, arg3);
                let v8 = 0x2::table::borrow_mut<u8, X3Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg2).x3_matrices, arg3);
                v8.current_referrer = v7;
                v8.reinvest_count = v8.reinvest_count + 1;
                let v9 = ReinvestEvent{
                    user             : arg2,
                    current_referrer : v7,
                    caller           : arg1,
                    matrix           : 1,
                    level            : arg3,
                };
                0x2::event::emit<ReinvestEvent>(v9);
                arg2 = v7;
                v1 = v1 + 1;
                continue
            };
            let v10 = 0x2::table::borrow_mut<u8, X3Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0).x3_matrices, arg3);
            v10.reinvest_count = v10.reinvest_count + 1;
            let v11 = ReinvestEvent{
                user             : v0,
                current_referrer : @0x0,
                caller           : arg1,
                matrix           : 1,
                level            : arg3,
            };
            0x2::event::emit<ReinvestEvent>(v11);
            return
        };
    }

    fun update_x6_referrer(arg0: &mut Registry, arg1: address, arg2: address, arg3: u8) {
        let v0 = arg0.owner;
        let v1 = arg2;
        let v2 = 0;
        while (v2 < 100) {
            let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1);
            assert!(0x2::table::contains<u8, bool>(&v3.active_x6_levels, arg3) && *0x2::table::borrow<u8, bool>(&v3.active_x6_levels, arg3), 500);
            let v4 = 0x2::table::borrow_mut<u8, X6Matrix>(&mut v3.x6_matrices, arg3);
            let v5 = 0x1::vector::length<address>(&v4.first_level_referrals) + 0x1::vector::length<address>(&v4.second_level_referrals) + 1;
            let v6 = if (v5 <= 2) {
                0x1::vector::push_back<address>(&mut v4.first_level_referrals, arg1);
                let v7 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 2,
                    level    : arg3,
                    place    : (v5 as u8),
                };
                0x2::event::emit<NewUserPlaceEvent>(v7);
                false
            } else if (v5 <= 5) {
                0x1::vector::push_back<address>(&mut v4.second_level_referrals, arg1);
                let v8 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 2,
                    level    : arg3,
                    place    : (v5 as u8),
                };
                0x2::event::emit<NewUserPlaceEvent>(v8);
                false
            } else if (v5 == 6) {
                0x1::vector::push_back<address>(&mut v4.second_level_referrals, arg1);
                let v9 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 2,
                    level    : arg3,
                    place    : 6,
                };
                0x2::event::emit<NewUserPlaceEvent>(v9);
                v4.first_level_referrals = 0x1::vector::empty<address>();
                v4.second_level_referrals = 0x1::vector::empty<address>();
                v4.closed_part = @0x0;
                if (arg3 != 16) {
                    if (0x2::table::contains<u8, bool>(&v3.active_x6_levels, arg3 + 1)) {
                        if (!*0x2::table::borrow<u8, bool>(&v3.active_x6_levels, arg3 + 1)) {
                            v4.blocked = true;
                        };
                    } else {
                        v4.blocked = true;
                    };
                };
                true
            } else {
                v4.first_level_referrals = 0x1::vector::empty<address>();
                v4.second_level_referrals = 0x1::vector::empty<address>();
                v4.closed_part = @0x0;
                v4.reinvest_count = v4.reinvest_count + 1;
                0x1::vector::push_back<address>(&mut v4.first_level_referrals, arg1);
                let v10 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 2,
                    level    : arg3,
                    place    : 1,
                };
                0x2::event::emit<NewUserPlaceEvent>(v10);
                false
            };
            if (!v6) {
                return
            };
            if (v1 != v0) {
                let v11 = find_free_x6_referrer(arg0, v1, arg3);
                let v12 = 0x2::table::borrow_mut<u8, X6Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg2).x6_matrices, arg3);
                v12.current_referrer = v11;
                v12.reinvest_count = v12.reinvest_count + 1;
                let v13 = ReinvestEvent{
                    user             : arg2,
                    current_referrer : v11,
                    caller           : arg1,
                    matrix           : 2,
                    level            : arg3,
                };
                0x2::event::emit<ReinvestEvent>(v13);
                v1 = v11;
                v2 = v2 + 1;
                continue
            };
            let v14 = 0x2::table::borrow_mut<u8, X6Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0).x6_matrices, arg3);
            v14.reinvest_count = v14.reinvest_count + 1;
            let v15 = ReinvestEvent{
                user             : v0,
                current_referrer : @0x0,
                caller           : arg1,
                matrix           : 2,
                level            : arg3,
            };
            0x2::event::emit<ReinvestEvent>(v15);
            return
        };
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<u8, X6Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1).x6_matrices, arg3).first_level_referrals, arg1);
    }

    fun update_x8_referrer(arg0: &mut Registry, arg1: address, arg2: address, arg3: u8) {
        let v0 = arg0.owner;
        let v1 = arg2;
        let v2 = 0;
        while (v2 < 100) {
            let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1);
            assert!(0x2::table::contains<u8, bool>(&v3.active_x8_levels, arg3) && *0x2::table::borrow<u8, bool>(&v3.active_x8_levels, arg3), 500);
            let v4 = 0x2::table::borrow_mut<u8, X8Matrix>(&mut v3.x8_matrices, arg3);
            let v5 = 0x1::vector::length<address>(&v4.first_level_referrals) + 0x1::vector::length<address>(&v4.second_level_referrals) + 0x1::vector::length<address>(&v4.third_level_referrals) + 1;
            let v6 = if (v5 <= 2) {
                0x1::vector::push_back<address>(&mut v4.first_level_referrals, arg1);
                let v7 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 3,
                    level    : arg3,
                    place    : (v5 as u8),
                };
                0x2::event::emit<NewUserPlaceEvent>(v7);
                false
            } else if (v5 <= 6) {
                0x1::vector::push_back<address>(&mut v4.second_level_referrals, arg1);
                let v8 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 3,
                    level    : arg3,
                    place    : (v5 as u8),
                };
                0x2::event::emit<NewUserPlaceEvent>(v8);
                false
            } else if (v5 <= 13) {
                0x1::vector::push_back<address>(&mut v4.third_level_referrals, arg1);
                let v9 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 3,
                    level    : arg3,
                    place    : (v5 as u8),
                };
                0x2::event::emit<NewUserPlaceEvent>(v9);
                false
            } else if (v5 == 14) {
                0x1::vector::push_back<address>(&mut v4.third_level_referrals, arg1);
                let v10 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 3,
                    level    : arg3,
                    place    : 14,
                };
                0x2::event::emit<NewUserPlaceEvent>(v10);
                v4.first_level_referrals = 0x1::vector::empty<address>();
                v4.second_level_referrals = 0x1::vector::empty<address>();
                v4.third_level_referrals = 0x1::vector::empty<address>();
                v4.closed_part = @0x0;
                v4.current_referrer_index = 0;
                if (arg3 != 16) {
                    if (0x2::table::contains<u8, bool>(&v3.active_x8_levels, arg3 + 1)) {
                        if (!*0x2::table::borrow<u8, bool>(&v3.active_x8_levels, arg3 + 1)) {
                            v4.blocked = true;
                        };
                    } else {
                        v4.blocked = true;
                    };
                };
                true
            } else {
                v4.first_level_referrals = 0x1::vector::empty<address>();
                v4.second_level_referrals = 0x1::vector::empty<address>();
                v4.third_level_referrals = 0x1::vector::empty<address>();
                v4.closed_part = @0x0;
                v4.current_referrer_index = 0;
                v4.reinvest_count = v4.reinvest_count + 1;
                0x1::vector::push_back<address>(&mut v4.first_level_referrals, arg1);
                let v11 = NewUserPlaceEvent{
                    user     : arg1,
                    referrer : v1,
                    matrix   : 3,
                    level    : arg3,
                    place    : 1,
                };
                0x2::event::emit<NewUserPlaceEvent>(v11);
                false
            };
            if (!v6) {
                return
            };
            if (v1 != v0) {
                let v12 = find_free_x8_referrer(arg0, v1, arg3);
                let v13 = 0x2::table::borrow_mut<u8, X8Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, arg2).x8_matrices, arg3);
                v13.current_referrer = v12;
                v13.reinvest_count = v13.reinvest_count + 1;
                let v14 = ReinvestEvent{
                    user             : arg2,
                    current_referrer : v12,
                    caller           : arg1,
                    matrix           : 3,
                    level            : arg3,
                };
                0x2::event::emit<ReinvestEvent>(v14);
                v1 = v12;
                v2 = v2 + 1;
                continue
            };
            let v15 = 0x2::table::borrow_mut<u8, X8Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0).x8_matrices, arg3);
            v15.reinvest_count = v15.reinvest_count + 1;
            let v16 = ReinvestEvent{
                user             : v0,
                current_referrer : @0x0,
                caller           : arg1,
                matrix           : 3,
                level            : arg3,
            };
            0x2::event::emit<ReinvestEvent>(v16);
            return
        };
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<u8, X8Matrix>(&mut 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1).x8_matrices, arg3).first_level_referrals, arg1);
    }

    public entry fun upgrade(arg0: &mut Registry, arg1: &mut 0x9aee3fbb548ce226c9ef1a72bcd63c5d16e64b71d240285ef9e642b6692e6986::ssui::TokenRegistry, arg2: u8, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.paused, 21);
        assert!(is_user_exists(arg0, v0), 3);
        assert!(arg3 > 1 && arg3 <= 16, 6);
        assert!(arg2 >= 1 && arg2 <= 3, 12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == *0x2::table::borrow<u8, u64>(&arg0.level_prices, arg3), 7);
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0);
        if (arg2 == 1) {
            assert!(*0x2::table::borrow<u8, bool>(&v1.active_x3_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v1.active_x3_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v1.active_x3_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v1.active_x3_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v1.active_x3_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X3Matrix>(&v1.x3_matrices, arg3)) {
                let v2 = X3Matrix{
                    current_referrer : @0x0,
                    referrals        : 0x1::vector::empty<address>(),
                    blocked          : false,
                    reinvest_count   : 0,
                };
                0x2::table::add<u8, X3Matrix>(&mut v1.x3_matrices, arg3, v2);
            };
        } else if (arg2 == 2) {
            assert!(*0x2::table::borrow<u8, bool>(&v1.active_x6_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v1.active_x6_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v1.active_x6_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v1.active_x6_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v1.active_x6_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X6Matrix>(&v1.x6_matrices, arg3)) {
                let v3 = X6Matrix{
                    current_referrer       : @0x0,
                    first_level_referrals  : 0x1::vector::empty<address>(),
                    second_level_referrals : 0x1::vector::empty<address>(),
                    blocked                : false,
                    reinvest_count         : 0,
                    closed_part            : @0x0,
                };
                0x2::table::add<u8, X6Matrix>(&mut v1.x6_matrices, arg3, v3);
            };
        } else if (arg2 == 3) {
            assert!(*0x2::table::borrow<u8, bool>(&v1.active_x8_levels, arg3 - 1), 8);
            if (0x2::table::contains<u8, bool>(&v1.active_x8_levels, arg3)) {
                assert!(!*0x2::table::borrow<u8, bool>(&v1.active_x8_levels, arg3), 9);
                *0x2::table::borrow_mut<u8, bool>(&mut v1.active_x8_levels, arg3) = true;
            } else {
                0x2::table::add<u8, bool>(&mut v1.active_x8_levels, arg3, true);
            };
            if (!0x2::table::contains<u8, X8Matrix>(&v1.x8_matrices, arg3)) {
                let v4 = X8Matrix{
                    current_referrer       : @0x0,
                    current_referrer_index : 0,
                    first_level_referrals  : 0x1::vector::empty<address>(),
                    second_level_referrals : 0x1::vector::empty<address>(),
                    third_level_referrals  : 0x1::vector::empty<address>(),
                    blocked                : false,
                    reinvest_count         : 0,
                    closed_part            : @0x0,
                };
                0x2::table::add<u8, X8Matrix>(&mut v1.x8_matrices, arg3, v4);
            };
        };
        initialize_single_matrix(arg0, v0, arg2, arg3);
        distribute_upgrade_fee(arg1, arg0, v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg2, arg3, arg5);
        update_initialized_single_matrix(arg0, v0, arg2, arg3);
        let v5 = UpgradeEvent{
            user     : v0,
            referrer : v0,
            matrix   : arg2,
            level    : arg3,
        };
        0x2::event::emit<UpgradeEvent>(v5);
    }

    public fun was_weekly_leader_rewards_distributed(arg0: &Registry, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.last_leader_distribution_ts;
        if (v1 == 0) {
            return false
        };
        let v2 = v0 / 604800000 * 604800000 + 151200000;
        let v3 = if (v2 <= v0) {
            v2
        } else {
            v2 - 604800000
        };
        v1 >= v3
    }

    public entry fun withdraw_mining_earnings(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.paused, 21);
        assert!(is_user_exists(arg0, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 - v1.last_withdrawal >= 86400000, 10);
        let v3 = calculate_roi_internal(v1, v2);
        assert!(v3 > 0, 11);
        assert!(v3 >= 1000000000, 27);
        v1.last_withdrawal = v2;
        v1.total_withdrawn = v1.total_withdrawn + v3;
        let v4 = v3 * 95 / 100;
        distribute_marketing_fee_from_mining_treasury(arg0, v3 * 5 / 100, arg2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.mining_treasury) >= v4, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.mining_treasury, v4, arg2), v0);
        let v5 = MiningWithdrawalEvent{
            user   : v0,
            amount : v3,
        };
        0x2::event::emit<MiningWithdrawalEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

