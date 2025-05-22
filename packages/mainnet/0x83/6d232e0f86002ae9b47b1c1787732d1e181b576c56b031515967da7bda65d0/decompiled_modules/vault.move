module 0x836d232e0f86002ae9b47b1c1787732d1e181b576c56b031515967da7bda65d0::vault {
    struct UserDepositEvent has copy, drop {
        user: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct UserWithdrawEvent has copy, drop {
        user: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct AccessList has key {
        id: 0x2::object::UID,
        allow: 0x2::vec_set::VecSet<address>,
    }

    struct Record has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct BalanceManager has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun acl_add(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.allow, arg2);
    }

    public fun acl_remove(arg0: &AdminCap, arg1: &mut AccessList, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.allow, &arg2);
    }

    public fun bot_deposit<T0>(arg0: &AccessList, arg1: &mut BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1001);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 13906835020451938303);
        deposit_non_entry<T0>(arg1, arg2);
    }

    public fun bot_withdraw<T0>(arg0: &AccessList, arg1: &mut BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1001);
        withdraw_non_entry<T0>(arg1, arg2, arg3)
    }

    fun check_sr(arg0: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward) {
        assert!(0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::sr_amount(arg0) >= 1000, 13906835213725466623);
        assert!(0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::sr_name(arg0) == 0x1::ascii::string(b"TradingFlow"), 13906835218020433919);
    }

    public fun create_balance_manager(arg0: &mut Record, arg1: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg2: &Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BalanceManager>(create_balance_manager_non_entry(arg0, arg1, arg2, arg3));
    }

    public fun create_balance_manager_non_entry(arg0: &mut Record, arg1: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg2: &Version, arg3: &mut 0x2::tx_context::TxContext) : BalanceManager {
        assert!(arg2.version == 1, 1002);
        check_sr(arg1);
        let v0 = BalanceManager{
            id    : 0x2::object::new(arg3),
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.record, 0x2::tx_context::sender(arg3), 0x2::object::id<BalanceManager>(&v0));
        v0
    }

    fun deposit_non_entry<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AccessList{
            id    : 0x2::object::new(arg0),
            allow : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AccessList>(v1);
        let v2 = Record{
            id     : 0x2::object::new(arg0),
            record : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Record>(v2);
        let v3 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v3);
    }

    public fun query<T0>(arg0: &mut BalanceManager) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun update_version(arg0: &mut Version) {
    }

    public fun user_deposit<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 1002);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13906834797113638911);
        check_sr(arg2);
        deposit_non_entry<T0>(arg0, arg1);
        let v0 = UserDepositEvent{
            user      : 0x2::tx_context::sender(arg4),
            coin_type : 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<UserDepositEvent>(v0);
    }

    public fun user_withdraw<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &0x918061f3cb2eb4cecbb19f57d84c74903bcf9479a17c9d944a7515ddf86cfbb5::suifund::SupporterReward, arg3: &Version, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 1002);
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 13906834887307952127);
        check_sr(arg2);
        let v0 = withdraw_non_entry<T0>(arg0, arg1, arg4);
        let v1 = UserWithdrawEvent{
            user      : 0x2::tx_context::sender(arg4),
            coin_type : 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()),
            amount    : arg1,
        };
        0x2::event::emit<UserWithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun withdraw_non_entry<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        let v2 = if (0x2::balance::value<T0>(v1) == arg1) {
            0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        };
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    // decompiled from Move bytecode v6
}

