module 0xb228a8d60b6515015a791cb775cffe1ca34b79e7cafd92678a83f4ed3588bc84::staking {
    struct Stake has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        owner: address,
        pool_amount: u64,
        total_nft_staked: u16,
        item_type: 0x1::type_name::TypeName,
        period: u8,
    }

    struct CreateStakeCap has key {
        id: 0x2::object::UID,
    }

    struct StakeItem<T0: store + key> has store, key {
        id: 0x2::object::UID,
        item: T0,
        start_time: u64,
        end_time: u64,
        creator: address,
    }

    struct StakeItemEvent has copy, drop {
        item_id: 0x2::object::ID,
        staker: address,
    }

    struct ClaimItemEvent has copy, drop {
        item_id: 0x2::object::ID,
        claimer: address,
    }

    struct CreateStakeEvent has copy, drop {
        start_time: u64,
        end_time: u64,
        pool_amount: u64,
        coin_type: 0x1::ascii::String,
        period: u8,
        item_type: 0x1::type_name::TypeName,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public entry fun add_liquidity_pool<T0>(arg0: &mut CreateStakeCap, arg1: &mut Stake, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg1.id, b"pool_coin"), 0x2::coin::split<T0>(arg2, arg3, arg4));
    }

    public entry fun claim_nft<T0: store + key, T1: drop>(arg0: &mut Stake, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1) == true, 103);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, StakeItem<T0>>(&arg0.id, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg3), 102);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.end_time, 104);
        let StakeItem {
            id         : v1,
            item       : v2,
            start_time : _,
            end_time   : _,
            creator    : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, StakeItem<T0>>(&mut arg0.id, arg1);
        let v6 = v2;
        let v7 = arg0.pool_amount / (arg0.total_nft_staked as u64);
        assert!(v7 > 0, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T1>>(&mut arg0.id, b"pool_coin"), v7, arg3), v5);
        let v8 = ClaimItemEvent{
            item_id : 0x2::object::id<T0>(&v6),
            claimer : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ClaimItemEvent>(v8);
        0x2::transfer::public_transfer<T0>(v6, v5);
        0x2::object::delete(v1);
    }

    public entry fun create_stake<T0: store + key, T1: drop>(arg0: &CreateStakeCap, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 + (arg4 as u64) * 86400 * 1000;
        let v1 = 0x1::type_name::get<T0>();
        let v2 = Stake{
            id               : 0x2::object::new(arg5),
            start_time       : arg3,
            end_time         : v0,
            owner            : 0x2::tx_context::sender(arg5),
            pool_amount      : arg2,
            total_nft_staked : 0,
            item_type        : v1,
            period           : arg4,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<T1>>(&mut v2.id, b"pool_coin", 0x2::coin::split<T1>(arg1, arg2, arg5));
        let v3 = CreateStakeEvent{
            start_time  : arg3,
            end_time    : v0,
            pool_amount : arg2,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            period      : arg4,
            item_type   : v1,
        };
        0x2::event::emit<CreateStakeEvent>(v3);
        0x2::transfer::share_object<Stake>(v2);
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateStakeCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreateStakeCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<STAKING>(arg0, arg1);
    }

    public entry fun stake_nft<T0: store + key>(arg0: &mut Stake, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &v0;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.end_time >= v2, 107);
        assert!(arg0.start_time <= v2, 107);
        assert!(v1 == &arg0.item_type, 106);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = 0x2::object::id<T0>(&arg1);
        let v5 = StakeItemEvent{
            item_id : v4,
            staker  : v3,
        };
        0x2::event::emit<StakeItemEvent>(v5);
        let v6 = StakeItem<T0>{
            id         : 0x2::object::new(arg3),
            item       : arg1,
            start_time : v2,
            end_time   : v2 + (arg0.period as u64) * 86400 * 1000,
            creator    : v3,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, StakeItem<T0>>(&mut arg0.id, v4, v6);
        arg0.total_nft_staked = arg0.total_nft_staked + 1;
    }

    public entry fun unlock_pool<T0: store + key, T1: drop>(arg0: &mut CreateStakeCap, arg1: &mut Stake, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg1.id, arg2) == true, 103);
        let StakeItem {
            id         : v0,
            item       : v1,
            start_time : _,
            end_time   : _,
            creator    : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, StakeItem<T0>>(&mut arg1.id, arg2);
        let v5 = v1;
        let v6 = arg1.pool_amount / (arg1.total_nft_staked as u64);
        assert!(v6 > 0, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<T1>>(&mut arg1.id, b"pool_coin"), v6, arg3), v4);
        let v7 = ClaimItemEvent{
            item_id : 0x2::object::id<T0>(&v5),
            claimer : v4,
        };
        0x2::event::emit<ClaimItemEvent>(v7);
        0x2::transfer::public_transfer<T0>(v5, v4);
        0x2::object::delete(v0);
    }

    public entry fun update_period_pool(arg0: &mut CreateStakeCap, arg1: &mut Stake, arg2: u8) {
        arg1.end_time = arg1.start_time + (arg2 as u64) * 86400 * 1000;
        arg1.period = arg2;
    }

    public entry fun update_timestamp_pool(arg0: &mut CreateStakeCap, arg1: &mut Stake, arg2: u64) {
        arg1.start_time = arg2;
        arg1.end_time = arg2 + (arg1.period as u64) * 86400 * 1000;
    }

    // decompiled from Move bytecode v6
}

