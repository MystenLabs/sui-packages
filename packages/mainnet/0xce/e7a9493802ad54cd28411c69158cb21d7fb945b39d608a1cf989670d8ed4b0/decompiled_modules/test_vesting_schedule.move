module 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule {
    struct Category has store, key {
        id: 0x2::object::UID,
        category: 0x2::vec_map::VecMap<0x1::string::String, Locker>,
    }

    struct Locker has store {
        total_limit: u64,
        released_amount: u64,
        spent_amount: u64,
        scheme: vector<u64>,
        available_amount: u64,
    }

    public(friend) fun cagtegory_init(arg0: &mut 0x2::tx_context::TxContext) : Category {
        let v0 = Category{
            id       : 0x2::object::new(arg0),
            category : 0x2::vec_map::empty<0x1::string::String, Locker>(),
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 33250000 * 1000000000);
        0x1::vector::push_back<u64>(v2, 2216666667 * 10000000);
        0x1::vector::push_back<u64>(v2, 2216666667 * 10000000);
        0x1::vector::push_back<u64>(v2, 2216666667 * 10000000);
        0x1::vector::push_back<u64>(v2, 2216666667 * 10000000);
        0x1::vector::push_back<u64>(v2, 2216666667 * 10000000);
        0x1::vector::push_back<u64>(v2, 2216666664 * 10000000);
        let v3 = Locker{
            total_limit      : 166250000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v1,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"SEED"), v3);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 17000000 * 1000000000);
        0x1::vector::push_back<u64>(v5, 13600000 * 1000000000);
        0x1::vector::push_back<u64>(v5, 13600000 * 1000000000);
        0x1::vector::push_back<u64>(v5, 13600000 * 1000000000);
        0x1::vector::push_back<u64>(v5, 13600000 * 1000000000);
        0x1::vector::push_back<u64>(v5, 13600000 * 1000000000);
        let v6 = Locker{
            total_limit      : 85000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v4,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"STRATEGIC"), v6);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = &mut v7;
        0x1::vector::push_back<u64>(v8, 4000000 * 1000000000);
        0x1::vector::push_back<u64>(v8, 19000000 * 1000000000);
        0x1::vector::push_back<u64>(v8, 19000000 * 1000000000);
        0x1::vector::push_back<u64>(v8, 19000000 * 1000000000);
        0x1::vector::push_back<u64>(v8, 19000000 * 1000000000);
        let v9 = Locker{
            total_limit      : 80000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v7,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"INSTITUTIONAL"), v9);
        let v10 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v10, 23000000 * 1000000000);
        let v11 = Locker{
            total_limit      : 23000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v10,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"PUBLICROUND"), v11);
        let v12 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v12, 162000000 * 1000000000);
        let v13 = Locker{
            total_limit      : 162000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v12,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"ECOSYSTEM"), v13);
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 0);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555556 * 10000000);
        0x1::vector::push_back<u64>(v15, 55555540 * 10000000);
        let v16 = Locker{
            total_limit      : 20000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v14,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"FOUNDATION"), v16);
        let v17 = 0x1::vector::empty<u64>();
        let v18 = &mut v17;
        0x1::vector::push_back<u64>(v18, 36147500 * 1000000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        0x1::vector::push_back<u64>(v18, 2065571428 * 10000000);
        let v19 = Locker{
            total_limit      : 180737500 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v17,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"MARKETING"), v19);
        let v20 = 0x1::vector::empty<u64>();
        let v21 = &mut v20;
        0x1::vector::push_back<u64>(v21, 61705000 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        0x1::vector::push_back<u64>(v21, 15426250 * 1000000000);
        let v22 = Locker{
            total_limit      : 154262500 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v20,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"LIQUIDITY"), v22);
        let v23 = 0x1::vector::empty<u64>();
        let v24 = &mut v23;
        0x1::vector::push_back<u64>(v24, 0);
        0x1::vector::push_back<u64>(v24, 0);
        0x1::vector::push_back<u64>(v24, 0);
        0x1::vector::push_back<u64>(v24, 0);
        0x1::vector::push_back<u64>(v24, 512686667 * 10000000);
        0x1::vector::push_back<u64>(v24, 512686667 * 10000000);
        0x1::vector::push_back<u64>(v24, 512686667 * 10000000);
        0x1::vector::push_back<u64>(v24, 717848333 * 10000000);
        0x1::vector::push_back<u64>(v24, 717848333 * 10000000);
        0x1::vector::push_back<u64>(v24, 717848333 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161667 * 10000000);
        0x1::vector::push_back<u64>(v24, 205161660 * 10000000);
        let v25 = Locker{
            total_limit      : 80000000 * 1000000000,
            released_amount  : 0,
            spent_amount     : 0,
            scheme           : v23,
            available_amount : 0,
        };
        0x2::vec_map::insert<0x1::string::String, Locker>(&mut v0.category, 0x1::string::utf8(b"EMPLOYEETOKENOPTION"), v25);
        v0
    }

    public(friend) fun ecosystem_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"ECOSYSTEM");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun employeetokenoption_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"EMPLOYEETOKENOPTION");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun foundation_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"FOUNDATION");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun institutional_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"INSTITUTIONAL");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun liquidity_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"LIQUIDITY");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun locker(arg0: &mut Category, arg1: 0x1::string::String) : &mut Locker {
        0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &arg1)
    }

    public(friend) fun marketing_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"MARKETING");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun public_round_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"PUBLICROUND");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun released_amount(arg0: &Locker) : u64 {
        arg0.released_amount
    }

    public(friend) fun scheme(arg0: &Locker) : vector<u64> {
        arg0.scheme
    }

    public(friend) fun seed_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"SEED");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun set_available_amount(arg0: &mut Locker, arg1: u64) {
        arg0.available_amount = arg1;
    }

    public(friend) fun set_released_amount(arg0: &mut Locker, arg1: u64) {
        arg0.released_amount = arg1;
    }

    public(friend) fun set_spent_amount(arg0: &mut Locker, arg1: u64) {
        arg0.spent_amount = arg1;
    }

    public(friend) fun spent_amount(arg0: &Locker) : u64 {
        arg0.spent_amount
    }

    public(friend) fun strategic_initial_release(arg0: &mut Category) {
        let v0 = 0x1::string::utf8(b"STRATEGIC");
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, Locker>(&mut arg0.category, &v0);
        v1.released_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
        v1.available_amount = *0x1::vector::borrow_mut<u64>(&mut v1.scheme, 0);
    }

    public(friend) fun total_limit(arg0: &Locker) : u64 {
        arg0.total_limit
    }

    // decompiled from Move bytecode v6
}

