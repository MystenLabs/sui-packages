module 0x8d0b43b4adcce0f87c05b86d0059ad07774ebfbb0108396b18fb7aeb6848e672::wave_staking_nft {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u8,
        start_at: u64,
        end_at: u64,
        total_staked_nft: u64,
        lock_duration: u64,
        operator_pk: vector<u8>,
        is_paused: bool,
    }

    struct UserInfo has store {
        number_nft_staked: u64,
        nft_ids: vector<0x2::object::ID>,
        lock_at: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct NftStaked has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        user: address,
        timestamp_ms: u64,
    }

    struct NftWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        user: address,
        timestamp_ms: u64,
    }

    struct RewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        number_nft_staked: u64,
        reward_from: u64,
        reward_to: u64,
        timestamp_ms: u64,
    }

    public entry fun create_pool<T0>(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v2 = Pool<T0>{
            id               : v0,
            version          : 1,
            start_at         : arg1,
            end_at           : arg2,
            total_staked_nft : 0,
            lock_duration    : arg3,
            operator_pk      : 0x2::bcs::to_bytes<address>(&v1),
            is_paused        : false,
        };
        0x2::transfer::share_object<Pool<T0>>(v2);
        let v3 = PoolCreated{pool_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<PoolCreated>(v3);
    }

    fun get_reward_to(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 != 0 && arg0 >= arg3) {
            return arg0
        };
        let v0 = 0x2::math::min(arg0 + arg1, arg2);
        let v1 = v0;
        if (arg3 != 0 && v0 > arg3) {
            v1 = arg3;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    public entry fun restake<T0: store + key>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        assert!(arg0.end_at == 0 || arg0.end_at > v1, 7);
        assert!(v2.lock_at + arg0.lock_duration <= v1, 6);
        assert!(v2.number_nft_staked > 0, 12);
        let v3 = v2.lock_at;
        v2.lock_at = v1;
        let v4 = RewardClaimed{
            pool_id           : 0x2::object::id<Pool<T0>>(arg0),
            user              : v0,
            number_nft_staked : v2.number_nft_staked,
            reward_from       : v3,
            reward_to         : get_reward_to(v3, arg0.lock_duration, v1, arg0.end_at),
            timestamp_ms      : v1,
        };
        0x2::event::emit<RewardClaimed>(v4);
    }

    public entry fun stake<T0: store + key>(arg0: &mut Pool<T0>, arg1: T0, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.end_at == 0 || arg0.end_at > v0, 7);
        let v1 = 0x2::object::id<Pool<T0>>(arg0);
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = 0x2::tx_context::sender(arg5);
        validate_signature<T0>(arg0, v3, v2, arg2, arg3, arg4);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v3)) {
            let v4 = UserInfo{
                number_nft_staked : 0,
                nft_ids           : 0x1::vector::empty<0x2::object::ID>(),
                lock_at           : 0,
            };
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v3, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v3);
        if (v5.number_nft_staked > 0) {
            let v6 = RewardClaimed{
                pool_id           : v1,
                user              : v3,
                number_nft_staked : v5.number_nft_staked,
                reward_from       : v5.lock_at,
                reward_to         : get_reward_to(v5.lock_at, arg0.lock_duration, v0, arg0.end_at),
                timestamp_ms      : v0,
            };
            0x2::event::emit<RewardClaimed>(v6);
        };
        v5.lock_at = v0;
        arg0.total_staked_nft = arg0.total_staked_nft + 1;
        v5.number_nft_staked = v5.number_nft_staked + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut v5.nft_ids, v2);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, arg1);
        let v7 = NftStaked{
            pool_id      : v1,
            nft_id       : v2,
            user         : v3,
            timestamp_ms : v0,
        };
        0x2::event::emit<NftStaked>(v7);
    }

    entry fun update_operator<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    public entry fun update_pool_info<T0>(arg0: &OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        arg1.start_at = arg2;
        arg1.end_at = arg3;
        arg1.lock_duration = arg4;
        arg1.is_paused = arg5;
    }

    fun validate_signature<T0>(arg0: &Pool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"WAVE_STAKING_NFT:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::object::id_to_bytes(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 10);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 11);
    }

    public entry fun withdraw<T0: store + key>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 5);
        assert!(!arg0.is_paused, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0), 4);
        let v1 = 0x2::object::id<Pool<T0>>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        assert!(v3.number_nft_staked > 0, 12);
        let v4 = v2;
        if (arg0.end_at != 0 && arg0.end_at < v2) {
            v4 = arg0.end_at;
        };
        assert!(v3.lock_at + arg0.lock_duration <= v4, 6);
        let v5 = 0x1::vector::length<0x2::object::ID>(&v3.nft_ids);
        arg0.total_staked_nft = arg0.total_staked_nft - v5;
        let v6 = v3.nft_ids;
        v3.number_nft_staked = 0;
        v3.nft_ids = 0x1::vector::empty<0x2::object::ID>();
        let v7 = RewardClaimed{
            pool_id           : v1,
            user              : v0,
            number_nft_staked : v5,
            reward_from       : v3.lock_at,
            reward_to         : get_reward_to(v3.lock_at, arg0.lock_duration, v2, arg0.end_at),
            timestamp_ms      : v2,
        };
        0x2::event::emit<RewardClaimed>(v7);
        while (v5 > 0) {
            let v8 = 0x1::vector::pop_back<0x2::object::ID>(&mut v6);
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v8), v0);
            v5 = v5 - 1;
            let v9 = NftWithdrawn{
                pool_id      : v1,
                nft_id       : v8,
                user         : v0,
                timestamp_ms : v2,
            };
            0x2::event::emit<NftWithdrawn>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

