module 0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::doghouse {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
        user: address,
        memo: 0x1::ascii::String,
    }

    struct Claim<phantom T0> has copy, drop {
        amount: u64,
        user: address,
    }

    struct Spend<phantom T0> has copy, drop {
        amount: u64,
        user: address,
        memo: 0x1::ascii::String,
    }

    struct BulkSpend<phantom T0> has copy, drop {
        spends: vector<Spend<T0>>,
    }

    struct DOGHOUSE has drop {
        dummy_field: bool,
    }

    struct CustodialPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        player_balances: 0x2::table::Table<address, u64>,
    }

    struct DogHouse has key {
        id: 0x2::object::UID,
        lifetime_points: 0x2::table::Table<address, u64>,
        treats_tc: 0x2::coin::TreasuryCap<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        reward_types: vector<0x1::type_name::TypeName>,
        managers: 0x2::vec_set::VecSet<address>,
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

    public fun burn(arg0: &mut DogHouse, arg1: 0x2::coin::Coin<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>) {
        0x2::coin::burn<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut arg0.treats_tc, arg1);
    }

    public fun mint(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS> {
        0x2::coin::mint<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut arg0.treats_tc, arg2, arg3)
    }

    public fun update_icon_url(arg0: &mut DogHouse, arg1: &AdminCap, arg2: &mut 0x2::coin::CoinMetadata<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>, arg3: 0x1::ascii::String) {
        0x2::coin::update_icon_url<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&arg0.treats_tc, arg2, arg3);
    }

    public fun add_manager(arg0: &mut DogHouse, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun admin_deposit_custodial_pool<T0>(arg0: &mut DogHouse, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>) {
        assert_valid_package_version(arg0);
        if (0x1::vector::length<address>(&arg2) != 0x1::vector::length<u64>(&arg3)) {
            err_address_len_mismatch();
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v0);
            v0 = v0 + 1;
        };
        if (v1 != 0x2::coin::value<T0>(&arg4)) {
            err_deposit_invalid();
        };
        let v2 = custodial_pool_mut<T0>(arg0, 0x1::type_name::get<T0>());
        0x2::coin::put<T0>(&mut v2.balance, arg4);
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v4 = 0x1::vector::pop_back<address>(&mut arg2);
            let v5 = Deposit<T0>{
                amount : v3,
                user   : v4,
                memo   : 0x1::string::to_ascii(0x1::string::utf8(b"reward")),
            };
            0x2::event::emit<Deposit<T0>>(v5);
            if (0x2::table::contains<address, u64>(&v2.player_balances, v4)) {
                let v6 = 0x2::table::borrow_mut<address, u64>(&mut v2.player_balances, v4);
                *v6 = *v6 + v3;
                continue
            };
            0x2::table::add<address, u64>(&mut v2.player_balances, v4, v3);
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

    public fun batch_spend_custodial_pool<T0>(arg0: &mut DogHouse, arg1: vector<address>, arg2: vector<u64>, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        if (0x1::vector::length<address>(&arg1) != 0x1::vector::length<u64>(&arg2)) {
            err_address_len_mismatch();
        };
        let v0 = 0x1::vector::empty<Spend<T0>>();
        let v1 = 0;
        let v2 = custodial_pool_mut<T0>(arg0, 0x1::type_name::get<T0>());
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v4 = 0x1::vector::pop_back<address>(&mut arg1);
            let v5 = Spend<T0>{
                amount : v3,
                user   : v4,
                memo   : arg3,
            };
            0x1::vector::push_back<Spend<T0>>(&mut v0, v5);
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut v2.player_balances, v4);
            *v6 = *v6 - v3;
            v1 = v3 + v1;
        };
        let v7 = BulkSpend<T0>{spends: v0};
        0x2::event::emit<BulkSpend<T0>>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2.balance, v1), arg4)
    }

    public fun buy_treats<T0>(arg0: &mut DogHouse, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS> {
        assert_valid_package_version(arg0);
        let v0 = price_of<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            err_invalid_coin_type();
        };
        let v1 = 0x2::coin::value<T0>(&arg1) / 0x1::option::destroy_some<u64>(v0);
        let v2 = Deposit<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>{
            amount : v1,
            user   : 0x2::tx_context::sender(arg2),
            memo   : 0x1::string::to_ascii(0x1::string::utf8(b"purchase")),
        };
        0x2::event::emit<Deposit<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>>(v2);
        let v3 = balance_mut<T0>(arg0);
        0x2::coin::put<T0>(v3, arg1);
        0x2::coin::mint<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut arg0.treats_tc, v1, arg2)
    }

    public fun buy_treats_for_account<T0>(arg0: &mut DogHouse, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        assert_valid_package_version(arg0);
        let v0 = price_of<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            err_invalid_coin_type();
        };
        let v1 = 0x2::coin::value<T0>(&arg1) / 0x1::option::destroy_some<u64>(v0);
        if (0x2::table::contains<address, u64>(&arg0.lifetime_points, arg2)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lifetime_points, arg2);
            *v2 = *v2 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.lifetime_points, arg2, v1);
        };
        let v3 = balance_mut<T0>(arg0);
        0x2::coin::put<T0>(v3, arg1);
        let v4 = 0x2::coin::mint_balance<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut arg0.treats_tc, v1);
        let v5 = custodial_pool_mut<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(arg0, 0x1::type_name::get<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>());
        let v6 = Deposit<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>{
            amount : v1,
            user   : arg2,
            memo   : 0x1::string::to_ascii(0x1::string::utf8(b"purchase")),
        };
        0x2::event::emit<Deposit<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>>(v6);
        if (0x2::table::contains<address, u64>(&v5.player_balances, arg2)) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut v5.player_balances, arg2);
            *v7 = *v7 + v1;
        } else {
            0x2::table::add<address, u64>(&mut v5.player_balances, arg2, v1);
        };
        0x2::balance::join<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut v5.balance, v4);
    }

    public fun claim<T0>(arg0: &mut DogHouse, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = custodial_pool_mut<T0>(arg0, 0x1::type_name::get<T0>());
        if (!0x2::table::contains<address, u64>(&v0.player_balances, 0x2::tx_context::sender(arg1))) {
            err_no_balance();
        };
        let v1 = 0x2::table::remove<address, u64>(&mut v0.player_balances, 0x2::tx_context::sender(arg1));
        let v2 = Claim<T0>{
            amount : v1,
            user   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Claim<T0>>(v2);
        0x2::coin::take<T0>(&mut v0.balance, v1, arg1)
    }

    public fun create_custodial_pool<T0>(arg0: &mut DogHouse, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, CustodialPool<T0>>(&arg0.id, v0)) {
            err_invalid_coin_type();
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
        let v1 = CustodialPool<T0>{
            id              : 0x2::object::new(arg2),
            balance         : 0x2::balance::zero<T0>(),
            player_balances : 0x2::table::new<address, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, CustodialPool<T0>>(&mut arg0.id, v0, v1);
    }

    public fun create_doghouse(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DogHouse{
            id              : 0x2::object::new(arg2),
            lifetime_points : 0x2::table::new<address, u64>(arg2),
            treats_tc       : arg1,
            prices          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            reward_types    : 0x1::vector::empty<0x1::type_name::TypeName>(),
            managers        : 0x2::vec_set::empty<address>(),
            versions        : 0x2::vec_set::singleton<u64>(package_version()),
        };
        let v1 = &mut v0;
        create_custodial_pool<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(v1, arg0, arg2);
        0x2::transfer::share_object<DogHouse>(v0);
    }

    public fun custodial_pool<T0>(arg0: &DogHouse, arg1: 0x1::type_name::TypeName) : &CustodialPool<T0> {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, CustodialPool<T0>>(&arg0.id, arg1)
    }

    fun custodial_pool_mut<T0>(arg0: &mut DogHouse, arg1: 0x1::type_name::TypeName) : &mut CustodialPool<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, CustodialPool<T0>>(&mut arg0.id, arg1)
    }

    public fun deposit_custodial_pool<T0>(arg0: &mut DogHouse, arg1: vector<address>, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>) {
        assert_valid_package_version(arg0);
        if (0x1::vector::length<address>(&arg1) != 0x1::vector::length<u64>(&arg2)) {
            err_address_len_mismatch();
        };
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v0);
            v0 = v0 + 1;
        };
        if (v1 != 0x2::coin::value<T0>(&arg3)) {
            err_deposit_invalid();
        };
        let v2 = custodial_pool_mut<T0>(arg0, 0x1::type_name::get<T0>());
        0x2::coin::put<T0>(&mut v2.balance, arg3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v4 = 0x1::vector::pop_back<address>(&mut arg1);
            let v5 = Deposit<T0>{
                amount : v3,
                user   : v4,
                memo   : 0x1::string::to_ascii(0x1::string::utf8(b"user_deposit")),
            };
            0x2::event::emit<Deposit<T0>>(v5);
            if (0x2::table::contains<address, u64>(&v2.player_balances, v4)) {
                let v6 = 0x2::table::borrow_mut<address, u64>(&mut v2.player_balances, v4);
                *v6 = *v6 + v3;
                continue
            };
            0x2::table::add<address, u64>(&mut v2.player_balances, v4, v3);
        };
    }

    fun err_address_len_mismatch() {
        abort 2
    }

    fun err_deposit_invalid() {
        abort 3
    }

    fun err_invalid_coin_type() {
        abort 0
    }

    fun err_invalid_package_version() {
        abort 1
    }

    fun err_no_balance() {
        abort 4
    }

    fun err_sender_is_not_manager() {
        abort 5
    }

    public fun get_users_balances<T0>(arg0: &DogHouse, arg1: 0x1::type_name::TypeName, arg2: vector<address>) : vector<u64> {
        let v0 = custodial_pool<T0>(arg0, arg1);
        let v1 = 0x1::vector::empty<u64>();
        while (!(0x1::vector::length<address>(&arg2) > 0)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, u64>(&v0.player_balances, v2)) {
                0x1::vector::push_back<u64>(&mut v1, *0x2::table::borrow<address, u64>(&v0.player_balances, v2));
                continue
            };
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        v1
    }

    fun init(arg0: DOGHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DOGHOUSE>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun lifetime_points(arg0: &DogHouse) : &0x2::table::Table<address, u64> {
        &arg0.lifetime_points
    }

    public fun managers(arg0: &DogHouse) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun mint_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_to(arg0: &mut DogHouse, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>>(0x2::coin::mint<0xdadb7fa2771c2952f96161fc1f0c105d1f22d53926b9ff2498a8eea2f6eb204::treats::TREATS>(&mut arg0.treats_tc, arg2, arg4), arg3);
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

    public fun spend_custodial_pool<T0>(arg0: &mut DogHouse, arg1: &AdminCap, arg2: address, arg3: u64, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg5);
        let v0 = custodial_pool_mut<T0>(arg0, 0x1::type_name::get<T0>());
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.player_balances, arg2);
        *v1 = *v1 - arg3;
        let v2 = Spend<T0>{
            amount : arg3,
            user   : arg2,
            memo   : arg4,
        };
        0x2::event::emit<Spend<T0>>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg3), arg5)
    }

    public fun versions(arg0: &DogHouse) : &0x2::vec_set::VecSet<u64> {
        &arg0.versions
    }

    public fun view_balances<T0>(arg0: &DogHouse, arg1: address) : u64 {
        let v0 = custodial_pool<T0>(arg0, 0x1::type_name::get<T0>());
        if (0x2::table::contains<address, u64>(&v0.player_balances, arg1)) {
            *0x2::table::borrow<address, u64>(&v0.player_balances, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

