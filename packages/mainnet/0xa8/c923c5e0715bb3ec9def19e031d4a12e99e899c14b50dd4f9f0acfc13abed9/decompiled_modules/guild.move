module 0xa8c923c5e0715bb3ec9def19e031d4a12e99e899c14b50dd4f9f0acfc13abed9::guild {
    struct GUILD has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Logs has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    struct NewUserEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce_type: 0x2::table::Table<u8, u128>,
        total_mission_reward: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct FeePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CreateFeePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct FeePoolWithdrawEvent has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct CollectFeeEvent has copy, drop {
        sender: address,
        action: u8,
        pool_id: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CreateRewardPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct RewardPoolDepositEvent has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct RewardPoolWithdrawEvent has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        type: u8,
        token_type: 0x1::type_name::TypeName,
        owner: address,
        rw_id: u128,
        pool_id: address,
        amount: u64,
        nonce: u128,
    }

    public fun claim_reward<T0>(arg0: &Config, arg1: &mut UserArchive, arg2: &mut RewardPool<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 6005);
        assert!(!arg0.paused, 6004);
        verify_signature(arg3, arg4, &arg0.validator);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::bcs::new(arg4);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = 0x2::bcs::peel_address(&mut v1);
        let v4 = 0x2::bcs::peel_address(&mut v1);
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == v3, 6000);
        assert!(0x2::clock::timestamp_ms(arg5) < 0x2::bcs::peel_u64(&mut v1), 6003);
        assert!(0x2::object::id_address<RewardPool<T0>>(arg2) == v4, 6002);
        assert!(v5 > 0, 6001);
        let v6 = update_user_nonce(arg1, v2, 0x2::bcs::peel_u128(&mut v1));
        assert!(0x2::balance::value<T0>(&arg2.balance) >= v5, 6001);
        update_user_reward<T0>(arg1, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v5), arg6), v3);
        let v7 = RewardClaimedEvent{
            type       : v2,
            token_type : 0x1::type_name::get<T0>(),
            owner      : v0,
            rw_id      : 0x2::bcs::peel_u128(&mut v1),
            pool_id    : v4,
            amount     : v5,
            nonce      : v6,
        };
        0x2::event::emit<RewardClaimedEvent>(v7);
    }

    public fun collect_fee<T0>(arg0: &Config, arg1: &mut FeePool<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 6005);
        assert!(!arg0.paused, 6004);
        verify_signature(arg2, arg3, &arg0.validator);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::bcs::new(arg3);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        assert!(v0 == 0x2::bcs::peel_address(&mut v1), 6012);
        assert!(0x2::object::id_address<FeePool<T0>>(arg1) == 0x2::bcs::peel_address(&mut v1), 6002);
        assert!(v2 > 0 && 0x2::coin::value<T0>(&arg4) == v2, 6001);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg4));
        let v3 = CollectFeeEvent{
            sender     : v0,
            action     : 0x2::bcs::peel_u8(&mut v1),
            pool_id    : 0x2::object::id<FeePool<T0>>(arg1),
            amount     : v2,
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CollectFeeEvent>(v3);
    }

    public fun create_fee_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeePool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<FeePool<T0>>(v0);
        let v1 = CreateFeePoolEvent{
            pool_id    : 0x2::object::id<FeePool<T0>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreateFeePoolEvent>(v1);
    }

    public fun create_reward_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
        let v1 = CreateRewardPoolEvent{
            pool_id    : 0x2::object::id<RewardPool<T0>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreateRewardPoolEvent>(v1);
    }

    public fun deposit_reward<T0>(arg0: &TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut RewardPool<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = RewardPoolDepositEvent{
            owner      : 0x2::tx_context::sender(arg3),
            pool_id    : 0x2::object::id<RewardPool<T0>>(arg2),
            amount     : 0x2::coin::value<T0>(&arg1),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RewardPoolDepositEvent>(v0);
    }

    fun init(arg0: GUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v2, v0);
        let v3 = Config{
            id        : 0x2::object::new(arg1),
            version   : 1,
            paused    : false,
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<Config>(v3);
        let v4 = Logs{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Logs>(v4);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg1.version < arg2, 6011);
        arg1.version = arg2;
    }

    public fun new_user(arg0: &mut Logs, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 6005);
        assert!(!arg1.paused, 6004);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 6006);
        let v1 = UserArchive{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            nonce_type           : 0x2::table::new<u8, u128>(arg2),
            total_mission_reward : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
        };
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        let v2 = NewUserEvent{
            archive_id : 0x2::object::id<UserArchive>(&v1),
            owner      : v0,
        };
        0x2::event::emit<NewUserEvent>(v2);
        0x2::transfer::public_transfer<UserArchive>(v1, v0);
    }

    public fun paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 6005);
        arg1.paused = arg2;
    }

    fun update_user_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 6007);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    fun update_user_reward<T0>(arg0: &mut UserArchive, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.total_mission_reward, v0)) {
            0
        } else {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.total_mission_reward, v0)
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.total_mission_reward, v0, v1 + arg1);
    }

    public fun update_validator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut Config) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 6010);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 6009);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 6008);
    }

    public fun withdraw_fee<T0>(arg0: &TreasureCap, arg1: &mut FeePool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 6001);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = FeePoolWithdrawEvent{
            owner   : v0,
            pool_id : 0x2::object::id<FeePool<T0>>(arg1),
            amount  : v1,
        };
        0x2::event::emit<FeePoolWithdrawEvent>(v2);
    }

    public fun withdraw_reward<T0>(arg0: &TreasureCap, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 6001);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = RewardPoolWithdrawEvent{
            owner   : v0,
            pool_id : 0x2::object::id<RewardPool<T0>>(arg1),
            amount  : v1,
        };
        0x2::event::emit<RewardPoolWithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

