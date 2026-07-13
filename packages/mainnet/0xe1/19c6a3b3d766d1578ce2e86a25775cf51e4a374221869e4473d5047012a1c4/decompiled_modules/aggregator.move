module 0xe119c6a3b3d766d1578ce2e86a25775cf51e4a374221869e4473d5047012a1c4::aggregator {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        fee_bps: u16,
        fee_vault_id: 0x2::object::ID,
    }

    struct FeeVault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct FeeReceipt {
        order_id: vector<u8>,
        fee_amount: u64,
    }

    struct SwapExecutedEvent has copy, drop {
        order_id: vector<u8>,
        fee_amount: u64,
        amount_out_actual: u64,
    }

    struct BridgeCreatedEvent has copy, drop {
        order_id: vector<u8>,
        fee_amount: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        amount_in: u64,
        fee_amount: u64,
        payer: address,
    }

    fun assert_fee_vault(arg0: &Config, arg1: &FeeVault) {
        assert!(arg0.fee_vault_id == 0x2::object::id<FeeVault>(arg1), 4);
    }

    fun assert_owner(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
    }

    fun calculate_fee_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun collect_fee<T0>(arg0: &mut FeeVault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg3 > 0) {
            deposit_fee<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg3, arg4));
        };
        let v0 = FeeCollectedEvent{
            amount_in  : arg2,
            fee_amount : arg3,
            payer      : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeeCollectedEvent>(v0);
        arg1
    }

    public(friend) fun complete_bridge(arg0: FeeReceipt) {
        let (v0, v1) = destroy_fee_receipt(arg0);
        let v2 = BridgeCreatedEvent{
            order_id   : v0,
            fee_amount : v1,
        };
        0x2::event::emit<BridgeCreatedEvent>(v2);
    }

    public(friend) fun complete_swap<T0>(arg0: &Config, arg1: &mut FeeVault, arg2: FeeReceipt, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 5);
        let (v1, v2) = destroy_fee_receipt(arg2);
        let v3 = if (arg6) {
            let v4 = fee_amount(arg0, v0);
            if (v4 > 0) {
                deposit_fee<T0>(arg1, 0x2::coin::split<T0>(&mut arg3, v4, arg7));
            };
            v4
        } else {
            v2
        };
        let v5 = 0x2::coin::value<T0>(&arg3);
        assert!(v5 >= arg4, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg5);
        let v6 = SwapExecutedEvent{
            order_id          : v1,
            fee_amount        : v3,
            amount_out_actual : v5,
        };
        0x2::event::emit<SwapExecutedEvent>(v6);
        v5
    }

    fun deposit_fee<T0>(arg0: &mut FeeVault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun destroy_fee_receipt(arg0: FeeReceipt) : (vector<u8>, u64) {
        let FeeReceipt {
            order_id   : v0,
            fee_amount : v1,
        } = arg0;
        (v0, v1)
    }

    fun fee_amount(arg0: &Config, arg1: u64) : u64 {
        calculate_fee_amount(arg1, arg0.fee_bps)
    }

    public fun initialize(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 1000, 1);
        let v0 = FeeVault{
            id       : 0x2::object::new(arg1),
            balances : 0x2::bag::new(arg1),
        };
        let v1 = Config{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            fee_bps      : arg0,
            fee_vault_id : 0x2::object::id<FeeVault>(&v0),
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::share_object<FeeVault>(v0);
    }

    public(friend) fun prepare_swap_input<T0>(arg0: &Config, arg1: &mut FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FeeReceipt) {
        if (arg4) {
            assert_fee_vault(arg0, arg1);
            assert!(0x2::coin::value<T0>(&arg3) > 0, 3);
            let v1 = FeeReceipt{
                order_id   : arg2,
                fee_amount : 0,
            };
            (arg3, v1)
        } else {
            let (v2, v3) = take_fee<T0>(arg0, arg1, arg2, arg3, arg5);
            let v1 = v3;
            (v2, v1)
        }
    }

    public fun set_fee_bps(arg0: &mut Config, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 <= 1000, 1);
        arg0.fee_bps = arg1;
    }

    public fun take_fee<T0>(arg0: &Config, arg1: &mut FeeVault, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FeeReceipt) {
        assert_fee_vault(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 3);
        let v1 = fee_amount(arg0, v0);
        let v2 = FeeReceipt{
            order_id   : arg2,
            fee_amount : v1,
        };
        (collect_fee<T0>(arg1, arg3, v0, v1, arg4), v2)
    }

    public fun transfer_ownership(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.owner = arg1;
    }

    public fun withdraw_fee<T0>(arg0: &Config, arg1: &mut FeeVault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert_fee_vault(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_fee_coin<T0>(arg1, arg3), arg2);
    }

    fun withdraw_fee_coin<T0>(arg0: &mut FeeVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::with_original_ids<T0>());
        let v1 = 0x2::balance::value<T0>(v0);
        assert!(v1 > 0, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, v1), arg1)
    }

    // decompiled from Move bytecode v7
}

