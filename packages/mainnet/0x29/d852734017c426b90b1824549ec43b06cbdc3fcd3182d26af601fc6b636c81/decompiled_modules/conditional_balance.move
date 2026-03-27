module 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::conditional_balance {
    struct BalanceUnwrapped has copy, drop {
        balance_id: 0x2::object::ID,
        outcome_idx: u8,
        is_asset: bool,
        amount: u64,
    }

    struct BalanceWrapped has copy, drop {
        balance_id: 0x2::object::ID,
        outcome_idx: u8,
        is_asset: bool,
        amount: u64,
    }

    struct ConditionalMarketBalance<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome_count: u8,
        version: u8,
        balances: vector<u64>,
    }

    public fun destroy_empty<T0, T1>(arg0: ConditionalMarketBalance<T0, T1>) {
        let ConditionalMarketBalance {
            id            : v0,
            market_id     : _,
            outcome_count : _,
            version       : _,
            balances      : v4,
        } = arg0;
        let v5 = v4;
        assert!(is_empty_vector(&v5), 2);
        0x2::object::delete(v0);
    }

    public fun new<T0, T1>(arg0: 0x2::object::ID, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : ConditionalMarketBalance<T0, T1> {
        assert!(arg1 >= (0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::min_outcomes() as u8), 4);
        assert!(arg1 <= 200, 5);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < (arg1 as u64) * 2) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        ConditionalMarketBalance<T0, T1>{
            id            : 0x2::object::new(arg2),
            market_id     : arg0,
            outcome_count : arg1,
            version       : 1,
            balances      : v0,
        }
    }

    public fun add_to_balance<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool, arg3: u64, arg4: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::escrow_mutation_auth::EscrowMutationAuth) {
        add_to_balance_pkg<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun add_to_balance_pkg<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool, arg3: u64) {
        assert!((arg1 as u64) < (arg0.outcome_count as u64), 0);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.balances, calculate_index(arg1, arg2));
        assert!(*v0 <= 18446744073709551615 - arg3, 9);
        *v0 = *v0 + arg3;
    }

    public fun borrow_balances<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>) : &vector<u64> {
        &arg0.balances
    }

    public fun burn_complete_set_and_withdraw_from_balance<T0, T1>(arg0: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: &mut ConditionalMarketBalance<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg0), 8);
        assert!((arg1.outcome_count as u64) == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0), 4);
        let v0 = arg1.outcome_count;
        let v1 = get_balance<T0, T1>(arg1, 0, arg2);
        let v2 = 1;
        while (v2 < (v0 as u64)) {
            let v3 = get_balance<T0, T1>(arg1, (v2 as u8), arg2);
            if (v3 < v1) {
                v1 = v3;
            };
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return (0, 0x2::coin::zero<T0>(arg3), 0x2::coin::zero<T1>(arg3))
        };
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_outcome_escrowed_for_all<T0, T1>(arg0, arg2, v1);
        v2 = 0;
        while (v2 < (v0 as u64)) {
            sub_from_balance_pkg<T0, T1>(arg1, (v2 as u8), arg2, v1);
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_wrapped_balance_pkg<T0, T1>(arg0, v2, arg2, v1);
            v2 = v2 + 1;
        };
        let (v4, v5) = if (arg2) {
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_user_backing_pkg<T0, T1>(arg0, v1, true);
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
            (0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::withdraw_asset_balance_pkg<T0, T1>(arg0, v1, arg3), 0x2::coin::zero<T1>(arg3))
        } else {
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_user_backing_pkg<T0, T1>(arg0, v1, false);
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
            (0x2::coin::zero<T0>(arg3), 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::withdraw_stable_balance_pkg<T0, T1>(arg0, v1, arg3))
        };
        (v1, v4, v5)
    }

    fun calculate_index(arg0: u8, arg1: bool) : u64 {
        let v0 = if (arg1) {
            0
        } else {
            1
        };
        (arg0 as u64) * 2 + v0
    }

    public fun find_min_balance<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>, arg1: bool) : u64 {
        let v0 = get_balance<T0, T1>(arg0, 0, arg1);
        let v1 = 1;
        while ((v1 as u64) < (arg0.outcome_count as u64)) {
            let v2 = get_balance<T0, T1>(arg0, v1, arg1);
            if (v2 < v0) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_balance<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool) : u64 {
        assert!((arg1 as u64) < (arg0.outcome_count as u64), 0);
        *0x1::vector::borrow<u64>(&arg0.balances, calculate_index(arg1, arg2))
    }

    public fun id<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_empty<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>) : bool {
        is_empty_vector(&arg0.balances)
    }

    fun is_empty_vector(arg0: &vector<u64>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun market_id<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun merge<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: ConditionalMarketBalance<T0, T1>) {
        assert!(arg0.market_id == arg1.market_id, 6);
        assert!(arg0.outcome_count == arg1.outcome_count, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1.balances)) {
            let v1 = *0x1::vector::borrow<u64>(&arg1.balances, v0);
            if (v1 > 0) {
                let v2 = *0x1::vector::borrow<u64>(&arg0.balances, v0);
                assert!(v2 <= 18446744073709551615 - v1, 9);
                *0x1::vector::borrow_mut<u64>(&mut arg0.balances, v0) = v2 + v1;
            };
            v0 = v0 + 1;
        };
        let ConditionalMarketBalance {
            id            : v3,
            market_id     : _,
            outcome_count : _,
            version       : _,
            balances      : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    public fun outcome_count<T0, T1>(arg0: &ConditionalMarketBalance<T0, T1>) : u8 {
        arg0.outcome_count
    }

    public fun recombine_balance_to_asset<T0, T1>(arg0: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: &mut ConditionalMarketBalance<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 1);
        assert!(arg1.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg0), 8);
        assert!((arg1.outcome_count as u64) == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0), 4);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_outcome_escrowed_for_all<T0, T1>(arg0, true, arg2);
        let v0 = 0;
        while (v0 < (arg1.outcome_count as u64)) {
            assert!(get_balance<T0, T1>(arg1, (v0 as u8), true) >= arg2, 3);
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_wrapped_balance_pkg<T0, T1>(arg0, v0, true, arg2);
            sub_from_balance_pkg<T0, T1>(arg1, (v0 as u8), true, arg2);
            v0 = v0 + 1;
        };
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_user_backing_pkg<T0, T1>(arg0, arg2, true);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::withdraw_asset_balance_pkg<T0, T1>(arg0, arg2, arg3)
    }

    public fun recombine_balance_to_stable<T0, T1>(arg0: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: &mut ConditionalMarketBalance<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 1);
        assert!(arg1.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg0), 8);
        assert!((arg1.outcome_count as u64) == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0), 4);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_outcome_escrowed_for_all<T0, T1>(arg0, false, arg2);
        let v0 = 0;
        while (v0 < (arg1.outcome_count as u64)) {
            assert!(get_balance<T0, T1>(arg1, (v0 as u8), false) >= arg2, 3);
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_wrapped_balance_pkg<T0, T1>(arg0, v0, false, arg2);
            sub_from_balance_pkg<T0, T1>(arg1, (v0 as u8), false, arg2);
            v0 = v0 + 1;
        };
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_user_backing_pkg<T0, T1>(arg0, arg2, false);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::withdraw_stable_balance_pkg<T0, T1>(arg0, arg2, arg3)
    }

    public(friend) fun set_balance<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool, arg3: u64) {
        assert!((arg1 as u64) < (arg0.outcome_count as u64), 0);
        *0x1::vector::borrow_mut<u64>(&mut arg0.balances, calculate_index(arg1, arg2)) = arg3;
    }

    public fun split_asset_to_balance<T0, T1>(arg0: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: &mut ConditionalMarketBalance<T0, T1>, arg2: 0x2::coin::Coin<T0>) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg1.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg0), 8);
        assert!((arg1.outcome_count as u64) == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0), 4);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::deposit_spot_asset_for_balance<T0, T1>(arg0, arg2);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::increment_outcome_escrowed_for_all<T0, T1>(arg0, true, v0);
        let v1 = 0;
        while (v1 < (arg1.outcome_count as u64)) {
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::increment_wrapped_balance_pkg<T0, T1>(arg0, v1, true, v0);
            add_to_balance_pkg<T0, T1>(arg1, (v1 as u8), true, v0);
            v1 = v1 + 1;
        };
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        v0
    }

    public fun split_stable_to_balance<T0, T1>(arg0: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg1: &mut ConditionalMarketBalance<T0, T1>, arg2: 0x2::coin::Coin<T1>) : u64 {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 1);
        assert!(arg1.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg0), 8);
        assert!((arg1.outcome_count as u64) == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg0), 4);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::deposit_spot_stable_for_balance<T0, T1>(arg0, arg2);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::increment_outcome_escrowed_for_all<T0, T1>(arg0, false, v0);
        let v1 = 0;
        while (v1 < (arg1.outcome_count as u64)) {
            0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::increment_wrapped_balance_pkg<T0, T1>(arg0, v1, false, v0);
            add_to_balance_pkg<T0, T1>(arg1, (v1 as u8), false, v0);
            v1 = v1 + 1;
        };
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::assert_quantum_invariant<T0, T1>(arg0);
        v0
    }

    public fun sub_from_balance<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool, arg3: u64, arg4: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::escrow_mutation_auth::EscrowMutationAuth) {
        sub_from_balance_pkg<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun sub_from_balance_pkg<T0, T1>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: u8, arg2: bool, arg3: u64) {
        assert!((arg1 as u64) < (arg0.outcome_count as u64), 0);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.balances, calculate_index(arg1, arg2));
        assert!(*v0 >= arg3, 3);
        *v0 = *v0 - arg3;
    }

    public fun unwrap_to_coin<T0, T1, T2>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg2: u8, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg1), 6);
        assert!((arg2 as u64) < 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg1), 7);
        assert!(arg4 > 0, 1);
        assert!(get_balance<T0, T1>(arg0, arg2, arg3) >= arg4, 3);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::decrement_wrapped_balance_pkg<T0, T1>(arg1, (arg2 as u64), arg3, arg4);
        sub_from_balance_pkg<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = BalanceUnwrapped{
            balance_id  : id<T0, T1>(arg0),
            outcome_idx : arg2,
            is_asset    : arg3,
            amount      : arg4,
        };
        0x2::event::emit<BalanceUnwrapped>(v0);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::mint_conditional_pkg<T0, T1, T2>(arg1, (arg2 as u64), arg3, arg4, arg5)
    }

    public fun wrap_coin<T0, T1, T2>(arg0: &mut ConditionalMarketBalance<T0, T1>, arg1: &mut 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::TokenEscrow<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u8, arg4: bool) {
        assert!(arg0.market_id == 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::market_state_id<T0, T1>(arg1), 6);
        assert!((arg3 as u64) < 0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::caps_registered_count<T0, T1>(arg1), 7);
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 1);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::burn_conditional_pkg<T0, T1, T2>(arg1, (arg3 as u64), arg4, arg2);
        0x29d852734017c426b90b1824549ec43b06cbdc3fcd3182d26af601fc6b636c81::coin_escrow::increment_wrapped_balance_pkg<T0, T1>(arg1, (arg3 as u64), arg4, v0);
        add_to_balance_pkg<T0, T1>(arg0, arg3, arg4, v0);
        let v1 = BalanceWrapped{
            balance_id  : id<T0, T1>(arg0),
            outcome_idx : arg3,
            is_asset    : arg4,
            amount      : v0,
        };
        0x2::event::emit<BalanceWrapped>(v1);
    }

    // decompiled from Move bytecode v6
}

