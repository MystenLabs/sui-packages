module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::jitter_position {
    struct PyLeg has drop, store {
        pt_balance: u64,
        yt_balance: u64,
        yt_reward_guard: u64,
        index: u128,
        py_index: u128,
        accrued: u128,
    }

    struct LpLeg has drop, store {
        pool_id: 0x2::object::ID,
        lp_amount: u64,
        lp_reward_guard: u64,
    }

    struct JitterPosition has key {
        id: 0x2::object::UID,
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expiry: u64,
        created_at: u64,
        py: PyLeg,
        lp: LpLeg,
    }

    struct PositionCreatedEvent has copy, drop {
        position_id: 0x2::object::ID,
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        expiry: u64,
        owner: address,
    }

    struct BurnPtEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
    }

    struct BurnYtEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
    }

    struct RedeemPtEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
    }

    struct RedeemYtEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
    }

    struct LpRewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LpRewardMutation {
        position_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    public fun destroy_empty(arg0: JitterPosition, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig) {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg1);
        assert!(arg0.py.accrued == 0, 506);
        assert!(is_py_empty(&arg0), 500);
        assert!(is_lp_empty(&arg0), 1900);
        destroy(arg0);
    }

    public fun id(arg0: &JitterPosition) : 0x2::object::ID {
        0x2::object::id<JitterPosition>(arg0)
    }

    public fun accrued(arg0: &JitterPosition) : u128 {
        arg0.py.accrued
    }

    public(friend) fun add_lp(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.lp.lp_amount = arg0.lp.lp_amount + arg1;
        arg0.lp.lp_reward_guard = arg0.lp.lp_reward_guard + 1;
    }

    public(friend) fun add_pt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.py.pt_balance = arg0.py.pt_balance + arg1;
    }

    public(friend) fun add_yt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        arg0.py.yt_balance = arg0.py.yt_balance + arg1;
        arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
    }

    fun assert_market_match<T0: drop, T1: drop, T2: drop>(arg0: &JitterPosition, arg1: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>) {
        assert!(arg0.market_id == 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::id<T0, T1, T2>(arg1), 1303);
    }

    public fun assert_pool_match(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(arg0.lp.pool_id == arg1, 1901);
    }

    public(friend) fun assert_reward_mutation_allowed(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(reward_gate_open(arg0), 1903);
        let v0 = LpRewardGateKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<LpRewardGateKey, 0x2::object::ID>(uid(arg0), v0) == arg1, 1905);
    }

    public fun assert_state_match(arg0: &JitterPosition, arg1: 0x2::object::ID) {
        assert!(arg0.py_state_id == arg1, 502);
    }

    public(friend) fun begin_reward_mutation(arg0: &mut JitterPosition, arg1: 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::RewardSettlement, arg2: 0x2::object::ID, arg3: address) : LpRewardMutation {
        assert!(!reward_gate_open(arg0), 1904);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_scope(&arg1, 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::lp_scope());
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_profile_matches(&arg1, pool_id(arg0));
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_subject(&arg1, 0x2::object::id<JitterPosition>(arg0));
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_owner(&arg1, arg3);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_previous_exposure(&arg1, lp_amount(arg0));
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::assert_settlement_guard(&arg1, lp_reward_guard(arg0));
        let v0 = 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::reward_distributor::consume_lp_settlement(arg1, arg2, 0x2::object::id<JitterPosition>(arg0), arg3);
        let v1 = uid_mut(arg0);
        let v2 = LpRewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<LpRewardGateKey, 0x2::object::ID>(v1, v2, v0);
        LpRewardMutation{
            position_id    : 0x2::object::id<JitterPosition>(arg0),
            distributor_id : v0,
        }
    }

    public(friend) fun bind_pool_if_empty(arg0: &mut JitterPosition, arg1: 0x2::object::ID) {
        if (arg0.lp.pool_id == none_id()) {
            assert!(arg0.lp.lp_amount == 0, 1901);
            arg0.lp.pool_id = arg1;
        };
    }

    public fun burn_pt_in<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T1>, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg4: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>) {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert_state_match(arg1, arg2);
        assert_market_match<T0, T1, T2>(arg1, arg4);
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 503);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::burn_pt<T0, T1, T2>(arg4, arg0);
        add_pt(arg1, v0);
        let v1 = BurnPtEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            amount      : v0,
        };
        0x2::event::emit<BurnPtEvent>(v1);
    }

    public(friend) fun burn_yt_in<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>) {
        assert_state_match(arg1, arg2);
        assert_market_match<T0, T1, T2>(arg1, arg3);
        let v0 = 0x2::coin::value<T2>(&arg0);
        assert!(v0 > 0, 503);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::burn_yt<T0, T1, T2>(arg3, arg0);
        add_yt(arg1, v0);
        let v1 = BurnYtEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            amount      : v0,
        };
        0x2::event::emit<BurnYtEvent>(v1);
    }

    public(friend) fun clear_accrued(arg0: &mut JitterPosition) {
        arg0.py.accrued = 0;
    }

    public fun created_at(arg0: &JitterPosition) : u64 {
        arg0.created_at
    }

    fun destroy(arg0: JitterPosition) {
        let JitterPosition {
            id          : v0,
            py_state_id : _,
            market_id   : _,
            expiry      : _,
            created_at  : _,
            py          : _,
            lp          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun end_reward_mutation(arg0: &mut JitterPosition, arg1: LpRewardMutation) {
        let LpRewardMutation {
            position_id    : v0,
            distributor_id : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<JitterPosition>(arg0), 1901);
        assert!(reward_gate_open(arg0), 1903);
        let v2 = LpRewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<LpRewardGateKey, 0x2::object::ID>(uid_mut(arg0), v2) == v1, 1905);
    }

    public fun expiry(arg0: &JitterPosition) : u64 {
        arg0.expiry
    }

    public fun index(arg0: &JitterPosition) : u128 {
        arg0.py.index
    }

    public fun is_lp_empty(arg0: &JitterPosition) : bool {
        arg0.lp.lp_amount == 0
    }

    public fun is_py_empty(arg0: &JitterPosition) : bool {
        if (arg0.py.pt_balance == 0) {
            if (arg0.py.yt_balance == 0) {
                arg0.py.accrued == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun lp_amount(arg0: &JitterPosition) : u64 {
        arg0.lp.lp_amount
    }

    public fun lp_reward_guard(arg0: &JitterPosition) : u64 {
        arg0.lp.lp_reward_guard
    }

    public fun market_id(arg0: &JitterPosition) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : JitterPosition {
        let v0 = PyLeg{
            pt_balance      : 0,
            yt_balance      : 0,
            yt_reward_guard : 0,
            index           : 0,
            py_index        : 0,
            accrued         : 0,
        };
        let v1 = LpLeg{
            pool_id         : arg2,
            lp_amount       : 0,
            lp_reward_guard : 0,
        };
        let v2 = JitterPosition{
            id          : 0x2::object::new(arg5),
            py_state_id : arg0,
            market_id   : arg1,
            expiry      : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg4),
            py          : v0,
            lp          : v1,
        };
        let v3 = PositionCreatedEvent{
            position_id : 0x2::object::id<JitterPosition>(&v2),
            py_state_id : arg0,
            market_id   : arg1,
            pool_id     : arg2,
            expiry      : arg3,
            owner       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PositionCreatedEvent>(v3);
        v2
    }

    public(friend) fun mint_lp(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : JitterPosition {
        mint(arg1, arg2, arg0, arg3, arg4, arg5)
    }

    public(friend) fun mint_py(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : JitterPosition {
        mint(arg0, arg1, none_id(), arg2, arg3, arg4)
    }

    public fun none_id() : 0x2::object::ID {
        0x2::object::id_from_address(@0x0)
    }

    public fun pool_id(arg0: &JitterPosition) : 0x2::object::ID {
        arg0.lp.pool_id
    }

    public fun pt_balance(arg0: &JitterPosition) : u64 {
        arg0.py.pt_balance
    }

    public fun py_index(arg0: &JitterPosition) : u128 {
        arg0.py.py_index
    }

    public fun py_state_id(arg0: &JitterPosition) : 0x2::object::ID {
        arg0.py_state_id
    }

    public fun redeem_pt_out<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: &0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::GlobalConfig, arg4: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::global_config::assert_current(arg3);
        assert!(arg1.expiry > 0x2::clock::timestamp_ms(arg5), 1300);
        assert_state_match(arg1, arg2);
        assert_market_match<T0, T1, T2>(arg1, arg4);
        assert!(arg0 > 0, 503);
        sub_pt(arg1, arg0);
        let v0 = RedeemPtEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            amount      : arg0,
        };
        0x2::event::emit<RedeemPtEvent>(v0);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::mint_pt<T0, T1, T2>(arg4, arg0, arg6)
    }

    public(friend) fun redeem_yt_out<T0: drop, T1: drop, T2: drop>(arg0: u64, arg1: &mut JitterPosition, arg2: 0x2::object::ID, arg3: &mut 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::Market<T0, T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg1.expiry > 0x2::clock::timestamp_ms(arg4), 1300);
        assert_state_match(arg1, arg2);
        assert_market_match<T0, T1, T2>(arg1, arg3);
        assert!(arg0 > 0, 503);
        sub_yt(arg1, arg0);
        let v0 = RedeemYtEvent{
            position_id : 0x2::object::id<JitterPosition>(arg1),
            amount      : arg0,
        };
        0x2::event::emit<RedeemYtEvent>(v0);
        0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::market::mint_yt<T0, T1, T2>(arg3, arg0, arg5)
    }

    public fun reward_gate_open(arg0: &JitterPosition) : bool {
        let v0 = LpRewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists<LpRewardGateKey>(uid(arg0), v0)
    }

    public(friend) fun set_accrued(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.accrued = arg1;
    }

    public(friend) fun set_index(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.index = arg1;
    }

    public(friend) fun set_py_index(arg0: &mut JitterPosition, arg1: u128) {
        arg0.py.py_index = arg1;
    }

    public(friend) fun set_yt_balance(arg0: &mut JitterPosition, arg1: u64) {
        if (arg0.py.yt_balance != arg1) {
            arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
        };
        arg0.py.yt_balance = arg1;
    }

    public(friend) fun sub_lp(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.lp.lp_amount >= arg1, 1900);
        arg0.lp.lp_amount = arg0.lp.lp_amount - arg1;
        arg0.lp.lp_reward_guard = arg0.lp.lp_reward_guard + 1;
    }

    public(friend) fun sub_pt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.py.pt_balance >= arg1, 500);
        arg0.py.pt_balance = arg0.py.pt_balance - arg1;
    }

    public(friend) fun sub_yt(arg0: &mut JitterPosition, arg1: u64) {
        assert!(arg1 > 0, 503);
        assert!(arg0.py.yt_balance >= arg1, 501);
        arg0.py.yt_balance = arg0.py.yt_balance - arg1;
        arg0.py.yt_reward_guard = arg0.py.yt_reward_guard + 1;
    }

    public(friend) fun transfer_position(arg0: JitterPosition, arg1: address) {
        0x2::transfer::transfer<JitterPosition>(arg0, arg1);
    }

    public(friend) fun uid(arg0: &JitterPosition) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut JitterPosition) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun yt_balance(arg0: &JitterPosition) : u64 {
        arg0.py.yt_balance
    }

    public fun yt_reward_guard(arg0: &JitterPosition) : u64 {
        arg0.py.yt_reward_guard
    }

    // decompiled from Move bytecode v7
}

