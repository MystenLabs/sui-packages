module 0xe19a74728854cd996c7d26b8ced51ecbc2bb655ce33bb3976992b638fcb9dfe6::guild {
    struct GUILD has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        validator: 0x1::option::Option<vector<u8>>,
        change_name_gap: u64,
        fund_receiver: address,
    }

    struct GlobalVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
        vault_manager: VaultManager,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct VaultDepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct VaultWithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_balance: u64,
    }

    struct VaultManager has store {
        tokens: vector<TokenInfo>,
        last_update_time: u64,
    }

    struct TokenInfo has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct Paused has copy, drop, store {
        module_name: 0x1::string::String,
        paused: bool,
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
        last_updated_name: u64,
    }

    struct RewardClaimedEventV2 has copy, drop {
        token_type: 0x1::type_name::TypeName,
        owner: address,
        guild_id: u128,
        rw_id: u128,
        amount: u64,
        nonce: u128,
    }

    struct CreateGuildEvent has copy, drop {
        guild_id: u128,
        creator: address,
        nonce: u128,
    }

    struct RenameGuildEvent has copy, drop {
        guild_id: u128,
        guild_name: 0x1::string::String,
        changer: address,
        nonce: u128,
    }

    struct UpdateGuildEvent has copy, drop {
        guild_id: u128,
        updater: address,
        guild_level: u64,
        nonce: u128,
    }

    struct CommissionTimeRange has copy, drop, store {
        min_time: u64,
        max_time: u64,
    }

    struct SubscriptionEvent has copy, drop {
        subscriber: address,
        duration: u16,
        fee: u64,
        class: u8,
        nonce: u128,
    }

    struct Checkin has copy, drop, store {
        checkin_days: u64,
        last_checkin_time: u64,
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
        guild_id: u128,
        rw_id: u128,
        pool_id: address,
        amount: u64,
        nonce: u128,
    }

    public fun claim_reward<T0>(arg0: &Config, arg1: &mut UserArchive, arg2: &mut RewardPool<T0>, arg3: u128, arg4: u128, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun claim_reward_v2<T0>(arg0: &Config, arg1: &mut UserArchive, arg2: &mut GlobalVault, arg3: u128, arg4: u128, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun create_fee_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun create_guild<T0>(arg0: &Config, arg1: &mut FeePool<T0>, arg2: &mut UserArchive, arg3: u128, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun create_guild_v2<T0>(arg0: &Config, arg1: &mut GlobalVault, arg2: &mut UserArchive, arg3: u128, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun create_reward_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun deposit_fund_to_vault<T0>(arg0: &TreasureCap, arg1: &mut GlobalVault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        abort 6023
    }

    public fun deposit_reward<T0>(arg0: &TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut RewardPool<T0>, arg3: &0x2::tx_context::TxContext) {
        abort 6023
    }

    public(friend) fun deposit_to_vault<T0>(arg0: &mut GlobalVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        abort 6023
    }

    public fun get_checkin_fee(arg0: &Config) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"CHECKIN_FEE")) {
            return 0
        };
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"CHECKIN_FEE")
    }

    public fun get_fee_type(arg0: &Config, arg1: 0x1::string::String) : 0x1::type_name::TypeName {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"FEE_TYPE_KEY"), 6026);
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, 0x1::type_name::TypeName>>(&arg0.id, b"FEE_TYPE_KEY");
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::type_name::TypeName>(v0, &arg1), 6026);
        *0x2::vec_map::get<0x1::string::String, 0x1::type_name::TypeName>(v0, &arg1)
    }

    public fun get_max_check_in_days(arg0: &Config) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"MAX_CHECKIN_DAYS_KEY")) {
            return 0
        };
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"MAX_CHECKIN_DAYS_KEY")
    }

    public fun get_vault_balance<T0>(arg0: &GlobalVault) : u64 {
        abort 6023
    }

    fun init(arg0: GUILD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v2, v0);
        let v3 = Config{
            id              : 0x2::object::new(arg1),
            version         : 6,
            paused          : false,
            validator       : 0x1::option::none<vector<u8>>(),
            change_name_gap : 604800000,
            fund_receiver   : @0x8b994f6ec4a22c6f5fabe10f25822a0b33f7c1a4881dbf2f6d19dae55809baa,
        };
        0x2::transfer::share_object<Config>(v3);
        let v4 = Logs{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Logs>(v4);
    }

    public(friend) fun init_checkin(arg0: &mut UserArchive) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"CHECKIN_KEY")) {
            let v0 = Checkin{
                checkin_days      : 0,
                last_checkin_time : 0,
            };
            0x2::dynamic_field::add<vector<u8>, Checkin>(&mut arg0.id, b"CHECKIN_KEY", v0);
        };
    }

    public fun init_vault(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg1.version < arg2, 6011);
        arg1.version = arg2;
    }

    public fun new_user(arg0: &mut Logs, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        verify_config(arg1, 0x1::string::utf8(b"GUILD_MODULE"));
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 6006);
        let v1 = UserArchive{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            nonce_type           : 0x2::table::new<u8, u128>(arg2),
            total_mission_reward : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            last_updated_name    : 0,
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
        paused_v2(arg0, arg1, 0x1::string::utf8(b"GUILD_MODULE"), arg2);
    }

    public fun paused_v2(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: bool) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"PAUSED")) {
            let v0 = 0x2::vec_map::empty<0x1::string::String, Paused>();
            let v1 = Paused{
                module_name : arg2,
                paused      : arg3,
            };
            0x2::vec_map::insert<0x1::string::String, Paused>(&mut v0, arg2, v1);
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, Paused>>(&mut arg1.id, b"PAUSED", v0);
        } else {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, Paused>>(&mut arg1.id, b"PAUSED");
            if (0x2::vec_map::contains<0x1::string::String, Paused>(v2, &arg2)) {
                0x2::vec_map::get_mut<0x1::string::String, Paused>(v2, &arg2).paused = arg3;
            } else {
                let v3 = Paused{
                    module_name : arg2,
                    paused      : arg3,
                };
                0x2::vec_map::insert<0x1::string::String, Paused>(v2, arg2, v3);
            };
        };
    }

    public fun paused_with_key(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String, arg3: bool) {
        paused_v2(arg0, arg1, arg2, arg3);
    }

    public fun register(arg0: &mut Logs, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) : UserArchive {
        verify_config(arg1, 0x1::string::utf8(b"GUILD_MODULE"));
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 6006);
        let v1 = UserArchive{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            nonce_type           : 0x2::table::new<u8, u128>(arg2),
            total_mission_reward : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            last_updated_name    : 0,
        };
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        let v2 = NewUserEvent{
            archive_id : 0x2::object::id<UserArchive>(&v1),
            owner      : v0,
        };
        0x2::event::emit<NewUserEvent>(v2);
        v1
    }

    public fun rename_guild<T0>(arg0: &Config, arg1: &mut FeePool<T0>, arg2: &mut UserArchive, arg3: u128, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun rename_guild_v2<T0>(arg0: &Config, arg1: &mut GlobalVault, arg2: &mut UserArchive, arg3: u128, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public(friend) fun set_archive_change_name_time(arg0: &mut UserArchive, arg1: &Config, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_updated_name + arg1.change_name_gap, 6018);
        arg0.last_updated_name = v0;
    }

    public(friend) fun set_archive_last_name_time(arg0: &mut UserArchive, arg1: u64) {
        arg0.last_updated_name = arg1;
    }

    public(friend) fun set_checkin(arg0: &Config, arg1: &mut UserArchive, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = start_of_day(v0);
        let v2 = get_max_check_in_days(arg0);
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, Checkin>(&mut arg1.id, b"CHECKIN_KEY");
        assert!(v2 > 0, 6025);
        assert!(v3.last_checkin_time < v1, 6024);
        let v4 = if (v1 - v3.last_checkin_time > 86400000 || v3.checkin_days + 1 > v2) {
            1
        } else {
            v3.checkin_days + 1
        };
        v3.checkin_days = v4;
        v3.last_checkin_time = v0;
        (v3.checkin_days, v3.last_checkin_time)
    }

    public(friend) fun set_checkin_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"CHECKIN_FEE")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"CHECKIN_FEE", arg2);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"CHECKIN_FEE") = arg2;
        };
    }

    public fun set_fee_type<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"FEE_TYPE_KEY")) {
            let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::type_name::TypeName>();
            0x2::vec_map::insert<0x1::string::String, 0x1::type_name::TypeName>(&mut v0, arg2, 0x1::type_name::get<T0>());
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, 0x1::type_name::TypeName>>(&mut arg1.id, b"FEE_TYPE_KEY", v0);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, 0x1::type_name::TypeName>>(&mut arg1.id, b"FEE_TYPE_KEY");
            if (0x2::vec_map::contains<0x1::string::String, 0x1::type_name::TypeName>(v1, &arg2)) {
                *0x2::vec_map::get_mut<0x1::string::String, 0x1::type_name::TypeName>(v1, &arg2) = 0x1::type_name::get<T0>();
            } else {
                0x2::vec_map::insert<0x1::string::String, 0x1::type_name::TypeName>(v1, arg2, 0x1::type_name::get<T0>());
            };
        };
    }

    public fun set_fund_receiver(arg0: &TreasureCap, arg1: address, arg2: &mut Config) {
        arg2.fund_receiver = arg1;
    }

    public(friend) fun set_max_check_in_days(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"MAX_CHECKIN_DAYS_KEY")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, b"MAX_CHECKIN_DAYS_KEY", arg2);
        } else {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, b"MAX_CHECKIN_DAYS_KEY") = arg2;
        };
    }

    fun start_of_day(arg0: u64) : u64 {
        arg0 / 86400000 * 86400000
    }

    public(friend) fun update_claim_commission_time_range(arg0: &mut UserArchive, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64) {
        assert!(arg4 >= arg3, 6020);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v0 = 0x2::vec_map::empty<u8, CommissionTimeRange>();
            let v1 = CommissionTimeRange{
                min_time : arg3,
                max_time : arg4,
            };
            0x2::vec_map::insert<u8, CommissionTimeRange>(&mut v0, arg2, v1);
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<u8, CommissionTimeRange>>(&mut arg0.id, arg1, v0);
        } else {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<u8, CommissionTimeRange>>(&mut arg0.id, arg1);
            if (0x2::vec_map::contains<u8, CommissionTimeRange>(v2, &arg2)) {
                let v3 = 0x2::vec_map::get_mut<u8, CommissionTimeRange>(v2, &arg2);
                assert!(arg3 > v3.max_time, 6021);
                v3.min_time = arg3;
                v3.max_time = arg4;
            } else {
                let v4 = CommissionTimeRange{
                    min_time : arg3,
                    max_time : arg4,
                };
                0x2::vec_map::insert<u8, CommissionTimeRange>(v2, arg2, v4);
            };
        };
    }

    public fun update_guild<T0>(arg0: &Config, arg1: &mut FeePool<T0>, arg2: &mut UserArchive, arg3: u128, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun update_guild_v2<T0>(arg0: &Config, arg1: &mut GlobalVault, arg2: &mut UserArchive, arg3: u128, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public(friend) fun update_task_time_range(arg0: &mut UserArchive, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(arg4 >= arg3, 6020);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v0 = 0x2::vec_map::empty<vector<u8>, CommissionTimeRange>();
            let v1 = CommissionTimeRange{
                min_time : arg3,
                max_time : arg4,
            };
            0x2::vec_map::insert<vector<u8>, CommissionTimeRange>(&mut v0, arg2, v1);
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<vector<u8>, CommissionTimeRange>>(&mut arg0.id, arg1, v0);
        } else {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<vector<u8>, CommissionTimeRange>>(&mut arg0.id, arg1);
            if (0x2::vec_map::contains<vector<u8>, CommissionTimeRange>(v2, &arg2)) {
                let v3 = 0x2::vec_map::get_mut<vector<u8>, CommissionTimeRange>(v2, &arg2);
                assert!(arg3 > v3.max_time, 6021);
                v3.min_time = arg3;
                v3.max_time = arg4;
            } else {
                let v4 = CommissionTimeRange{
                    min_time : arg3,
                    max_time : arg4,
                };
                0x2::vec_map::insert<vector<u8>, CommissionTimeRange>(v2, arg2, v4);
            };
        };
    }

    public fun update_time_change_gap(arg0: &AdminCap, arg1: u64, arg2: &mut Config) {
        assert!(arg1 >= 0, 6001);
        arg2.change_name_gap = arg1;
    }

    public(friend) fun update_time_range(arg0: &mut UserArchive, arg1: u64, arg2: u64) {
        abort 6023
    }

    public(friend) fun update_time_range_with_key(arg0: &mut UserArchive, arg1: vector<u8>, arg2: u64, arg3: u64) {
        abort 6023
    }

    public(friend) fun update_user_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 6007);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public(friend) fun update_user_reward<T0>(arg0: &mut UserArchive, arg1: u64) {
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

    fun update_vault_manager(arg0: &mut GlobalVault, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        abort 6023
    }

    public fun validate_archive_owner(arg0: &UserArchive, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 6017);
    }

    public fun verify_config(arg0: &Config, arg1: 0x1::string::String) {
        assert!(arg0.version <= 6, 6005);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"PAUSED"), 6004);
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::vec_map::VecMap<0x1::string::String, Paused>>(&arg0.id, b"PAUSED");
        assert!(0x2::vec_map::contains<0x1::string::String, Paused>(v0, &arg1), 6004);
        assert!(!0x2::vec_map::get<0x1::string::String, Paused>(v0, &arg1).paused, 6004);
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 6009);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 6008);
    }

    public(friend) fun verify_signature_v2(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>) {
        if (0x1::option::is_none<vector<u8>>(&arg0.validator)) {
            abort 6009
        };
        assert!(0x2::ed25519::ed25519_verify(&arg1, 0x1::option::borrow<vector<u8>>(&arg0.validator), &arg2), 6008);
    }

    public fun withdraw_all_from_vault<T0>(arg0: &TreasureCap, arg1: &Config, arg2: &mut GlobalVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun withdraw_amount_from_vault<T0>(arg0: &TreasureCap, arg1: &Config, arg2: &mut GlobalVault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public fun withdraw_fee<T0>(arg0: &TreasureCap, arg1: &Config, arg2: &mut FeePool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    public(friend) fun withdraw_from_vault<T0>(arg0: &mut GlobalVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 6023
    }

    public fun withdraw_reward<T0>(arg0: &TreasureCap, arg1: &Config, arg2: &mut RewardPool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 6023
    }

    // decompiled from Move bytecode v6
}

