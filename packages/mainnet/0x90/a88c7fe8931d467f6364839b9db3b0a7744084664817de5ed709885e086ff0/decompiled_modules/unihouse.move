module 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse {
    struct UniHouse has key {
        id: 0x2::object::UID,
        version: u64,
        referral_table: 0x2::table::Table<address, address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64, arg3: u64, arg4: u64) {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::add_game_config<T0, T1>(borrow_house_mut<T0>(arg1), arg2, arg3, arg4);
    }

    public fun add_volume<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = referrer(arg1, v0);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::add_volume<T0, T1>(borrow_house_mut<T0>(arg1), v0, v1, arg2);
    }

    public fun claim_rebate<T0>(arg0: &mut UniHouse, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::claim_rebate<T0>(borrow_house_mut<T0>(arg0), arg1)
    }

    public fun join<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: 0x2::balance::Balance<T0>) {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_inflow<T0, T1>(0x2::balance::value<T0>(&arg2));
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::join<T0>(borrow_house_mut<T0>(arg1), arg2);
    }

    public entry fun remove_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse) {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::remove_game_config<T0, T1>(borrow_house_mut<T0>(arg1));
    }

    public fun split<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64) : 0x2::balance::Balance<T0> {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_outflow<T0, T1>(arg2);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::split<T0, T1>(borrow_house_mut<T0>(arg1), arg2)
    }

    public entry fun update_game_config<T0, T1: drop>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64, arg3: u64, arg4: u64) {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::update_game_config<T0, T1>(borrow_house_mut<T0>(arg1), arg2, arg3, arg4);
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64) : 0x2::balance::Balance<T0> {
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_withdraw<T0>(arg2);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::withdraw<T0>(borrow_house_mut<T0>(arg1), arg2)
    }

    public fun borrow_house<T0>(arg0: &UniHouse) : &0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::House<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::House<T0>>(&arg0.id, v0)
    }

    fun borrow_house_mut<T0>(arg0: &mut UniHouse) : &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::House<T0> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::House<T0>>(&mut arg0.id, v0)
    }

    public fun claim_rebate_to<T0>(arg0: &mut UniHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rebate<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 1);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_deposit<T0>(0x2::balance::value<T0>(&v1));
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::House<T0>>(&mut arg1.id, v0, 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::new<T0>(v1, arg3));
    }

    public entry fun deposit<T0>(arg0: &mut UniHouse, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_deposit<T0>(0x2::balance::value<T0>(&v0));
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::join<T0>(borrow_house_mut<T0>(arg0), v0);
    }

    public fun house_exists<T0>(arg0: &UniHouse) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = UniHouse{
            id             : 0x2::object::new(arg0),
            version        : 1,
            referral_table : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<UniHouse>(v1);
    }

    public fun put<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: 0x2::coin::Coin<T0>) {
        join<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun referrer(arg0: &UniHouse, arg1: address) : 0x1::option::Option<address> {
        let v0 = &arg0.referral_table;
        if (0x2::table::contains<address, address>(v0, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(v0, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun set_referrer(arg0: &mut UniHouse, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.referral_table;
        if (0x2::table::contains<address, address>(v1, v0)) {
            return
        };
        0x2::table::add<address, address>(v1, v0, arg1);
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::events::emit_set_referrer(v0, arg1);
    }

    public entry fun set_version(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64) {
        arg1.version = arg2;
    }

    public fun take<T0, T1: drop>(arg0: T1, arg1: &mut UniHouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(split<T0, T1>(arg0, arg1, arg2), arg3)
    }

    public fun version(arg0: &UniHouse) : u64 {
        arg0.version
    }

    public entry fun withdraw_to<T0>(arg0: &AdminCap, arg1: &mut UniHouse, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw<T0>(arg0, arg1, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

