module 0xbd9471cc17c55d6f0dca91345340a203f568f6c9ae12f020a85f46d62895939d::mission {
    struct MISSION has drop {
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

    struct GuestLog has store, key {
        id: 0x2::object::UID,
        guests: 0x2::table::Table<address, bool>,
    }

    struct GuestArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce_type: 0x2::table::Table<u8, u128>,
        total_mission_reward: u64,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct GuestEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
    }

    struct CreatePoolRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct PoolDepositEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        amount: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        type: u8,
        owner: address,
        rw_id: u128,
        pool_id: address,
        amount: u64,
        nonce: u128,
    }

    struct DepositEvent has copy, drop {
        user: address,
        task_slug: 0x1::string::String,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public fun claim_reward<T0>(arg0: &Config, arg1: &mut GuestArchive, arg2: &mut RewardPool<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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
        let v6 = update_guest_nonce(arg1, v2, 0x2::bcs::peel_u128(&mut v1));
        assert!(0x2::balance::value<T0>(&arg2.balance) >= v5, 6001);
        arg1.total_mission_reward = arg1.total_mission_reward + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v5), arg6), v3);
        let v7 = RewardClaimedEvent{
            type    : v2,
            owner   : v0,
            rw_id   : 0x2::bcs::peel_u128(&mut v1),
            pool_id : v4,
            amount  : v5,
            nonce   : v6,
        };
        0x2::event::emit<RewardClaimedEvent>(v7);
    }

    public fun create_reward_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
        let v1 = CreatePoolRewardEvent{
            pool_id    : 0x2::object::id<RewardPool<T0>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreatePoolRewardEvent>(v1);
    }

    public fun deposit<T0>(arg0: &Config, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 6005);
        assert!(!arg0.paused, 6004);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 6001);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        let v2 = DepositEvent{
            user      : v0,
            task_slug : 0x1::string::utf8(arg1),
            amount    : v1,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun deposit_reward<T0>(arg0: &TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut RewardPool<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolDepositEvent{
            owner      : 0x2::tx_context::sender(arg3),
            pool       : 0x2::object::id<RewardPool<T0>>(arg2),
            amount     : 0x2::coin::value<T0>(&arg1),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PoolDepositEvent>(v0);
    }

    public fun emergency_reward_withdraw<T0>(arg0: &TreasureCap, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 6001);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = EmergencyWithdrawEvent{
            owner  : v0,
            pool   : 0x2::object::id<RewardPool<T0>>(arg1),
            amount : v1,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v2);
    }

    public fun guest(arg0: &mut GuestLog, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 6005);
        assert!(!arg1.paused, 6004);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.guests, v0), 6006);
        let v1 = GuestArchive{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            nonce_type           : 0x2::table::new<u8, u128>(arg2),
            total_mission_reward : 0,
        };
        0x2::table::add<address, bool>(&mut arg0.guests, v0, true);
        let v2 = GuestEvent{
            archive_id : 0x2::object::id<GuestArchive>(&v1),
            owner      : v0,
        };
        0x2::event::emit<GuestEvent>(v2);
        0x2::transfer::public_transfer<GuestArchive>(v1, v0);
    }

    fun init(arg0: MISSION, arg1: &mut 0x2::tx_context::TxContext) {
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
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg1.version < arg2, 6011);
        arg1.version = arg2;
    }

    public fun paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 6005);
        arg1.paused = arg2;
    }

    fun update_guest_nonce(arg0: &mut GuestArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 6007);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public fun update_validator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut Config) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 6010);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 6009);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 6008);
    }

    // decompiled from Move bytecode v6
}

