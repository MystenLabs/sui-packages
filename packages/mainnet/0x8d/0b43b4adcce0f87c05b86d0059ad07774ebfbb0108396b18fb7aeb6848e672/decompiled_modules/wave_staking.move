module 0x8d0b43b4adcce0f87c05b86d0059ad07774ebfbb0108396b18fb7aeb6848e672::wave_staking {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u8,
        start_at: u64,
        end_at: u64,
        lock_duration: u64,
        total_staked_balance: 0x2::balance::Balance<T0>,
        apy: u32,
        operator_pk: vector<u8>,
        is_paused: bool,
    }

    struct UserInfo has store {
        stake_amount: u64,
        pending_reward: u64,
        lock_at: u64,
        apy: u32,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct Staked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct Withdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct RewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp_ms: u64,
    }

    fun cal_pending_reward(arg0: u64, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg5 != 0 && arg2 >= arg5) {
            return 0
        };
        let v0 = (arg5 as u256);
        let v1 = (0x2::math::min(arg2 + arg3, arg4) as u256);
        let v2 = v1;
        if (v0 != 0 && v1 > v0) {
            v2 = v0;
        };
        (((v2 - (arg2 as u256)) * (arg0 as u256) * (arg1 as u256) / 10000 / 31536000000) as u64)
    }

    public entry fun create_pool<T0>(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: u64, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v2 = Pool<T0>{
            id                   : v0,
            version              : 1,
            start_at             : arg1,
            end_at               : arg2,
            lock_duration        : arg3,
            total_staked_balance : 0x2::balance::zero<T0>(),
            apy                  : arg4,
            operator_pk          : 0x2::bcs::to_bytes<address>(&v1),
            is_paused            : false,
        };
        0x2::transfer::share_object<Pool<T0>>(v2);
        let v3 = PoolCreated{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<PoolCreated>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    public entry fun restake<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.end_at == 0 || arg0.end_at > v2, 7);
        assert!(v1.lock_at + arg0.lock_duration <= v2, 6);
        v1.lock_at = v2;
        v1.pending_reward = 0;
        v1.apy = arg0.apy;
        let v3 = RewardClaimed{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            user         : v0,
            amount       : v1.pending_reward + cal_pending_reward(v1.stake_amount, v1.apy, v1.lock_at, arg0.lock_duration, v2, arg0.end_at),
            timestamp_ms : v2,
        };
        0x2::event::emit<RewardClaimed>(v3);
    }

    public entry fun stake<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.end_at == 0 || arg0.end_at > v0, 7);
        assert!(arg0.start_at != 0 && arg0.start_at < v0, 2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::tx_context::sender(arg5);
        validate_signature<T0>(arg0, v2, v1, arg2, arg3, arg4);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v2)) {
            let v3 = UserInfo{
                stake_amount   : 0,
                pending_reward : 0,
                lock_at        : 0,
                apy            : arg0.apy,
            };
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v2, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v2);
        if (v4.stake_amount > 0) {
            v4.pending_reward = v4.pending_reward + cal_pending_reward(v4.stake_amount, v4.apy, v4.lock_at, arg0.lock_duration, v0, arg0.end_at);
        };
        v4.lock_at = v0;
        v4.stake_amount = v4.stake_amount + v1;
        v4.apy = arg0.apy;
        0x2::balance::join<T0>(&mut arg0.total_staked_balance, 0x2::coin::into_balance<T0>(arg1));
        let v5 = Staked{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            user         : v2,
            amount       : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Staked>(v5);
    }

    entry fun update_operator<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    public entry fun update_pool_info<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: bool) {
        arg1.start_at = arg2;
        arg1.end_at = arg3;
        arg1.lock_duration = arg4;
        arg1.is_paused = arg6;
        arg1.apy = arg5;
    }

    fun validate_signature<T0>(arg0: &Pool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_STAKING:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 10);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 11);
    }

    public entry fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = v2;
        if (arg0.end_at != 0 && arg0.end_at < v2) {
            v3 = arg0.end_at;
        };
        assert!(v1.lock_at + arg0.lock_duration <= v3, 6);
        assert!(arg1 > 0, 1);
        assert!(v1.stake_amount >= arg1, 3);
        let v4 = v1.pending_reward + cal_pending_reward(v1.stake_amount, v1.apy, v1.lock_at, arg0.lock_duration, v2, arg0.end_at);
        let v5 = 0x2::coin::zero<T0>(arg3);
        v1.stake_amount = v1.stake_amount - arg1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut v5), 0x2::balance::split<T0>(&mut arg0.total_staked_balance, arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v0);
        v1.pending_reward = 0;
        let v6 = 0x2::object::id<Pool<T0>>(arg0);
        let v7 = RewardClaimed{
            pool_id      : v6,
            user         : v0,
            amount       : v4,
            timestamp_ms : v2,
        };
        0x2::event::emit<RewardClaimed>(v7);
        let v8 = Withdrawn{
            pool_id      : v6,
            user         : v0,
            amount       : arg1,
            timestamp_ms : v2,
        };
        0x2::event::emit<Withdrawn>(v8);
    }

    // decompiled from Move bytecode v6
}

