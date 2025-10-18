module 0xd728f0c897bc69f947e91ac4dc0771b38a7e0fb55eeb433b01649b9f1a6bac51::vault {
    struct AccessList has key {
        id: 0x2::object::UID,
        allow: 0x2::vec_set::VecSet<address>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, 0x2::object::ID>,
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

    public fun acl_add(arg0: &mut AccessList, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.allow, arg2);
    }

    public fun acl_remove(arg0: &mut AccessList, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.allow, &arg2);
    }

    public fun bot_balance_borrow_mut<T0>(arg0: &AccessList, arg1: &mut BalanceManager, arg2: &0x2::tx_context::TxContext) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1001);
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.id, key<T0>())
    }

    public fun bot_deposit<T0>(arg0: &AccessList, arg1: &mut BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1001);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 1004);
        do_deposit<T0>(arg1, arg2);
    }

    public fun bot_withdraw<T0>(arg0: &AccessList, arg1: &mut BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.allow, &v0), 1001);
        do_withdraw<T0>(arg1, arg2, arg3)
    }

    public fun create_balance_manager(arg0: &mut Registry, arg1: &Version, arg2: &mut 0x2::tx_context::TxContext) : BalanceManager {
        assert!(arg1.version == 1, 1002);
        let v0 = BalanceManager{
            id    : 0x2::object::new(arg2),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.records, 0x2::tx_context::sender(arg2), 0x2::object::id<BalanceManager>(&v0));
        v0
    }

    fun do_deposit<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>) {
        let v0 = key<T0>();
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun do_withdraw<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = key<T0>();
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        let v2 = if (0x2::balance::value<T0>(v1) == arg1) {
            0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
        } else {
            0x2::balance::split<T0>(v1, arg1)
        };
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AccessList{
            id    : 0x2::object::new(arg0),
            allow : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AccessList>(v1);
        let v2 = Registry{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v2);
        let v3 = Version{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Version>(v3);
    }

    fun key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun query<T0>(arg0: &mut BalanceManager) : u64 {
        let v0 = key<T0>();
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun share_balance_manager(arg0: BalanceManager) {
        0x2::transfer::share_object<BalanceManager>(arg0);
    }

    public fun update_version(arg0: &mut Version) {
        arg0.version = 1;
    }

    public fun user_deposit<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &Version, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 1002);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1003);
        do_deposit<T0>(arg0, arg1);
    }

    public fun user_withdraw<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2.version == 1, 1002);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1003);
        do_withdraw<T0>(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

