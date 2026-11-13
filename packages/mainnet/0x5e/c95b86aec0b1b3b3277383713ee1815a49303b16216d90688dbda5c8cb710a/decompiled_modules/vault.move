module 0x5ec95b86aec0b1b3b3277383713ee1815a49303b16216d90688dbda5c8cb710a::vault {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        shares_minted: u64,
        amount_a: u64,
        amount_b: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawer: address,
        shares_burned: u64,
        amount_a_returned: u64,
        amount_b_returned: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        operator: address,
        old_lower_tick: u32,
        old_upper_tick: u32,
        new_lower_tick: u32,
        new_upper_tick: u32,
        timestamp_ms: u64,
    }

    struct FeeHarvestedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        gross_fee_a: u64,
        gross_fee_b: u64,
        performance_fee_a: u64,
        performance_fee_b: u64,
        compounded_amount_a: u64,
        compounded_amount_b: u64,
    }

    struct PerformanceFeePaidEvent has copy, drop {
        vault_id: 0x2::object::ID,
        treasury: address,
        fee_a: u64,
        fee_b: u64,
    }

    struct OperatorUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        new_operator: address,
    }

    struct PositionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RebalanceReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        total_shares: u64,
        fee_rate_bps: u64,
        fee_treasury: address,
        clmm_position_id: 0x1::option::Option<0x2::object::ID>,
        current_lower_tick: u32,
        current_upper_tick: u32,
        is_rebalancing: bool,
    }

    struct VaultShare<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun admin_cap_vault_id(arg0: &VaultAdminCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun borrow_position<T0, T1, T2: store + key>(arg0: &Vault<T0, T1>) : &T2 {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<PositionKey, T2>(&arg0.id, v0)
    }

    public fun clmm_position_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.clmm_position_id
    }

    public fun create_vault<T0, T1>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 2500, 4);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                 : v0,
            balance_a          : 0x2::balance::zero<T0>(),
            balance_b          : 0x2::balance::zero<T1>(),
            total_shares       : 0,
            fee_rate_bps       : arg0,
            fee_treasury       : arg1,
            clmm_position_id   : 0x1::option::none<0x2::object::ID>(),
            current_lower_tick : 0,
            current_upper_tick : 0,
            is_rebalancing     : false,
        };
        let v3 = VaultAdminCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v4 = OperatorCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v5 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<VaultAdminCap>(v3, v5);
        0x2::transfer::transfer<OperatorCap>(v4, v5);
        0x2::transfer::share_object<Vault<T0, T1>>(v2);
    }

    public fun create_vault_default<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_vault<T0, T1>(1000, arg0, arg1);
    }

    public fun current_ticks<T0, T1>(arg0: &Vault<T0, T1>) : (u32, u32) {
        (arg0.current_lower_tick, arg0.current_upper_tick)
    }

    public fun default_fee_bps() : u64 {
        1000
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : VaultShare<T0, T1> {
        assert!(!arg0.is_rebalancing, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 || v1 > 0, 1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance_a);
        let v3 = 0x2::balance::value<T1>(&arg0.balance_b);
        let v4 = if (arg0.total_shares == 0) {
            let v5 = v0 + v1;
            assert!(v5 > 1000, 13);
            arg0.total_shares = 1000;
            v5 - 1000
        } else {
            let v6 = if (v2 > 0) {
                (((v0 as u128) * (arg0.total_shares as u128) / (v2 as u128)) as u64)
            } else {
                0
            };
            let v7 = if (v3 > 0) {
                (((v1 as u128) * (arg0.total_shares as u128) / (v3 as u128)) as u64)
            } else {
                0
            };
            if (v6 > 0 && v7 > 0) {
                if (v6 < v7) {
                    v6
                } else {
                    v7
                }
            } else if (v6 > 0) {
                v6
            } else {
                v7
            }
        };
        assert!(v4 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        arg0.total_shares = arg0.total_shares + v4;
        let v8 = 0x2::object::uid_to_inner(&arg0.id);
        let v9 = DepositEvent{
            vault_id      : v8,
            depositor     : 0x2::tx_context::sender(arg3),
            shares_minted : v4,
            amount_a      : v0,
            amount_b      : v1,
        };
        0x2::event::emit<DepositEvent>(v9);
        VaultShare<T0, T1>{
            id       : 0x2::object::new(arg3),
            vault_id : v8,
            shares   : v4,
        }
    }

    public fun deposit_position<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: T2) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = PositionKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0), 11);
        arg1.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&arg2));
        let v1 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg1.id, v1, arg2);
    }

    public fun fee_rate<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.fee_rate_bps
    }

    public fun fee_treasury<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.fee_treasury
    }

    public fun finish_rebalance<T0, T1, T2: store + key>(arg0: &mut Vault<T0, T1>, arg1: RebalanceReceipt<T0, T1>, arg2: 0x1::option::Option<T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let RebalanceReceipt { vault_id: v0 } = arg1;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 12);
        assert!(arg0.is_rebalancing, 10);
        arg0.is_rebalancing = false;
        if (0x1::option::is_some<T2>(&arg2)) {
            let v1 = 0x1::option::destroy_some<T2>(arg2);
            let v2 = PositionKey{dummy_field: false};
            assert!(!0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v2), 11);
            arg0.clmm_position_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<T2>(&v1));
            let v3 = PositionKey{dummy_field: false};
            0x2::dynamic_object_field::add<PositionKey, T2>(&mut arg0.id, v3, v1);
        } else {
            0x1::option::destroy_none<T2>(arg2);
            arg0.clmm_position_id = 0x1::option::none<0x2::object::ID>();
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg3));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg4));
        assert!(arg5 < arg6, 5);
        arg0.current_lower_tick = arg5;
        arg0.current_upper_tick = arg6;
        let v4 = RebalanceEvent{
            vault_id       : 0x2::object::uid_to_inner(&arg0.id),
            operator       : 0x2::tx_context::sender(arg8),
            old_lower_tick : arg0.current_lower_tick,
            old_upper_tick : arg0.current_upper_tick,
            new_lower_tick : arg5,
            new_upper_tick : arg6,
            timestamp_ms   : arg7,
        };
        0x2::event::emit<RebalanceEvent>(v4);
    }

    public fun harvest_and_compound<T0, T1>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(!arg1.is_rebalancing, 9);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = (((v0 as u128) * (arg1.fee_rate_bps as u128) / 10000) as u64);
        let v3 = (((v1 as u128) * (arg1.fee_rate_bps as u128) / 10000) as u64);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v2), arg4), arg1.fee_treasury);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v3), arg4), arg1.fee_treasury);
        };
        0x2::balance::join<T0>(&mut arg1.balance_a, v4);
        0x2::balance::join<T1>(&mut arg1.balance_b, v5);
        let v6 = 0x2::object::uid_to_inner(&arg1.id);
        let v7 = PerformanceFeePaidEvent{
            vault_id : v6,
            treasury : arg1.fee_treasury,
            fee_a    : v2,
            fee_b    : v3,
        };
        0x2::event::emit<PerformanceFeePaidEvent>(v7);
        let v8 = FeeHarvestedEvent{
            vault_id            : v6,
            gross_fee_a         : v0,
            gross_fee_b         : v1,
            performance_fee_a   : v2,
            performance_fee_b   : v3,
            compounded_amount_a : 0x2::balance::value<T0>(&v4),
            compounded_amount_b : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<FeeHarvestedEvent>(v8);
    }

    public fun has_position<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        let v0 = PositionKey{dummy_field: false};
        0x2::dynamic_object_field::exists<PositionKey>(&arg0.id, v0)
    }

    public fun is_rebalancing<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_rebalancing
    }

    public fun max_fee_bps() : u64 {
        2500
    }

    public fun merge_shares<T0, T1>(arg0: &mut VaultShare<T0, T1>, arg1: VaultShare<T0, T1>) {
        let VaultShare {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(arg0.vault_id == v1, 3);
        arg0.shares = arg0.shares + v2;
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun operator_cap_vault_id(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun position_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.clmm_position_id
    }

    public fun receipt_vault_id<T0, T1>(arg0: &RebalanceReceipt<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun record_rebalance<T0, T1>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(!arg1.is_rebalancing, 9);
        assert!(arg2 < arg3, 5);
        arg1.current_lower_tick = arg2;
        arg1.current_upper_tick = arg3;
        let v0 = RebalanceEvent{
            vault_id       : 0x2::object::uid_to_inner(&arg1.id),
            operator       : 0x2::tx_context::sender(arg5),
            old_lower_tick : arg1.current_lower_tick,
            old_upper_tick : arg1.current_upper_tick,
            new_lower_tick : arg2,
            new_upper_tick : arg3,
            timestamp_ms   : arg4,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun set_fee_rate<T0, T1>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        assert!(arg2 <= 2500, 4);
        arg1.fee_rate_bps = arg2;
    }

    public fun set_treasury<T0, T1>(arg0: &VaultAdminCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 8);
        arg1.fee_treasury = arg2;
    }

    public fun share_shares<T0, T1>(arg0: &VaultShare<T0, T1>) : u64 {
        arg0.shares
    }

    public fun share_vault_id<T0, T1>(arg0: &VaultShare<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun split_share<T0, T1>(arg0: &mut VaultShare<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VaultShare<T0, T1> {
        assert!(arg1 > 0, 2);
        assert!(arg0.shares > arg1, 6);
        arg0.shares = arg0.shares - arg1;
        VaultShare<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault_id : arg0.vault_id,
            shares   : arg1,
        }
    }

    public fun start_rebalance<T0, T1, T2: store + key>(arg0: &OperatorCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<T2>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, RebalanceReceipt<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(!arg1.is_rebalancing, 9);
        arg1.is_rebalancing = true;
        let v0 = PositionKey{dummy_field: false};
        let v1 = if (0x2::dynamic_object_field::exists<PositionKey>(&arg1.id, v0)) {
            let v2 = PositionKey{dummy_field: false};
            arg1.clmm_position_id = 0x1::option::none<0x2::object::ID>();
            0x1::option::some<T2>(0x2::dynamic_object_field::remove<PositionKey, T2>(&mut arg1.id, v2))
        } else {
            0x1::option::none<T2>()
        };
        let v3 = RebalanceReceipt<T0, T1>{vault_id: 0x2::object::uid_to_inner(&arg1.id)};
        (v1, 0x2::coin::take<T0>(&mut arg1.balance_a, 0x2::balance::value<T0>(&arg1.balance_a), arg2), 0x2::coin::take<T1>(&mut arg1.balance_b, 0x2::balance::value<T1>(&arg1.balance_b), arg2), v3)
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: VaultShare<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let VaultShare {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 3);
        assert!(v2 > 0, 2);
        assert!(!arg0.is_rebalancing, 9);
        let v3 = (((v2 as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / (arg0.total_shares as u128)) as u64);
        let v4 = (((v2 as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / (arg0.total_shares as u128)) as u64);
        arg0.total_shares = arg0.total_shares - v2;
        let v5 = WithdrawEvent{
            vault_id          : v1,
            withdrawer        : 0x2::tx_context::sender(arg2),
            shares_burned     : v2,
            amount_a_returned : v3,
            amount_b_returned : v4,
        };
        0x2::event::emit<WithdrawEvent>(v5);
        (0x2::coin::take<T0>(&mut arg0.balance_a, v3, arg2), 0x2::coin::take<T1>(&mut arg0.balance_b, v4, arg2))
    }

    // decompiled from Move bytecode v7
}

