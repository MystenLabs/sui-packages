module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::vault {
    struct IndexVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        deposit_balance: 0x2::balance::Balance<T0>,
        accrued_fees: u64,
        basket: 0x2::bag::Bag,
        treasury: 0x2::coin::TreasuryCap<T1>,
        nav_micro: u64,
        last_marked_ms: u64,
        locked_until_ms: u64,
        active_proposal_id: u64,
        active_methodology_hash: vector<u8>,
        active_target_weights_hash: vector<u8>,
    }

    struct LegEscrow {
        vault_id: 0x2::object::ID,
        proposal_id: u64,
        methodology_hash: vector<u8>,
        target_weights_hash: vector<u8>,
        router: address,
        input_type: 0x1::type_name::TypeName,
        output_type: 0x1::type_name::TypeName,
        amount_in: u64,
        min_amount_out: u64,
        notional_usd_micro: u64,
    }

    public fun accrued_fees<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        arg0.accrued_fees
    }

    fun assert_active_ticket<T0, T1>(arg0: &IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket) {
        assert!(arg0.active_proposal_id == 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_proposal_id(arg1), 27);
        assert!(arg0.active_methodology_hash == 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_methodology_hash(arg1), 27);
        assert!(arg0.active_target_weights_hash == 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_target_weights_hash(arg1), 27);
    }

    fun assert_fee_backed<T0, T1>(arg0: &IndexVault<T0, T1>) {
        assert!(arg0.accrued_fees <= 0x2::balance::value<T0>(&arg0.deposit_balance), 27);
    }

    fun assert_nav_fresh<T0, T1>(arg0: &IndexVault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.last_marked_ms + 600000, 14);
    }

    fun assert_registry_bound<T0, T1>(arg0: &IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry) {
        assert!(0x2::object::id<0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry>(arg1) == arg0.registry_id, 21);
    }

    fun assert_ticket_bound<T0, T1>(arg0: &IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket) {
        assert!(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_vault_id(arg1) == 0x2::object::id<IndexVault<T0, T1>>(arg0), 20);
    }

    public fun basket_has_token<T0, T1, T2>(arg0: &IndexVault<T0, T1>) : bool {
        0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, 0x1::type_name::with_defining_ids<T2>())
    }

    public fun basket_value_for_token<T0, T1, T2>(arg0: &IndexVault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, v0)) {
            0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, v0))
        } else {
            0
        }
    }

    public fun collect_fees<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_registry_bound<T0, T1>(arg0, arg1);
        assert!(arg3 > 0, 2);
        assert!(arg3 <= arg0.accrued_fees, 12);
        arg0.accrued_fees = arg0.accrued_fees - arg3;
        assert_fee_backed<T0, T1>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.deposit_balance, arg3), arg4)
    }

    fun compute_max_delta(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (2000 as u128) * (arg1 as u128) / (10000 as u128) * (86400000 as u128);
        assert!(v0 <= 9223372036854775808, 25);
        (v0 as u64)
    }

    public fun create<T0, T1>(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: 0x2::coin::TreasuryCap<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : IndexVault<T0, T1> {
        assert!(0x2::coin::total_supply<T1>(&arg2) == 0, 14);
        let v0 = 0x2::object::id<0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry>(arg1);
        let v1 = IndexVault<T0, T1>{
            id                         : 0x2::object::new(arg4),
            registry_id                : v0,
            deposit_balance            : 0x2::balance::zero<T0>(),
            accrued_fees               : 0,
            basket                     : 0x2::bag::new(arg4),
            treasury                   : arg2,
            nav_micro                  : 1000000,
            last_marked_ms             : 0x2::clock::timestamp_ms(arg3),
            locked_until_ms            : 0,
            active_proposal_id         : 0,
            active_methodology_hash    : b"",
            active_target_weights_hash : b"",
        };
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_vault_created(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_vault_created(0x2::object::uid_to_inner(&v1.id), v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
        v1
    }

    public fun deposit_balance_value<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit_balance)
    }

    fun fee_bps_safe(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (10000 as u128);
        assert!(v0 <= 9223372036854775808, 25);
        (v0 as u64)
    }

    public(friend) fun finish_rebalance_leg<T0, T1, T2>(arg0: &mut IndexVault<T0, T1>, arg1: LegEscrow, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock) {
        let LegEscrow {
            vault_id            : v0,
            proposal_id         : v1,
            methodology_hash    : v2,
            target_weights_hash : v3,
            router              : v4,
            input_type          : v5,
            output_type         : v6,
            amount_in           : v7,
            min_amount_out      : v8,
            notional_usd_micro  : _,
        } = arg1;
        assert!(v0 == 0x2::object::id<IndexVault<T0, T1>>(arg0), 20);
        assert!(v1 == arg0.active_proposal_id, 27);
        assert!(v2 == arg0.active_methodology_hash, 27);
        assert!(v3 == arg0.active_target_weights_hash, 27);
        assert!(v6 == 0x1::type_name::with_defining_ids<T2>(), 27);
        let v10 = 0x2::coin::value<T2>(&arg2);
        assert!(v10 >= v8, 4);
        assert!(v10 > 0, 28);
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, v6)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v6), 0x2::coin::into_balance<T2>(arg2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v6, 0x2::coin::into_balance<T2>(arg2));
        };
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_rebalance_leg_finished(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_rebalance_leg_finished(0x2::object::uid_to_inner(&arg0.id), v1, v4, 0x1::type_name::into_string(v5), 0x1::type_name::into_string(v6), v7, v10, 0x2::clock::timestamp_ms(arg3)));
    }

    public fun finish_rebalance_leg_with_receipt<T0, T1, T2, T3>(arg0: &mut IndexVault<T0, T1>, arg1: LegEscrow, arg2: 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::AdapterReceipt<T3>, arg3: &0x2::clock::Clock) {
        let LegEscrow {
            vault_id            : v0,
            proposal_id         : v1,
            methodology_hash    : v2,
            target_weights_hash : v3,
            router              : v4,
            input_type          : v5,
            output_type         : v6,
            amount_in           : v7,
            min_amount_out      : v8,
            notional_usd_micro  : _,
        } = arg1;
        let (v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, _) = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::router_adapter::consume<T3>(arg2);
        assert!(v0 == v11, 27);
        assert!(v1 == v12, 27);
        assert!(v2 == v13, 27);
        assert!(v3 == v14, 27);
        assert!(v4 == v15, 27);
        assert!(v5 == v16, 27);
        assert!(v6 == v17, 27);
        assert!(v7 == v18, 27);
        assert!(v8 == v19, 27);
        assert!(v6 == 0x1::type_name::with_defining_ids<T3>(), 27);
        assert!(v0 == 0x2::object::id<IndexVault<T0, T1>>(arg0), 20);
        assert!(v1 == arg0.active_proposal_id, 27);
        assert!(v2 == arg0.active_methodology_hash, 27);
        assert!(v3 == arg0.active_target_weights_hash, 27);
        assert!(v20 >= v8, 4);
        assert!(v20 > 0, 28);
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&arg0.basket, v6)) {
            0x2::balance::join<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.basket, v6), v10);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.basket, v6, v10);
        };
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_rebalance_leg_finished(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_rebalance_leg_finished(0x2::object::uid_to_inner(&arg0.id), v1, v4, 0x1::type_name::into_string(v5), 0x1::type_name::into_string(v6), v7, v20, 0x2::clock::timestamp_ms(arg3)));
    }

    public fun is_locked<T0, T1>(arg0: &IndexVault<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.locked_until_ms
    }

    public fun last_marked_ms<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        arg0.last_marked_ms
    }

    public fun lock_for_rebalance<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_ticket_bound<T0, T1>(arg0, arg1);
        assert!(!is_locked<T0, T1>(arg0, arg2), 24);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + 3600000;
        arg0.locked_until_ms = v1;
        arg0.active_proposal_id = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_proposal_id(arg1);
        arg0.active_methodology_hash = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_methodology_hash(arg1);
        arg0.active_target_weights_hash = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_target_weights_hash(arg1);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_vault_locked(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_vault_locked(0x2::object::uid_to_inner(&arg0.id), v1, 0x2::tx_context::sender(arg3), v0));
    }

    public fun locked_until_ms<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        arg0.locked_until_ms
    }

    public fun mint_with_deposit<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_registry_bound<T0, T1>(arg0, arg1);
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg1), 1);
        assert!(!is_locked<T0, T1>(arg0, arg4), 8);
        assert_nav_fresh<T0, T1>(arg0, arg4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = fee_bps_safe(v0, (0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::mint_fee_bps(arg1) as u64));
        let v2 = v0 - v1;
        let v3 = mul_div(v2, 1000000, arg0.nav_micro);
        assert!(v3 > 0, 28);
        assert!(v3 >= arg3, 3);
        let v4 = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::tvl_cap_usd_micro(arg1);
        if (v4 > 0) {
            assert!(user_principal<T0, T1>(arg0) + v2 <= v4, 5);
        };
        0x2::coin::put<T0>(&mut arg0.deposit_balance, arg2);
        arg0.accrued_fees = arg0.accrued_fees + v1;
        assert_fee_backed<T0, T1>(arg0);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_minted(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_minted(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg5), v0, v1, v3, arg0.nav_micro, 0x2::clock::timestamp_ms(arg4)));
        0x2::coin::mint<T1>(&mut arg0.treasury, v3, arg5)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 11);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 9223372036854775808, 25);
        (v0 as u64)
    }

    public fun nav_micro<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        arg0.nav_micro
    }

    public(friend) fun peek_escrow(arg0: &LegEscrow) : (0x2::object::ID, u64, vector<u8>, vector<u8>, address, 0x1::type_name::TypeName, 0x1::type_name::TypeName, u64, u64, u64) {
        (arg0.vault_id, arg0.proposal_id, arg0.methodology_hash, arg0.target_weights_hash, arg0.router, arg0.input_type, arg0.output_type, arg0.amount_in, arg0.min_amount_out, arg0.notional_usd_micro)
    }

    public(friend) fun put_basket_balance<T0, T1, T2>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket, arg2: 0x2::balance::Balance<T2>) {
        assert_ticket_bound<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v0, arg2);
        };
    }

    public fun redeem_from_buffer<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_registry_bound<T0, T1>(arg0, arg1);
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg1), 1);
        assert!(!is_locked<T0, T1>(arg0, arg4), 8);
        assert_nav_fresh<T0, T1>(arg0, arg4);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = mul_div(v0, arg0.nav_micro, 1000000);
        let v2 = fee_bps_safe(v1, (0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::redeem_fee_bps(arg1) as u64));
        let v3 = v1 - v2;
        assert!(v3 > 0, 28);
        assert!(v3 >= arg3, 4);
        assert!(0x2::balance::value<T0>(&arg0.deposit_balance) >= v1, 12);
        0x2::coin::burn<T1>(&mut arg0.treasury, arg2);
        arg0.accrued_fees = arg0.accrued_fees + v2;
        assert_fee_backed<T0, T1>(arg0);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_redeemed(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_redeemed(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg5), v0, v3, v2, arg0.nav_micro, 0x2::clock::timestamp_ms(arg4)));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.deposit_balance, v3), arg5)
    }

    public fun registry_id<T0, T1>(arg0: &IndexVault<T0, T1>) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun seed_basket<T0, T1, T2>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock) {
        assert!(0x2::coin::total_supply<T1>(&arg0.treasury) == 0, 14);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.basket, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v0), 0x2::coin::into_balance<T2>(arg2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v0, 0x2::coin::into_balance<T2>(arg2));
        };
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_basket_seeded(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_basket_seeded(0x2::object::uid_to_inner(&arg0.id), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x2::coin::value<T2>(&arg2), 0x2::clock::timestamp_ms(arg3)));
    }

    public fun set_nav<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_registry_bound<T0, T1>(arg0, arg1);
        assert!(arg3 >= 10000 && arg3 <= 1000000000, 13);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (v0 > arg0.last_marked_ms) {
            v0 - arg0.last_marked_ms
        } else {
            0
        };
        let v2 = if (arg3 >= arg0.nav_micro) {
            arg3 - arg0.nav_micro
        } else {
            arg0.nav_micro - arg3
        };
        assert!(v2 <= compute_max_delta(arg0.nav_micro, v1), 22);
        arg0.nav_micro = arg3;
        arg0.last_marked_ms = v0;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_nav_updated(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_nav_updated(0x2::object::uid_to_inner(&arg0.id), arg3, v0));
    }

    public fun share<T0, T1>(arg0: IndexVault<T0, T1>) {
        0x2::transfer::share_object<IndexVault<T0, T1>>(arg0);
    }

    public fun start_rebalance_leg<T0, T1, T2, T3>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg2: &mut 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, LegEscrow) {
        assert_registry_bound<T0, T1>(arg0, arg1);
        assert!(!0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_paused(arg1), 1);
        assert_ticket_bound<T0, T1>(arg0, arg2);
        assert!(is_locked<T0, T1>(arg0, arg7), 8);
        assert_active_ticket<T0, T1>(arg0, arg2);
        assert!(arg4 > 0, 2);
        assert!(arg5 > 0, 28);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::policy::assert_router_allowed(arg1, arg3);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::policy::assert_notional_within_leg_cap(arg6, 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::max_notional_per_leg_usd_micro(arg1));
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::consume_next_planned_leg<T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x1::type_name::with_defining_ids<T3>();
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_rebalance_leg_started(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_rebalance_leg_started(0x2::object::uid_to_inner(&arg0.id), 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_proposal_id(arg2), arg3, 0x1::type_name::into_string(v0), 0x1::type_name::into_string(v1), arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7)));
        let v2 = LegEscrow{
            vault_id            : 0x2::object::id<IndexVault<T0, T1>>(arg0),
            proposal_id         : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_proposal_id(arg2),
            methodology_hash    : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_methodology_hash(arg2),
            target_weights_hash : 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::ticket_target_weights_hash(arg2),
            router              : arg3,
            input_type          : v0,
            output_type         : v1,
            amount_in           : arg4,
            min_amount_out      : arg5,
            notional_usd_micro  : arg6,
        };
        (0x2::coin::from_balance<T2>(0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, v0), arg4), arg8), v2)
    }

    public(friend) fun take_basket_balance<T0, T1, T2>(arg0: &mut IndexVault<T0, T1>, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::RebalanceTicket, arg2: u64) : 0x2::balance::Balance<T2> {
        assert_ticket_bound<T0, T1>(arg0, arg1);
        0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.basket, 0x1::type_name::with_defining_ids<T2>()), arg2)
    }

    public fun total_share_supply<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.treasury)
    }

    public fun unlock_after_settle<T0, T1>(arg0: &mut IndexVault<T0, T1>, arg1: 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::SettleReceipt, arg2: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, _, _) = 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::proposal::into_receipt_parts(arg1);
        assert!(v0 == 0x2::object::id<IndexVault<T0, T1>>(arg0), 20);
        assert!(v2 == arg0.active_proposal_id, 27);
        assert!(v1 == arg0.active_methodology_hash, 27);
        assert!(v3 == arg0.active_target_weights_hash, 27);
        assert!(arg0.locked_until_ms > 0, 23);
        arg0.locked_until_ms = 0;
        arg0.active_proposal_id = 0;
        arg0.active_methodology_hash = b"";
        arg0.active_target_weights_hash = b"";
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_vault_unlocked(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_vault_unlocked(0x2::object::uid_to_inner(&arg0.id), 0x2::clock::timestamp_ms(arg2)));
    }

    public fun user_principal<T0, T1>(arg0: &IndexVault<T0, T1>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.deposit_balance);
        assert!(v0 >= arg0.accrued_fees, 27);
        v0 - arg0.accrued_fees
    }

    // decompiled from Move bytecode v7
}

