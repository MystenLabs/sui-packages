module 0xef38fcf9879c868cb7e38a16ae485a4625cec4fa6f56b9db1b38dceb6ec6f987::doghouse {
    struct AddTreats has copy, drop {
        account: address,
        amount: u64,
        memo: 0x1::ascii::String,
        income: 0x1::option::Option<u64>,
    }

    struct SubTreats has copy, drop {
        account: address,
        amount: u64,
        memo: 0x1::ascii::String,
    }

    struct Withdraw<phantom T0> has copy, drop {
        amount: u64,
        memo: 0x1::ascii::String,
    }

    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct DOGHOUSE has drop {
        dummy_field: bool,
    }

    struct DogHouse has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<address, u64>,
        managers: 0x2::vec_set::VecSet<address>,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &DogHouse) : &0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            err_invalid_coin_type();
        };
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)
    }

    public fun table(arg0: &DogHouse) : &0x2::table::Table<address, u64> {
        &arg0.table
    }

    public fun add_manager(arg0: &mut DogHouse, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun add_treats(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x1::option::Option<u64>) {
        if (!0x2::table::contains<address, u64>(table(arg0), arg1)) {
            0x2::table::add<address, u64>(&mut arg0.table, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1);
        *v0 = *v0 + arg2;
        let v1 = AddTreats{
            account : arg1,
            amount  : arg2,
            memo    : arg3,
            income  : arg4,
        };
        0x2::event::emit<AddTreats>(v1);
    }

    public fun add_treats_by_manager(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        add_treats(arg0, arg1, arg2, arg3, 0x1::option::none<u64>());
    }

    public fun add_treats_by_witness<T0: drop>(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: T0) {
        assert_valid_package_version(arg0);
        assert_is_valid_witness<T0>(arg0);
        add_treats(arg0, arg1, arg2, arg3, 0x1::option::none<u64>());
    }

    public fun add_version(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun add_witness<T0: drop>(arg0: &mut DogHouse, arg1: &AdminCap) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::get<T0>());
    }

    fun assert_is_valid_witness<T0: drop>(arg0: &DogHouse) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            err_invalid_witness();
        };
    }

    fun assert_sender_is_manager(arg0: &DogHouse, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version(arg0: &DogHouse) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(versions(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    fun balance_mut<T0>(arg0: &mut DogHouse) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            err_invalid_coin_type();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun deposit<T0>(arg0: &mut DogHouse, arg1: 0x2::coin::Coin<T0>) {
        assert_valid_package_version(arg0);
        let v0 = Deposit<T0>{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<Deposit<T0>>(v0);
        0x2::coin::put<T0>(balance_mut<T0>(arg0), arg1);
    }

    fun err_invalid_coin_type() {
        abort 3
    }

    fun err_invalid_package_version() {
        abort 4
    }

    fun err_invalid_witness() {
        abort 1
    }

    fun err_sender_is_not_manager() {
        abort 0
    }

    fun err_treats_not_enough() {
        abort 2
    }

    public fun get_treats<T0>(arg0: &mut DogHouse, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        assert_valid_package_version(arg0);
        let v0 = price_of<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            err_invalid_coin_type();
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        add_treats(arg0, arg2, v1 / 0x1::option::destroy_some<u64>(v0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0x1::option::some<u64>(v1));
        0x2::coin::put<T0>(balance_mut<T0>(arg0), arg1);
    }

    fun init(arg0: DOGHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DOGHOUSE>(arg0, arg1);
        let v0 = DogHouse{
            id        : 0x2::object::new(arg1),
            table     : 0x2::table::new<address, u64>(arg1),
            managers  : 0x2::vec_set::empty<address>(),
            witnesses : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            prices    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            versions  : 0x2::vec_set::singleton<u64>(package_version()),
        };
        0x2::transfer::share_object<DogHouse>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun managers(arg0: &DogHouse) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun package_version() : u64 {
        1
    }

    public fun price_of<T0>(arg0: &DogHouse) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::try_get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
    }

    public fun prices(arg0: &DogHouse) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.prices
    }

    public fun remove_manager(arg0: &mut DogHouse, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_price<T0>(arg0: &mut DogHouse, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.prices, &v0);
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2)
    }

    public fun remove_version(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun remove_witness<T0: drop>(arg0: &mut DogHouse, arg1: &AdminCap) {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.witnesses, &v0);
    }

    public fun set_price<T0>(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64) {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(prices(arg0), &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.prices, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.prices, v0, arg2);
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
    }

    fun sub_treats(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = treats(arg0, arg1);
        if (v0 == 0 || v0 < arg2) {
            err_treats_not_enough();
        };
        *0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1) = v0 - arg2;
        let v1 = SubTreats{
            account : arg1,
            amount  : arg2,
            memo    : arg3,
        };
        0x2::event::emit<SubTreats>(v1);
    }

    public fun sub_treats_by_manager(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        sub_treats(arg0, arg1, arg2, arg3);
    }

    public fun sub_treats_by_witness<T0: drop>(arg0: &mut DogHouse, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: T0) {
        assert_valid_package_version(arg0);
        assert_is_valid_witness<T0>(arg0);
        sub_treats(arg0, arg1, arg2, arg3);
    }

    public fun treats(arg0: &DogHouse, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(table(arg0), arg1)) {
            *0x2::table::borrow<address, u64>(table(arg0), arg1)
        } else {
            0
        }
    }

    public fun versions(arg0: &DogHouse) : &0x2::vec_set::VecSet<u64> {
        &arg0.versions
    }

    public fun withdraw_by_manager<T0>(arg0: &mut DogHouse, arg1: u64, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg3);
        let v0 = Withdraw<T0>{
            amount : arg1,
            memo   : arg2,
        };
        0x2::event::emit<Withdraw<T0>>(v0);
        0x2::coin::take<T0>(balance_mut<T0>(arg0), arg1, arg3)
    }

    public fun withdraw_by_witness<T0, T1: drop>(arg0: &mut DogHouse, arg1: u64, arg2: 0x1::ascii::String, arg3: T1) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        assert_is_valid_witness<T1>(arg0);
        let v0 = Withdraw<T0>{
            amount : arg1,
            memo   : arg2,
        };
        0x2::event::emit<Withdraw<T0>>(v0);
        0x2::balance::split<T0>(balance_mut<T0>(arg0), arg1)
    }

    public fun witnesses(arg0: &DogHouse) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v6
}

