module 0xbc22d062b7510c27577b8eb62cc915b97553c41396bf97be398f773c8ae2af0e::dark_pool {
    struct DarkPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vk_bytes: vector<u8>,
        commitments: 0x2::table::Table<vector<u8>, OrderCommitment>,
        nullifiers: 0x2::table::Table<vector<u8>, bool>,
        base_vault: 0x2::balance::Balance<T0>,
        quote_vault: 0x2::balance::Balance<T1>,
        config: PoolConfig,
    }

    struct OrderCommitment has drop, store {
        commitment: vector<u8>,
        nullifier: vector<u8>,
        owner: address,
        locked_amount: u64,
        is_buy: bool,
        created_at: u64,
        encrypted_data: vector<u8>,
    }

    struct PoolConfig has drop, store {
        min_order_size: u64,
        max_order_size: u64,
        pool_id: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MatcherCap has store, key {
        id: 0x2::object::UID,
    }

    struct OrderCommitted has copy, drop {
        pool_id: vector<u8>,
        commitment: vector<u8>,
        encrypted_data: vector<u8>,
        timestamp: u64,
    }

    struct OrderCancelled has copy, drop {
        pool_id: vector<u8>,
        commitment: vector<u8>,
        timestamp: u64,
    }

    struct OrderSettled has copy, drop {
        pool_id: vector<u8>,
        commitment_a: vector<u8>,
        commitment_b: vector<u8>,
        timestamp: u64,
    }

    struct SingleSettled has copy, drop {
        pool_id: vector<u8>,
        commitment: vector<u8>,
        timestamp: u64,
    }

    public fun cancel_order<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg1), 4);
        let v0 = 0x2::table::remove<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 5);
        if (v0.is_buy) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_vault, v0.locked_amount), arg2), v0.owner);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_vault, v0.locked_amount), arg2), v0.owner);
        };
        let v1 = OrderCancelled{
            pool_id    : arg0.config.pool_id,
            commitment : arg1,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OrderCancelled>(v1);
    }

    public fun create_pool<T0, T1>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (AdminCap, MatcherCap) {
        let v0 = PoolConfig{
            min_order_size : arg2,
            max_order_size : arg3,
            pool_id        : arg1,
        };
        let v1 = DarkPool<T0, T1>{
            id          : 0x2::object::new(arg4),
            vk_bytes    : arg0,
            commitments : 0x2::table::new<vector<u8>, OrderCommitment>(arg4),
            nullifiers  : 0x2::table::new<vector<u8>, bool>(arg4),
            base_vault  : 0x2::balance::zero<T0>(),
            quote_vault : 0x2::balance::zero<T1>(),
            config      : v0,
        };
        0x2::transfer::share_object<DarkPool<T0, T1>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg4)};
        let v3 = MatcherCap{id: 0x2::object::new(arg4)};
        (v2, v3)
    }

    fun distribute_coins<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 7);
        if (0x1::vector::is_empty<address>(&arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg5), arg2);
        } else {
            validate_splits(&arg3, &arg4);
            let v0 = 0x1::vector::length<address>(&arg3);
            let v1 = 0;
            let v2 = 0;
            while (v2 < v0 - 1) {
                let v3 = arg1 * *0x1::vector::borrow<u64>(&arg4, v2) / 100;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v3), arg5), *0x1::vector::borrow<address>(&arg3, v2));
                v1 = v1 + v3;
                v2 = v2 + 1;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1 - v1), arg5), *0x1::vector::borrow<address>(&arg3, v0 - 1));
        };
    }

    public fun get_order_exists<T0, T1>(arg0: &DarkPool<T0, T1>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg1)
    }

    public fun get_pool_id<T0, T1>(arg0: &DarkPool<T0, T1>) : vector<u8> {
        arg0.config.pool_id
    }

    public fun is_nullifier_used<T0, T1>(arg0: &DarkPool<T0, T1>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.nullifiers, arg1)
    }

    public fun settle_match<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: &MatcherCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<address>, arg7: vector<u64>, arg8: vector<address>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg2), 4);
        assert!(0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg3), 4);
        let v0 = 0x2::table::remove<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg2);
        let v1 = 0x2::table::remove<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg3);
        if (arg4 > 0) {
            if (v0.is_buy) {
                let v2 = &mut arg0.base_vault;
                distribute_coins<T0>(v2, arg4, v0.owner, arg6, arg7, arg10);
            } else {
                let v3 = &mut arg0.quote_vault;
                distribute_coins<T1>(v3, arg4, v0.owner, arg6, arg7, arg10);
            };
        };
        if (arg5 > 0) {
            if (v1.is_buy) {
                let v4 = &mut arg0.base_vault;
                distribute_coins<T0>(v4, arg5, v1.owner, arg8, arg9, arg10);
            } else {
                let v5 = &mut arg0.quote_vault;
                distribute_coins<T1>(v5, arg5, v1.owner, arg8, arg9, arg10);
            };
        };
        let v6 = OrderSettled{
            pool_id      : arg0.config.pool_id,
            commitment_a : arg2,
            commitment_b : arg3,
            timestamp    : 0x2::tx_context::epoch(arg10),
        };
        0x2::event::emit<OrderSettled>(v6);
    }

    public fun settle_single_base<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: &MatcherCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg2), 4);
        let v0 = 0x2::table::remove<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg2);
        assert!(!v0.is_buy, 5);
        assert!(0x2::balance::value<T0>(&arg0.base_vault) >= v0.locked_amount, 7);
        let v1 = SingleSettled{
            pool_id    : arg0.config.pool_id,
            commitment : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SingleSettled>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_vault, v0.locked_amount), arg3)
    }

    public fun settle_single_quote<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: &MatcherCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::table::contains<vector<u8>, OrderCommitment>(&arg0.commitments, arg2), 4);
        let v0 = 0x2::table::remove<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg2);
        assert!(v0.is_buy, 5);
        assert!(0x2::balance::value<T1>(&arg0.quote_vault) >= v0.locked_amount, 7);
        let v1 = SingleSettled{
            pool_id    : arg0.config.pool_id,
            commitment : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SingleSettled>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_vault, v0.locked_amount), arg3)
    }

    public fun split_and_distribute<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_splits(&arg1, &arg2);
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0 - 1) {
            let v3 = 0x2::coin::value<T0>(&arg0) * *0x1::vector::borrow<u64>(&arg2, v2) / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v3, arg3), *0x1::vector::borrow<address>(&arg1, v2));
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, *0x1::vector::borrow<address>(&arg1, v0 - 1));
    }

    public fun submit_buy_order<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_proof<T0, T1>(arg0, &arg2, &arg3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.nullifiers, arg5), 2);
        0x2::balance::join<T1>(&mut arg0.quote_vault, 0x2::coin::into_balance<T1>(arg1));
        let v0 = OrderCommitment{
            commitment     : arg4,
            nullifier      : arg5,
            owner          : 0x2::tx_context::sender(arg7),
            locked_amount  : 0x2::coin::value<T1>(&arg1),
            is_buy         : true,
            created_at     : 0x2::tx_context::epoch(arg7),
            encrypted_data : arg6,
        };
        0x2::table::add<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg4, v0);
        0x2::table::add<vector<u8>, bool>(&mut arg0.nullifiers, arg5, true);
        let v1 = OrderCommitted{
            pool_id        : arg0.config.pool_id,
            commitment     : arg4,
            encrypted_data : arg6,
            timestamp      : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<OrderCommitted>(v1);
    }

    public fun submit_sell_order<T0, T1>(arg0: &mut DarkPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_proof<T0, T1>(arg0, &arg2, &arg3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.nullifiers, arg5), 2);
        0x2::balance::join<T0>(&mut arg0.base_vault, 0x2::coin::into_balance<T0>(arg1));
        let v0 = OrderCommitment{
            commitment     : arg4,
            nullifier      : arg5,
            owner          : 0x2::tx_context::sender(arg7),
            locked_amount  : 0x2::coin::value<T0>(&arg1),
            is_buy         : false,
            created_at     : 0x2::tx_context::epoch(arg7),
            encrypted_data : arg6,
        };
        0x2::table::add<vector<u8>, OrderCommitment>(&mut arg0.commitments, arg4, v0);
        0x2::table::add<vector<u8>, bool>(&mut arg0.nullifiers, arg5, true);
        let v1 = OrderCommitted{
            pool_id        : arg0.config.pool_id,
            commitment     : arg4,
            encrypted_data : arg6,
            timestamp      : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<OrderCommitted>(v1);
    }

    fun validate_splits(arg0: &vector<address>, arg1: &vector<u64>) {
        let v0 = 0x1::vector::length<address>(arg0);
        assert!(v0 > 0, 9);
        assert!(v0 == 0x1::vector::length<u64>(arg1), 10);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v2);
            assert!(v3 > 0, 9);
            v1 = v1 + v3;
            v2 = v2 + 1;
        };
        assert!(v1 == 100, 9);
    }

    fun verify_proof<T0, T1>(arg0: &DarkPool<T0, T1>, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg0.vk_bytes);
        let v2 = 0x2::groth16::proof_points_from_bytes(*arg1);
        let v3 = 0x2::groth16::public_proof_inputs_from_bytes(*arg2);
        let v4 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v4, &v1, &v3, &v2), 0);
    }

    // decompiled from Move bytecode v6
}

