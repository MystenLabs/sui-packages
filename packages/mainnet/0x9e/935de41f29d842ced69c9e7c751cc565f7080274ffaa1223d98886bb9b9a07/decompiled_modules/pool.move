module 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool {
    struct CommitmentInserted has copy, drop {
        commitment: vector<u8>,
        leaf_index: u64,
        pool_id: address,
    }

    struct RootEntry has copy, drop, store {
        root: vector<u8>,
        timestamp: u64,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        authority: address,
        fee_collector: address,
        relayer: address,
        balance: 0x2::balance::Balance<T0>,
        pvk: 0x2::groth16::PreparedVerifyingKey,
        root_history: vector<RootEntry>,
        root_history_index: u64,
        nullifiers: 0x2::table::Table<vector<u8>, u64>,
        next_leaf_index: u64,
        total_deposited: u64,
        total_withdrawn: u64,
        is_paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public fun transfer<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 11);
        assert!(0x2::tx_context::sender(arg10) == arg0.relayer, 7);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 10);
        let v0 = *0x1::vector::borrow<vector<u8>>(&arg4, 0);
        assert!(is_known_root<T0>(arg0, &v0), 2);
        0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::validate_public_inputs(&arg4, &v0, &arg5, arg8, 0x2::tx_context::sender(arg10), arg6, arg7, 0x2::object::uid_to_address(&arg0.id));
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::verify_groth16_proof(&arg0.pvk, arg1, arg2, arg3, arg4), 1);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.nullifiers, arg5), 6);
        0x2::table::add<vector<u8>, u64>(&mut arg0.nullifiers, arg5, 0x2::clock::timestamp_ms(arg9));
        let v1 = arg7 * 15 / 10000;
        assert!(arg7 >= v1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg7 - v1), arg10), arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg10), arg0.fee_collector);
        if (arg6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg6), arg10), 0x2::tx_context::sender(arg10));
        };
        arg0.total_withdrawn = arg0.total_withdrawn + arg7 + arg6;
    }

    fun add_root<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = arg0.root_history_index;
        let v1 = 0x1::vector::borrow_mut<RootEntry>(&mut arg0.root_history, v0);
        v1.root = arg1;
        v1.timestamp = 0x2::clock::timestamp_ms(arg2);
        arg0.root_history_index = (v0 + 1) % 50;
    }

    public fun authority<T0>(arg0: &Pool<T0>) : address {
        arg0.authority
    }

    public fun balance_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 11);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 9);
        assert!(arg0.next_leaf_index < 1048576, 12);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = CommitmentInserted{
            commitment : arg2,
            leaf_index : arg0.next_leaf_index,
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<CommitmentInserted>(v1);
        arg0.next_leaf_index = arg0.next_leaf_index + 1;
        arg0.total_deposited = arg0.total_deposited + v0;
        add_root<T0>(arg0, arg3, arg4);
    }

    public fun fee_collector<T0>(arg0: &Pool<T0>) : address {
        arg0.fee_collector
    }

    public fun initialize<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifying_key::bytes();
        let v1 = 0x2::groth16::bn254();
        let v2 = 0x1::vector::empty<RootEntry>();
        let v3 = 0;
        while (v3 < 50) {
            let v4 = RootEntry{
                root      : 0x1::vector::empty<u8>(),
                timestamp : 0,
            };
            0x1::vector::push_back<RootEntry>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = 0x2::object::new(arg2);
        let v6 = Pool<T0>{
            id                 : v5,
            authority          : 0x2::tx_context::sender(arg2),
            fee_collector      : arg0,
            relayer            : arg1,
            balance            : 0x2::balance::zero<T0>(),
            pvk                : 0x2::groth16::prepare_verifying_key(&v1, &v0),
            root_history       : v2,
            root_history_index : 0,
            nullifiers         : 0x2::table::new<vector<u8>, u64>(arg2),
            next_leaf_index    : 0,
            total_deposited    : 0,
            total_withdrawn    : 0,
            is_paused          : false,
        };
        let v7 = AdminCap{
            id      : 0x2::object::new(arg2),
            pool_id : 0x2::object::uid_to_inner(&v5),
        };
        0x2::transfer::share_object<Pool<T0>>(v6);
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg2));
    }

    fun is_known_root<T0>(arg0: &Pool<T0>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 50) {
            let v1 = 0x1::vector::borrow<RootEntry>(&arg0.root_history, v0);
            if (&v1.root == arg1 && v1.timestamp != 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.is_paused
    }

    public fun is_spent<T0>(arg0: &Pool<T0>, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.nullifiers, *arg1)
    }

    public fun next_leaf_index<T0>(arg0: &Pool<T0>) : u64 {
        arg0.next_leaf_index
    }

    public fun pause<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>) {
        arg1.is_paused = true;
    }

    public fun relayer<T0>(arg0: &Pool<T0>) : address {
        arg0.relayer
    }

    public fun root_in_history<T0>(arg0: &Pool<T0>, arg1: &vector<u8>) : bool {
        is_known_root<T0>(arg0, arg1)
    }

    public fun set_fee_collector<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public fun set_relayer<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address) {
        arg1.relayer = arg2;
    }

    public fun total_deposited<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_withdrawn<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_withdrawn
    }

    public fun unpause<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>) {
        arg1.is_paused = false;
    }

    public fun update_root<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 11);
        assert!(0x2::tx_context::sender(arg3) == arg0.relayer, 7);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 9);
        add_root<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

