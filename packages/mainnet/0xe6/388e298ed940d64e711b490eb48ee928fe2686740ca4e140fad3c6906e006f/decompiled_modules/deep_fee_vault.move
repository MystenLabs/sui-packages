module 0xe6388e298ed940d64e711b490eb48ee928fe2686740ca4e140fad3c6906e006f::deep_fee_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepFeeVault has key {
        id: 0x2::object::UID,
        deep_balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        operators: 0x2::vec_set::VecSet<address>,
        allowed_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        max_fee_per_swap: u64,
        paused: bool,
    }

    struct DepositEvent has copy, drop, store {
        vault: 0x2::object::ID,
        sender: address,
        amount: u64,
        vault_balance: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        vault: 0x2::object::ID,
        recipient: address,
        amount: u64,
        vault_balance: u64,
    }

    struct OperatorUpdatedEvent has copy, drop, store {
        vault: 0x2::object::ID,
        operator: address,
        enabled: bool,
    }

    struct PoolAllowlistUpdatedEvent has copy, drop, store {
        vault: 0x2::object::ID,
        pool: 0x2::object::ID,
        enabled: bool,
    }

    struct MaxFeePerSwapUpdatedEvent has copy, drop, store {
        vault: 0x2::object::ID,
        max_fee_per_swap: u64,
    }

    struct PausedUpdatedEvent has copy, drop, store {
        vault: 0x2::object::ID,
        paused: bool,
    }

    struct VaultDeepFeeSwapEvent has copy, drop, store {
        vault: 0x2::object::ID,
        sender: address,
        pool: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        unused_in: u64,
        required_deep_fee: u64,
        returned_deep_fee: u64,
        consumed_deep_fee: u64,
        max_deep_fee: u64,
        max_fee_per_swap: u64,
    }

    public fun add_allowed_pool(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.allowed_pools, arg2);
        let v0 = PoolAllowlistUpdatedEvent{
            vault   : 0x2::object::id<DeepFeeVault>(arg1),
            pool    : arg2,
            enabled : true,
        };
        0x2::event::emit<PoolAllowlistUpdatedEvent>(v0);
    }

    public fun add_operator(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.operators, arg2);
        let v0 = OperatorUpdatedEvent{
            vault    : 0x2::object::id<DeepFeeVault>(arg1),
            operator : arg2,
            enabled  : true,
        };
        0x2::event::emit<OperatorUpdatedEvent>(v0);
    }

    fun assert_swap_allowed<T0, T1>(arg0: &DeepFeeVault, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 1);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &v1), 3);
        assert!(arg2 > 0, 7);
    }

    public fun deposit(arg0: &mut DeepFeeVault, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, arg1);
        let v0 = DepositEvent{
            vault         : 0x2::object::id<DeepFeeVault>(arg0),
            sender        : 0x2::tx_context::sender(arg2),
            amount        : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1),
            vault_balance : 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_balance),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun emit_swap_event<T0, T1>(arg0: &DeepFeeVault, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        let v0 = VaultDeepFeeSwapEvent{
            vault             : 0x2::object::id<DeepFeeVault>(arg0),
            sender            : 0x2::tx_context::sender(arg10),
            pool              : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            a2b               : arg2,
            amount_in         : arg3,
            amount_out        : arg4,
            unused_in         : arg5,
            required_deep_fee : arg6,
            returned_deep_fee : arg7,
            consumed_deep_fee : arg8,
            max_deep_fee      : arg9,
            max_fee_per_swap  : arg0.max_fee_per_swap,
        };
        0x2::event::emit<VaultDeepFeeSwapEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = DeepFeeVault{
            id               : 0x2::object::new(arg0),
            deep_balance     : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            operators        : 0x2::vec_set::singleton<address>(v0),
            allowed_pools    : 0x2::vec_set::empty<0x2::object::ID>(),
            max_fee_per_swap : 0,
            paused           : false,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<DeepFeeVault>(v1);
    }

    public fun is_operator(arg0: &DeepFeeVault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_pool_allowed(arg0: &DeepFeeVault, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1)
    }

    public fun max_fee_per_swap(arg0: &DeepFeeVault) : u64 {
        arg0.max_fee_per_swap
    }

    public fun paused(arg0: &DeepFeeVault) : bool {
        arg0.paused
    }

    public fun remove_allowed_pool(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.allowed_pools, &arg2);
        let v0 = PoolAllowlistUpdatedEvent{
            vault   : 0x2::object::id<DeepFeeVault>(arg1),
            pool    : arg2,
            enabled : false,
        };
        0x2::event::emit<PoolAllowlistUpdatedEvent>(v0);
    }

    public fun remove_operator(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.operators, &arg2);
        let v0 = OperatorUpdatedEvent{
            vault    : 0x2::object::id<DeepFeeVault>(arg1),
            operator : arg2,
            enabled  : false,
        };
        0x2::event::emit<OperatorUpdatedEvent>(v0);
    }

    public fun set_max_fee_per_swap(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: u64) {
        arg1.max_fee_per_swap = arg2;
        let v0 = MaxFeePerSwapUpdatedEvent{
            vault            : 0x2::object::id<DeepFeeVault>(arg1),
            max_fee_per_swap : arg2,
        };
        0x2::event::emit<MaxFeePerSwapUpdatedEvent>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedUpdatedEvent{
            vault  : 0x2::object::id<DeepFeeVault>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PausedUpdatedEvent>(v0);
    }

    public fun swap_a2b_with_vault_fee<T0, T1>(arg0: &mut DeepFeeVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = swap_a2b_with_vault_fee_full<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_or_destroy_zero<T0>(v0, arg6);
        (v1, v2)
    }

    public fun swap_a2b_with_vault_fee_full<T0, T1>(arg0: &mut DeepFeeVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert_swap_allowed<T0, T1>(arg0, arg1, v0, arg6);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg5);
        let v4 = take_deep_fee(arg0, v3, arg4, arg6);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v4, arg3, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = 0x2::coin::value<T1>(&v9);
        let v12 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8);
        let v13 = v3 - v12;
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, v8);
        assert!(v11 > 0, 10);
        assert!(v11 >= arg3, 6);
        emit_swap_event<T0, T1>(arg0, arg1, true, v0, v11, 0x2::coin::value<T0>(&v10), v3, v12, v13, arg4, arg6);
        (v10, v9, v13)
    }

    public fun swap_b2a_with_vault_fee<T0, T1>(arg0: &mut DeepFeeVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = swap_b2a_with_vault_fee_full<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        transfer_or_destroy_zero<T1>(v0, arg6);
        (v1, v2)
    }

    public fun swap_b2a_with_vault_fee_full<T0, T1>(arg0: &mut DeepFeeVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert_swap_allowed<T0, T1>(arg0, arg1, v0, arg6);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg5);
        let v4 = take_deep_fee(arg0, v3, arg4, arg6);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v4, arg3, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = 0x2::coin::value<T0>(&v10);
        let v12 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8);
        let v13 = v3 - v12;
        0x2::coin::put<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, v8);
        assert!(v11 > 0, 10);
        assert!(v11 >= arg3, 6);
        emit_swap_event<T0, T1>(arg0, arg1, false, v0, v11, 0x2::coin::value<T1>(&v9), v3, v12, v13, arg4, arg6);
        (v9, v10, v13)
    }

    fun take_deep_fee(arg0: &mut DeepFeeVault, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg1 > 0, 9);
        assert!(arg1 <= arg2, 4);
        assert!(arg1 <= arg0.max_fee_per_swap, 8);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_balance) >= arg1, 5);
        0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_balance, arg1, arg3)
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun vault_deep_balance(arg0: &DeepFeeVault) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_balance)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut DeepFeeVault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.deep_balance) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.deep_balance, arg2, arg4), arg3);
        let v0 = WithdrawEvent{
            vault         : 0x2::object::id<DeepFeeVault>(arg1),
            recipient     : arg3,
            amount        : arg2,
            vault_balance : 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.deep_balance),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

