module 0xc4e710ac5f0b04521d24d44a15756fd9b8c0c637dde64867d32934fd1c547ab6::rewards {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        admin: address,
        protocol_fee: u64,
        creation_fee: u64,
        protocol_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct RewardsPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        merkle_root: vector<u8>,
        claimed_amounts: 0x2::table::Table<address, u64>,
        total_claimed: u128,
        admin: address,
        paused: bool,
        claim_fee: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct REWARDS has drop {
        dummy_field: bool,
    }

    struct ProtocolInitialized has copy, drop {
        admin: address,
        protocol_fee: u64,
        creation_fee: u64,
        timestamp: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        initial_balance: u64,
        merkle_root: vector<u8>,
        claim_fee: u64,
        creation_fee_paid: u64,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        claimer: address,
        pool_id: 0x2::object::ID,
        amount_claimed: u64,
        total_claimed_by_user: u64,
        pool_fee_paid: u64,
        protocol_fee_paid: u64,
        remaining_balance: u64,
        timestamp: u64,
    }

    struct MerkleRootUpdated has copy, drop {
        old_root: vector<u8>,
        new_root: vector<u8>,
        timestamp: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct PoolPaused has copy, drop {
        timestamp: u64,
    }

    struct PoolUnpaused has copy, drop {
        timestamp: u64,
    }

    struct ClaimFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    struct ProtocolFeesCollected has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    struct ProtocolFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        timestamp: u64,
    }

    struct CreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        timestamp: u64,
    }

    public fun claim<T0>(arg0: &mut ProtocolConfig, arg1: &mut RewardsPool<T0>, arg2: u64, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg1.paused, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg1.claim_fee + arg0.protocol_fee, 9);
        assert!(arg2 > 0, 3);
        assert!(verify_proof(arg1.merkle_root, v0, arg2, arg3), 0);
        let v1 = get_claimed_amount<T0>(arg1, v0);
        assert!(arg2 > v1, 4);
        let v2 = arg2 - v1;
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v2, 1);
        let v3 = arg1.total_claimed + (v2 as u128);
        assert!(v3 <= 340282366920938463463374607431768211455, 6);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee_balance, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, arg0.protocol_fee));
        if (0x2::table::contains<address, u64>(&arg1.claimed_amounts, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.claimed_amounts, v0) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg1.claimed_amounts, v0, arg2);
        };
        arg1.total_claimed = v3;
        let v5 = RewardClaimed{
            claimer               : v0,
            pool_id               : 0x2::object::id<RewardsPool<T0>>(arg1),
            amount_claimed        : v2,
            total_claimed_by_user : arg2,
            pool_fee_paid         : arg1.claim_fee,
            protocol_fee_paid     : arg0.protocol_fee,
            remaining_balance     : 0x2::balance::value<T0>(&arg1.balance) - v2,
            timestamp             : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<RewardClaimed>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v2), arg5)
    }

    public fun collect_fees<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        assert!(v0 > 0, 5);
        let v1 = FeesCollected{
            admin     : 0x2::tx_context::sender(arg2),
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<FeesCollected>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee_balance), arg2)
    }

    public fun collect_protocol_fees(arg0: &mut ProtocolConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 10);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_balance);
        assert!(v0 > 0, 5);
        let v1 = ProtocolFeesCollected{
            admin     : 0x2::tx_context::sender(arg1),
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<ProtocolFeesCollected>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol_balance), arg1)
    }

    fun compare_hashes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    fun create_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    public fun create_pool<T0>(arg0: &mut ProtocolConfig, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.creation_fee, 11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = RewardsPool<T0>{
            id              : v1,
            balance         : 0x2::coin::into_balance<T0>(arg1),
            merkle_root     : arg2,
            claimed_amounts : 0x2::table::new<address, u64>(arg4),
            total_claimed   : 0,
            admin           : v3,
            paused          : false,
            claim_fee       : 50000000,
            fee_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v5 = PoolCreated{
            pool_id           : v2,
            creator           : v3,
            initial_balance   : 0x2::coin::value<T0>(&arg1),
            merkle_root       : arg2,
            claim_fee         : 50000000,
            creation_fee_paid : v0,
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<RewardsPool<T0>>(v4);
        AdminCap{
            id      : 0x2::object::new(arg4),
            pool_id : v2,
        }
    }

    public fun deposit_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 5);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = RewardsDeposited{
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<RewardsDeposited>(v1);
    }

    public fun get_accumulated_fees<T0>(arg0: &RewardsPool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun get_claim_fee<T0>(arg0: &RewardsPool<T0>) : u64 {
        arg0.claim_fee
    }

    public fun get_claim_fees<T0>(arg0: &ProtocolConfig, arg1: &RewardsPool<T0>) : (u64, u64, u64) {
        (arg1.claim_fee, arg0.protocol_fee, arg1.claim_fee + arg0.protocol_fee)
    }

    public fun get_claimable_amount<T0>(arg0: &RewardsPool<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = get_claimed_amount<T0>(arg0, arg1);
        if (arg2 > v0) {
            arg2 - v0
        } else {
            0
        }
    }

    public fun get_claimed_amount<T0>(arg0: &RewardsPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed_amounts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed_amounts, arg1)
        } else {
            0
        }
    }

    public fun get_merkle_root<T0>(arg0: &RewardsPool<T0>) : vector<u8> {
        arg0.merkle_root
    }

    public fun get_pool_stats<T0>(arg0: &RewardsPool<T0>) : (u64, u128, vector<u8>, bool, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_claimed, arg0.merkle_root, arg0.paused, arg0.claim_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance))
    }

    public fun get_protocol_config(arg0: &ProtocolConfig) : (address, u64, u64, u64) {
        (arg0.admin, arg0.protocol_fee, arg0.creation_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_balance))
    }

    fun hash_pair(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: REWARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id               : 0x2::object::new(arg1),
            admin            : @0x1aa37f62ff54936597cc044c98aa6f01860968455f41be63ecce0dea7b439451,
            protocol_fee     : 50000000,
            creation_fee     : 10000000000,
            protocol_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = ProtocolInitialized{
            admin        : @0x1aa37f62ff54936597cc044c98aa6f01860968455f41be63ecce0dea7b439451,
            protocol_fee : 50000000,
            creation_fee : 10000000000,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<ProtocolInitialized>(v1);
        0x2::transfer::share_object<ProtocolConfig>(v0);
    }

    public fun pause<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.paused = true;
        let v0 = PoolPaused{timestamp: 0x2::tx_context::epoch_timestamp_ms(arg2)};
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun unpause<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.paused = false;
        let v0 = PoolUnpaused{timestamp: 0x2::tx_context::epoch_timestamp_ms(arg2)};
        0x2::event::emit<PoolUnpaused>(v0);
    }

    public fun update_claim_fee<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        arg0.claim_fee = arg2;
        let v0 = ClaimFeeUpdated{
            old_fee   : arg0.claim_fee,
            new_fee   : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimFeeUpdated>(v0);
    }

    public fun update_creation_fee(arg0: &mut ProtocolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 10);
        arg0.creation_fee = arg1;
        let v0 = CreationFeeUpdated{
            old_fee   : arg0.creation_fee,
            new_fee   : arg1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<CreationFeeUpdated>(v0);
    }

    public fun update_merkle_root<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(arg2 != arg0.merkle_root, 8);
        arg0.merkle_root = arg2;
        let v0 = MerkleRootUpdated{
            old_root  : arg0.merkle_root,
            new_root  : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MerkleRootUpdated>(v0);
    }

    public fun update_protocol_fee(arg0: &mut ProtocolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 10);
        arg0.protocol_fee = arg1;
        let v0 = ProtocolFeeUpdated{
            old_fee   : arg0.protocol_fee,
            new_fee   : arg1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ProtocolFeeUpdated>(v0);
    }

    fun verify_proof(arg0: vector<u8>, arg1: address, arg2: u64, arg3: vector<vector<u8>>) : bool {
        let v0 = create_leaf(arg1, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg3, v1);
            let v3 = if (compare_hashes(&v0, &v2)) {
                hash_pair(&v0, &v2)
            } else {
                hash_pair(&v2, &v0)
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    public fun withdraw_unclaimed<T0>(arg0: &mut RewardsPool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(arg2 > 0, 5);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

