module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::mock_pond {
    struct MockPondType has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolStoredBalance<phantom T0> has store {
        pool_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct MockPond<phantom T0> has store, key {
        id: 0x2::object::UID,
        balances_by_pool: vector<PoolStoredBalance<T0>>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        pond_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        pond_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public fun admin_create<T0>(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_internal<T0>(arg1);
        0x2::transfer::share_object<MockPond<T0>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun admin_deposit_from_pool<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg3: &0x2::object::ID, arg4: u64) {
        deposit_from_pool_internal<T0>(arg0, arg1, arg3, arg4);
    }

    public fun admin_withdraw_to_pool<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg3: &0x2::object::ID, arg4: u64) {
        withdraw_to_pool_internal<T0>(arg0, arg1, arg3, arg4);
    }

    public fun balance_value<T0>(arg0: &MockPond<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<PoolStoredBalance<T0>>(&arg0.balances_by_pool)) {
            v1 = v1 + 0x2::balance::value<T0>(&0x1::vector::borrow<PoolStoredBalance<T0>>(&arg0.balances_by_pool, v0).balance);
            v0 = v0 + 1;
        };
        v1
    }

    fun borrow_or_create_pool_balance_mut<T0>(arg0: &mut MockPond<T0>, arg1: &0x2::object::ID) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PoolStoredBalance<T0>>(&arg0.balances_by_pool)) {
            let v1 = 0x1::vector::borrow_mut<PoolStoredBalance<T0>>(&mut arg0.balances_by_pool, v0);
            if (v1.pool_id == *arg1) {
                return &mut v1.balance
            };
            v0 = v0 + 1;
        };
        let v2 = PoolStoredBalance<T0>{
            pool_id : *arg1,
            balance : 0x2::balance::zero<T0>(),
        };
        0x1::vector::push_back<PoolStoredBalance<T0>>(&mut arg0.balances_by_pool, v2);
        &mut 0x1::vector::borrow_mut<PoolStoredBalance<T0>>(&mut arg0.balances_by_pool, 0x1::vector::length<PoolStoredBalance<T0>>(&arg0.balances_by_pool) - 1).balance
    }

    fun borrow_pool_balance_mut<T0>(arg0: &mut MockPond<T0>, arg1: &0x2::object::ID) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v0 < 0x1::vector::length<PoolStoredBalance<T0>>(&arg0.balances_by_pool)) {
            if (0x1::vector::borrow<PoolStoredBalance<T0>>(&arg0.balances_by_pool, v0).pool_id == *arg1) {
                v1 = true;
                v2 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 13835903081507848195);
        &mut 0x1::vector::borrow_mut<PoolStoredBalance<T0>>(&mut arg0.balances_by_pool, v2).balance
    }

    fun create_internal<T0>(arg0: &mut 0x2::tx_context::TxContext) : MockPond<T0> {
        MockPond<T0>{
            id               : 0x2::object::new(arg0),
            balances_by_pool : 0x1::vector::empty<PoolStoredBalance<T0>>(),
        }
    }

    fun deposit_from_pool_internal<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0x2::object::ID, arg3: u64) {
        let v0 = pond_marker();
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        0x2::balance::join<T0>(borrow_or_create_pool_balance_mut<T0>(arg0, arg2), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_pipe<T0, MockPondType>(arg1, &v0, arg2, &v1, arg3));
        let v2 = DepositEvent<T0>{
            pond_id : v1,
            pool_id : *arg2,
            amount  : arg3,
        };
        0x2::event::emit<DepositEvent<T0>>(v2);
    }

    public fun id<T0>(arg0: &MockPond<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun manager_create<T0>(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<MockPondType>(arg0, 0x2::tx_context::sender(arg1));
        let v0 = create_internal<T0>(arg1);
        0x2::transfer::share_object<MockPond<T0>>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun manager_deposit_from_pool<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg3: &0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<MockPondType>(arg2, 0x2::tx_context::sender(arg5));
        deposit_from_pool_internal<T0>(arg0, arg1, arg3, arg4);
    }

    public fun manager_withdraw_to_pool<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg3: &0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<MockPondType>(arg2, 0x2::tx_context::sender(arg5));
        withdraw_to_pool_internal<T0>(arg0, arg1, arg3, arg4);
    }

    fun pond_marker() : MockPondType {
        MockPondType{dummy_field: false}
    }

    fun withdraw_to_pool_internal<T0>(arg0: &mut MockPond<T0>, arg1: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg2: &0x2::object::ID, arg3: u64) {
        let v0 = pond_marker();
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = borrow_pool_balance_mut<T0>(arg0, arg2);
        assert!(0x2::balance::value<T0>(v2) >= arg3, 13835340294763053057);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_put_into_pipe<T0, MockPondType>(arg1, &v0, arg2, &v1, 0x2::balance::split<T0>(v2, arg3));
        let v3 = WithdrawEvent<T0>{
            pond_id : v1,
            pool_id : *arg2,
            amount  : arg3,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

