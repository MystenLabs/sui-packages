module 0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_sell {
    struct Commit has key {
        id: 0x2::object::UID,
        tier: u8,
        quantity: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        refunded_quantity: u64,
        purchased_quantity: u64,
    }

    struct Sell has key {
        id: 0x2::object::UID,
        version: u64,
        operator: address,
        is_paused: bool,
        state: State,
        phase: Phase,
        refer_data: ReferData,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        commit_state: CommitState,
        user_commit_states: 0x2::table::Table<address, CommitState>,
        private_sell_states: 0x2::table::Table<address, PrivateSellState>,
        allocations: 0x2::vec_map::VecMap<u8, 0x2::table::Table<address, u64>>,
        commit_limits: CommitLimits,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        phase1_minted: u64,
        phase2_minted: u64,
        phase3_minted: u64,
        admin_minted: u64,
        public_minted: u64,
        total_minted: u64,
        total_burned: u64,
        total_cap: u64,
    }

    struct Phase has store, key {
        id: 0x2::object::UID,
        phase: u8,
    }

    struct ReferData has store {
        refer_code: 0x2::table::Table<address, vector<u8>>,
        refer_code_to_address: 0x2::table::Table<vector<u8>, address>,
        referrer: 0x2::table::Table<address, address>,
    }

    struct CommitState has store {
        total_commits: u64,
        phase1_commits: u64,
        phase2_commits: u64,
        phase3_commits: u64,
    }

    struct PrivateSellState has store {
        total: u64,
        phase1: u64,
        phase2: u64,
        phase3: u64,
    }

    struct CommitLimits has store {
        phase1_limit: u64,
        phase2_limit: u64,
        phase3_limit: u64,
    }

    public fun burn(arg0: &mut Sell, arg1: 0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_pack::DeedPack, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_pack::burn(arg1, arg2, arg3);
        arg0.state.total_burned = arg0.state.total_burned + 1;
    }

    public entry fun admin_mint(arg0: &mut Sell, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.operator, 25);
        assert!(arg2 > 0, 5);
        let v1 = 0;
        while (v1 < arg2) {
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_pack::mint(arg1, 6, arg3, arg4);
            v1 = v1 + 1;
        };
        update_minted_states(arg0, 0, 0, 0, arg2, 0);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_admin_mint(v0, arg1, arg2, arg3);
    }

    fun assert_not_paused(arg0: &Sell) {
        assert!(!arg0.is_paused, 24);
    }

    fun assert_phase_active(arg0: &Sell, arg1: u8) {
        let v0 = if (arg0.phase.phase == 1) {
            true
        } else if (arg0.phase.phase == 2) {
            true
        } else {
            arg0.phase.phase == 3
        };
        assert!(v0, 3);
        assert!(arg0.phase.phase == arg1, 3);
    }

    fun assert_version(arg0: &Sell) {
        assert!(arg0.version <= 2, 22);
    }

    fun calculate_commit_amount() : u64 {
        359000000 / 10
    }

    fun calculate_remaining_amount(arg0: u8) : u64 {
        if (arg0 == 1) {
            179000000 - calculate_commit_amount()
        } else if (arg0 == 2) {
            239000000 - calculate_commit_amount()
        } else {
            assert!(arg0 == 3, 4);
            299000000 - calculate_commit_amount()
        }
    }

    public fun commit(arg0: &mut Sell, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert_phase_active(arg0, arg3);
        assert!(arg2 > 0, 5);
        assert!(get_address_commit_count_per_tier(arg0, v0, arg3) + arg2 <= get_commit_limit_for_tier(arg0, arg3), 21);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v1 == calculate_commit_amount() * arg2, 5);
        let v2 = Commit{
            id                 : 0x2::object::new(arg5),
            tier               : arg3,
            quantity           : arg2,
            balance            : 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1),
            refunded_quantity  : 0,
            purchased_quantity : 0,
        };
        0x2::transfer::transfer<Commit>(v2, v0);
        update_address_commits_for_tier(arg0, v0, arg3, arg2);
        update_commits(arg0, arg3, arg2);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_commit_made(v0, arg3, arg2, v1, 0x2::object::uid_to_address(&v2.id), arg4);
    }

    fun discount(arg0: u8, arg1: u64) : u64 {
        tier_price(arg0) * arg1 / 20
    }

    public fun get_address_commit_count(arg0: &Sell, arg1: address) : u64 {
        get_address_commit_count_per_tier(arg0, arg1, 1) + get_address_commit_count_per_tier(arg0, arg1, 2) + get_address_commit_count_per_tier(arg0, arg1, 3)
    }

    public fun get_address_commit_count_per_tier(arg0: &Sell, arg1: address, arg2: u8) : u64 {
        if (!0x2::table::contains<address, CommitState>(&arg0.user_commit_states, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, CommitState>(&arg0.user_commit_states, arg1);
        if (arg2 == 1) {
            v0.phase1_commits
        } else if (arg2 == 2) {
            v0.phase2_commits
        } else if (arg2 == 3) {
            v0.phase3_commits
        } else {
            0
        }
    }

    public fun get_balance(arg0: &Sell) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun get_commit_limit_for_tier(arg0: &Sell, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.commit_limits.phase1_limit
        } else if (arg1 == 2) {
            arg0.commit_limits.phase2_limit
        } else {
            assert!(arg1 == 3, 4);
            arg0.commit_limits.phase3_limit
        }
    }

    public fun get_commit_limits(arg0: &Sell) : (u64, u64, u64) {
        (get_commit_limit_for_tier(arg0, 1), get_commit_limit_for_tier(arg0, 2), get_commit_limit_for_tier(arg0, 3))
    }

    public fun get_commits(arg0: &Sell) : (u64, u64, u64, u64) {
        (arg0.commit_state.total_commits, arg0.commit_state.phase1_commits, arg0.commit_state.phase2_commits, arg0.commit_state.phase3_commits)
    }

    public fun get_current_phase(arg0: &Sell) : u8 {
        arg0.phase.phase
    }

    public fun get_max_commits_per_address() : u64 {
        30
    }

    public fun get_phase_purchased(arg0: &Sell, arg1: address, arg2: u8) : u64 {
        if (!0x2::table::contains<address, PrivateSellState>(&arg0.private_sell_states, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, PrivateSellState>(&arg0.private_sell_states, arg1);
        if (arg2 == 1) {
            v0.phase1
        } else if (arg2 == 2) {
            v0.phase2
        } else if (arg2 == 3) {
            v0.phase3
        } else {
            0
        }
    }

    public fun get_tier_price(arg0: u8) : u64 {
        tier_price(arg0)
    }

    public fun get_total_burned(arg0: &Sell) : u64 {
        arg0.state.total_burned
    }

    public fun get_total_cap(arg0: &Sell) : u64 {
        arg0.state.total_cap
    }

    public fun get_total_minted(arg0: &Sell) : u64 {
        arg0.state.total_minted
    }

    public fun get_user_allocation(arg0: &Sell, arg1: address, arg2: u8) : u64 {
        if (!0x2::table::contains<address, u64>(0x2::vec_map::get<u8, 0x2::table::Table<address, u64>>(&arg0.allocations, &arg2), arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(0x2::vec_map::get<u8, 0x2::table::Table<address, u64>>(&arg0.allocations, &arg2), arg1)
    }

    public fun get_version(arg0: &Sell) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u8, 0x2::table::Table<address, u64>>();
        0x2::vec_map::insert<u8, 0x2::table::Table<address, u64>>(&mut v0, 1, 0x2::table::new<address, u64>(arg0));
        0x2::vec_map::insert<u8, 0x2::table::Table<address, u64>>(&mut v0, 2, 0x2::table::new<address, u64>(arg0));
        0x2::vec_map::insert<u8, 0x2::table::Table<address, u64>>(&mut v0, 3, 0x2::table::new<address, u64>(arg0));
        let v1 = State{
            id            : 0x2::object::new(arg0),
            phase1_minted : 0,
            phase2_minted : 0,
            phase3_minted : 0,
            admin_minted  : 0,
            public_minted : 0,
            total_minted  : 0,
            total_burned  : 0,
            total_cap     : 99999,
        };
        let v2 = Phase{
            id    : 0x2::object::new(arg0),
            phase : 0,
        };
        let v3 = ReferData{
            refer_code            : 0x2::table::new<address, vector<u8>>(arg0),
            refer_code_to_address : 0x2::table::new<vector<u8>, address>(arg0),
            referrer              : 0x2::table::new<address, address>(arg0),
        };
        let v4 = CommitState{
            total_commits  : 0,
            phase1_commits : 0,
            phase2_commits : 0,
            phase3_commits : 0,
        };
        let v5 = CommitLimits{
            phase1_limit : 30,
            phase2_limit : 30,
            phase3_limit : 30,
        };
        let v6 = Sell{
            id                  : 0x2::object::new(arg0),
            version             : 2,
            operator            : 0x2::tx_context::sender(arg0),
            is_paused           : false,
            state               : v1,
            phase               : v2,
            refer_data          : v3,
            balance             : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            commit_state        : v4,
            user_commit_states  : 0x2::table::new<address, CommitState>(arg0),
            private_sell_states : 0x2::table::new<address, PrivateSellState>(arg0),
            allocations         : v0,
            commit_limits       : v5,
        };
        let v7 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Sell>(v6);
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Sell) : bool {
        arg0.is_paused
    }

    fun is_private_sell_active(arg0: &Sell) : bool {
        arg0.phase.phase == 4
    }

    fun is_public_sell_active(arg0: &Sell) : bool {
        arg0.phase.phase == 5
    }

    public fun migrate(arg0: &mut Sell, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.version = arg2;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_migration_event(0x2::tx_context::sender(arg4), arg0.version, arg2, arg3);
    }

    public entry fun private_purchase(arg0: &mut Sell, arg1: &mut Commit, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_private_sell_active(arg0), 16);
        assert!(arg0.state.total_minted + arg3 <= arg0.state.total_cap, 13);
        assert!(arg3 > 0, 5);
        assert!(arg3 <= arg1.quantity - arg1.refunded_quantity - arg1.purchased_quantity, 5);
        let v1 = get_user_allocation(arg0, v0, arg1.tier);
        let v2 = get_phase_purchased(arg0, v0, arg1.tier);
        assert!(!(v2 + arg3 + arg1.refunded_quantity > v1), 6);
        assert!(arg3 <= v1 - v2 - arg1.refunded_quantity, 6);
        let v3 = calculate_remaining_amount(arg1.tier) * arg3;
        let v4 = v3;
        assert!(v3 > 0, 5);
        if (0x2::table::contains<address, address>(&arg0.refer_data.referrer, v0)) {
            let v5 = discount(arg1.tier, arg3);
            v4 = v3 - v5;
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_buyer_discount(v0, v5, arg4);
        };
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v4, 5);
        let v6 = 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, calculate_commit_amount() * arg3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        let v7 = process_inviter_rewards(arg0, v0, arg1.tier, arg3, v6, arg4, arg5);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v7);
        arg1.purchased_quantity = arg1.purchased_quantity + arg3;
        let v8 = 0;
        while (v8 < arg3) {
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_pack::mint(v0, arg1.tier, arg4, arg5);
            v8 = v8 + 1;
        };
        if (arg1.tier == 1) {
            update_minted_states(arg0, arg3, 0, 0, 0, 0);
        } else if (arg1.tier == 2) {
            update_minted_states(arg0, 0, arg3, 0, 0, 0);
        } else if (arg1.tier == 3) {
            update_minted_states(arg0, 0, 0, arg3, 0, 0);
        };
        update_private_sell_state(arg0, v0, arg1.tier, arg3);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_private_purchase(v0, arg1.tier, arg3, v4, 0x2::object::uid_to_address(&arg1.id), arg4);
    }

    public entry fun private_refund(arg0: &mut Sell, arg1: &mut Commit, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 > 0, 17);
        assert!(arg2 <= arg1.quantity - arg1.refunded_quantity - arg1.purchased_quantity, 17);
        let v1 = calculate_commit_amount() * arg2;
        arg1.refunded_quantity = arg1.refunded_quantity + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, v1, arg4), v0);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_private_refund(v0, arg1.tier, arg2, v1, 0x2::object::uid_to_address(&arg1.id), arg3);
    }

    fun process_inviter_rewards(arg0: &Sell, arg1: address, arg2: u8, arg3: u64, arg4: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (0x2::table::contains<address, address>(&arg0.refer_data.referrer, arg1)) {
            let v0 = 0x2::table::borrow<address, address>(&arg0.refer_data.referrer, arg1);
            let v1 = tier_price(arg2) * arg3 / 10;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg4, v1), arg6), *v0);
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_inviter_reward(*v0, arg1, v1, arg2, arg3, arg5);
        };
        arg4
    }

    public entry fun public_purchase(arg0: &mut Sell, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_public_sell_active(arg0), 16);
        assert!(arg0.state.total_minted + arg2 <= arg0.state.total_cap, 13);
        assert!(arg2 > 0, 5);
        let v1 = 359000000 * arg2;
        let v2 = v1;
        assert!(v1 > 0, 5);
        if (0x2::table::contains<address, address>(&arg0.refer_data.referrer, v0)) {
            let v3 = 359000000 * arg2 / 20;
            v2 = v1 - v3;
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_buyer_discount(v0, v3, arg3);
        };
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == v2, 5);
        let v4 = process_inviter_rewards(arg0, v0, 5, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), arg3, arg4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v4);
        let v5 = 0;
        while (v5 < arg2) {
            0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::deed_pack::mint(v0, 5, arg3, arg4);
            v5 = v5 + 1;
        };
        update_minted_states(arg0, 0, 0, 0, 0, arg2);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_public_purchase(v0, arg2, v2, arg3);
    }

    public fun register(arg0: &mut Sell, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 20);
        assert!(0x1::vector::length<u8>(&arg1) <= 30, 20);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.refer_data.refer_code_to_address, arg1), 18);
        0x2::table::add<vector<u8>, address>(&mut arg0.refer_data.refer_code_to_address, arg1, v0);
        0x2::table::add<address, vector<u8>>(&mut arg0.refer_data.refer_code, v0, arg1);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_invite_code_registered(v0, arg1, arg2);
    }

    public fun register_inviter(arg0: &mut Sell, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = resolve_inviter_address(arg0, arg1);
        assert!(v1 != v0, 20);
        assert!(!0x2::table::contains<address, address>(&arg0.refer_data.referrer, v0), 18);
        0x2::table::add<address, address>(&mut arg0.refer_data.referrer, v0, v1);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_inviter_relationship_established(v0, v1, arg1, arg2);
    }

    public fun resolve_inviter_address(arg0: &Sell, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.refer_data.refer_code_to_address, arg1), 19);
        *0x2::table::borrow<vector<u8>, address>(&arg0.refer_data.refer_code_to_address, arg1)
    }

    public fun set_commit_limit_for_tier(arg0: &mut Sell, arg1: &mut AdminCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        if (arg2 == 1) {
            arg0.commit_limits.phase1_limit = arg3;
        } else if (arg2 == 2) {
            arg0.commit_limits.phase2_limit = arg3;
        } else {
            assert!(arg2 == 3, 4);
            arg0.commit_limits.phase3_limit = arg3;
        };
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_commit_limit_updated(0x2::tx_context::sender(arg5), arg2, arg3, arg4);
    }

    public fun set_commit_limits(arg0: &mut Sell, arg1: &mut AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        arg0.commit_limits.phase1_limit = arg2;
        arg0.commit_limits.phase2_limit = arg3;
        arg0.commit_limits.phase3_limit = arg4;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_commit_limits_updated(0x2::tx_context::sender(arg6), arg2, arg3, arg4, arg5);
    }

    public fun set_operator(arg0: &mut Sell, arg1: &mut AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        arg0.operator = arg2;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_operator_updated(0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun set_paused(arg0: &mut Sell, arg1: &mut AdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        arg0.is_paused = arg2;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_is_paused_updated(0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun set_phase(arg0: &mut Sell, arg1: &mut AdminCap, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        assert!(arg2 >= 0 && arg2 <= 5, 3);
        arg0.phase.phase = arg2;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_phase_updated(0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun set_total_cap(arg0: &mut Sell, arg1: &mut AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        arg0.state.total_cap = arg2;
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_total_cap_updated(0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun set_user_allocation(arg0: &mut Sell, arg1: address, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_not_paused(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 25);
        assert!(0x1::vector::length<u64>(&arg2) == 3, 26);
        let v0 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg2, 1);
        let v2 = *0x1::vector::borrow<u64>(&arg2, 2);
        assert!(get_address_commit_count_per_tier(arg0, arg1, 1) >= v0, 21);
        assert!(get_address_commit_count_per_tier(arg0, arg1, 2) >= v1, 21);
        assert!(get_address_commit_count_per_tier(arg0, arg1, 3) >= v2, 21);
        let v3 = 1;
        if (0x2::table::contains<address, u64>(0x2::vec_map::get<u8, 0x2::table::Table<address, u64>>(&arg0.allocations, &v3), arg1)) {
            let v4 = 1;
            0x2::table::remove<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v4), arg1);
        };
        let v5 = 2;
        if (0x2::table::contains<address, u64>(0x2::vec_map::get<u8, 0x2::table::Table<address, u64>>(&arg0.allocations, &v5), arg1)) {
            let v6 = 2;
            0x2::table::remove<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v6), arg1);
        };
        let v7 = 3;
        if (0x2::table::contains<address, u64>(0x2::vec_map::get<u8, 0x2::table::Table<address, u64>>(&arg0.allocations, &v7), arg1)) {
            let v8 = 3;
            0x2::table::remove<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v8), arg1);
        };
        let v9 = 1;
        0x2::table::add<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v9), arg1, v0);
        let v10 = 2;
        0x2::table::add<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v10), arg1, v1);
        let v11 = 3;
        0x2::table::add<address, u64>(0x2::vec_map::get_mut<u8, 0x2::table::Table<address, u64>>(&mut arg0.allocations, &v11), arg1, v2);
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_commit_allocation_set(arg1, 0x2::tx_context::sender(arg4), v0, v1, v2, arg3);
    }

    fun tier_price(arg0: u8) : u64 {
        if (arg0 == 1) {
            179000000
        } else if (arg0 == 2) {
            239000000
        } else if (arg0 == 3) {
            299000000
        } else {
            assert!(arg0 == 5, 4);
            359000000
        }
    }

    fun update_address_commits_for_tier(arg0: &mut Sell, arg1: address, arg2: u8, arg3: u64) {
        if (!0x2::table::contains<address, CommitState>(&arg0.user_commit_states, arg1)) {
            let v0 = CommitState{
                total_commits  : 0,
                phase1_commits : 0,
                phase2_commits : 0,
                phase3_commits : 0,
            };
            0x2::table::add<address, CommitState>(&mut arg0.user_commit_states, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, CommitState>(&mut arg0.user_commit_states, arg1);
        v1.total_commits = v1.total_commits + arg3;
        if (arg2 == 1) {
            v1.phase1_commits = v1.phase1_commits + arg3;
        } else if (arg2 == 2) {
            v1.phase2_commits = v1.phase2_commits + arg3;
        } else {
            assert!(arg2 == 3, 4);
            v1.phase3_commits = v1.phase3_commits + arg3;
        };
    }

    fun update_commits(arg0: &mut Sell, arg1: u8, arg2: u64) {
        arg0.commit_state.total_commits = arg0.commit_state.total_commits + arg2;
        if (arg1 == 1) {
            arg0.commit_state.phase1_commits = arg0.commit_state.phase1_commits + arg2;
        } else if (arg1 == 2) {
            arg0.commit_state.phase2_commits = arg0.commit_state.phase2_commits + arg2;
        } else {
            assert!(arg1 == 3, 4);
            arg0.commit_state.phase3_commits = arg0.commit_state.phase3_commits + arg2;
        };
    }

    fun update_minted_states(arg0: &mut Sell, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.state.phase1_minted = arg0.state.phase1_minted + arg1;
        arg0.state.phase2_minted = arg0.state.phase2_minted + arg2;
        arg0.state.phase3_minted = arg0.state.phase3_minted + arg3;
        arg0.state.admin_minted = arg0.state.admin_minted + arg4;
        arg0.state.public_minted = arg0.state.public_minted + arg5;
        arg0.state.total_minted = arg0.state.total_minted + arg1 + arg2 + arg3 + arg4 + arg5;
    }

    fun update_private_sell_state(arg0: &mut Sell, arg1: address, arg2: u8, arg3: u64) {
        if (!0x2::table::contains<address, PrivateSellState>(&arg0.private_sell_states, arg1)) {
            let v0 = PrivateSellState{
                total  : 0,
                phase1 : 0,
                phase2 : 0,
                phase3 : 0,
            };
            0x2::table::add<address, PrivateSellState>(&mut arg0.private_sell_states, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, PrivateSellState>(&mut arg0.private_sell_states, arg1);
        v1.total = v1.total + arg3;
        if (arg2 == 1) {
            v1.phase1 = v1.phase1 + arg3;
        } else if (arg2 == 2) {
            v1.phase2 = v1.phase2 + arg3;
        } else {
            assert!(arg2 == 3, 4);
            v1.phase3 = v1.phase3 + arg3;
        };
    }

    public fun withdraw_revenue(arg0: &mut Sell, arg1: &mut AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance);
        assert!(v0 > 0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v0, arg3), 0x2::tx_context::sender(arg3));
        0x5a6016832b2754a5961cb1788f0db9d722a85f17f356e51bc04efdb026f9bfbe::secure_events::emit_revenue_withdrawal(0x2::tx_context::sender(arg3), v0, arg2);
    }

    // decompiled from Move bytecode v6
}

