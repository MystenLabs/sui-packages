module 0x1606551bc1f5c6a320f4f5b7c81179c6d00bda91381de4f09fafa65f0f233769::strategy_manager {
    struct AllocatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct HarvesterCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerAccess has store {
        id: 0x2::object::UID,
    }

    struct StrategyState has store {
        supplied: u64,
    }

    struct StrategyManager has key {
        id: 0x2::object::UID,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, StrategyState>,
        total_buffer: u64,
        yield_accrued: u64,
        version: u64,
        admin_id: 0x2::object::ID,
    }

    struct BufferKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DepositRequest<phantom T0> {
        collateral: 0x2::coin::Coin<T0>,
    }

    struct WithdrawalRequest<phantom T0> {
        amount: u64,
    }

    struct StrategyRemovalTicket {
        access: ManagerAccess,
    }

    public(friend) fun add_strategy(arg0: &AllocatorCap, arg1: &mut StrategyManager, arg2: &mut 0x2::tx_context::TxContext) : ManagerAccess {
        assert_current_version(arg1);
        let v0 = ManagerAccess{id: 0x2::object::new(arg2)};
        let v1 = StrategyState{supplied: 0};
        0x2::vec_map::insert<0x2::object::ID, StrategyState>(&mut arg1.strategies, 0x2::object::uid_to_inner(&v0.id), v1);
        v0
    }

    fun assert_current_version(arg0: &StrategyManager) {
        assert!(arg0.version == 1, 13906835926690496520);
    }

    public fun consume_deposit_request<T0>(arg0: DepositRequest<T0>) : 0x2::coin::Coin<T0> {
        let DepositRequest { collateral: v0 } = arg0;
        v0
    }

    public fun consume_withdrawal_request<T0>(arg0: WithdrawalRequest<T0>) : u64 {
        let WithdrawalRequest { amount: v0 } = arg0;
        v0
    }

    public(friend) fun create_collateral_buffer<T0>(arg0: &mut StrategyManager) {
        let v0 = BufferKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<BufferKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
    }

    public fun create_deposit_request<T0>(arg0: &AllocatorCap, arg1: u64, arg2: &mut StrategyManager, arg3: &mut 0x2::tx_context::TxContext) : DepositRequest<T0> {
        assert_current_version(arg2);
        DepositRequest<T0>{collateral: withdraw_from_buffer<T0>(arg1, arg2, arg3)}
    }

    public fun create_withdrawal_request<T0>(arg0: &AllocatorCap, arg1: u64) : WithdrawalRequest<T0> {
        WithdrawalRequest<T0>{amount: arg1}
    }

    public(friend) fun deposit_to_buffer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut StrategyManager) {
        let v0 = get_buffer_mut<T0>(arg1);
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg0));
        arg1.total_buffer = arg1.total_buffer + 0x2::coin::value<T0>(&arg0);
    }

    public(friend) fun destroy_collateral_buffer<T0>(arg0: &mut StrategyManager) : 0x2::balance::Balance<T0> {
        let v0 = BufferKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<BufferKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun get_buffer_mut<T0>(arg0: &mut StrategyManager) : &mut 0x2::balance::Balance<T0> {
        let v0 = BufferKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BufferKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun get_buffer_read_only<T0>(arg0: &StrategyManager) : &0x2::balance::Balance<T0> {
        let v0 = BufferKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<BufferKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)
    }

    public(friend) fun get_total_collateral_value(arg0: &StrategyManager) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<0x2::object::ID, StrategyState>(&arg0.strategies);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            v0 = v0 + 0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, 0x1::vector::borrow<0x2::object::ID>(&v1, v2)).supplied;
            v2 = v2 + 1;
        };
        v0 + arg0.total_buffer
    }

    public fun harvest<T0>(arg0: &HarvesterCap, arg1: u64, arg2: &mut StrategyManager, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2.yield_accrued >= arg1, 13906835832200822786);
        assert_current_version(arg2);
        assert!(0x2::balance::value<T0>(get_buffer_read_only<T0>(arg2)) >= arg1, 13906835866560692228);
        arg2.yield_accrued = arg2.yield_accrued - arg1;
        withdraw_from_buffer<T0>(arg1, arg2, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AllocatorCap{id: 0x2::object::new(arg0)};
        let v1 = HarvesterCap{id: 0x2::object::new(arg0)};
        let v2 = StrategyManager{
            id            : 0x2::object::new(arg0),
            strategies    : 0x2::vec_map::empty<0x2::object::ID, StrategyState>(),
            total_buffer  : 0,
            yield_accrued : 0,
            version       : 1,
            admin_id      : 0x2::object::id<AllocatorCap>(&v0),
        };
        0x2::transfer::share_object<StrategyManager>(v2);
        0x2::transfer::transfer<AllocatorCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<HarvesterCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &mut StrategyManager, arg1: &AllocatorCap) {
        assert!(arg0.admin_id == 0x2::object::id<AllocatorCap>(arg1), 13906835952460562444);
        assert!(arg0.version < 1, 13906835956755398666);
        arg0.version = 1;
    }

    public(friend) fun new_strategy_removal_ticket(arg0: ManagerAccess) : StrategyRemovalTicket {
        StrategyRemovalTicket{access: arg0}
    }

    public fun remove_strategy(arg0: &AllocatorCap, arg1: &mut StrategyManager, arg2: StrategyRemovalTicket) {
        assert_current_version(arg1);
        let StrategyRemovalTicket { access: v0 } = arg2;
        let ManagerAccess { id: v1 } = v0;
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x2::object::delete(v1);
        let (_, v4) = 0x2::vec_map::remove<0x2::object::ID, StrategyState>(&mut arg1.strategies, &v2);
        let StrategyState { supplied: v5 } = v4;
        assert!(v5 == 0, 13906835522963439622);
    }

    public fun update_strategy_supplied(arg0: &mut StrategyManager, arg1: &ManagerAccess, arg2: u64) {
        assert_current_version(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, &v0).supplied = arg2;
    }

    public(friend) fun update_yield_accrued(arg0: &mut StrategyManager, arg1: u64) {
        arg0.yield_accrued = arg1;
    }

    public(friend) fun withdraw_from_buffer<T0>(arg0: u64, arg1: &mut StrategyManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = get_buffer_mut<T0>(arg1);
        arg1.total_buffer = arg1.total_buffer - arg0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg0), arg2)
    }

    // decompiled from Move bytecode v6
}

