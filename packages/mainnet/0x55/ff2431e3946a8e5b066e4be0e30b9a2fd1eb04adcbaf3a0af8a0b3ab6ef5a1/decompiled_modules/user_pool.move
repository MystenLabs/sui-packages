module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user_pool {
    struct USER_POOL has drop {
        dummy_field: bool,
    }

    struct UserPool has key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<0x1::string::String, vector<address>>,
        map_address: 0x2::table::Table<address, 0x1::string::String>,
        users: 0x2::table::Table<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>,
    }

    public fun borrow(arg0: &UserPool, arg1: 0x1::string::String) : &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User {
        check_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&arg0.users, arg1)
    }

    public(friend) fun borrow_mut(arg0: &mut UserPool, arg1: 0x1::string::String) : &mut 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User {
        check_exists(arg0, arg1);
        0x2::table::borrow_mut<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg1)
    }

    entry fun destroy_empty(arg0: UserPool, arg1: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg2: &0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg1, arg2);
        let UserPool {
            id          : v0,
            map         : v1,
            map_address : v2,
            users       : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (0x2::table::is_empty<0x1::string::String, vector<address>>(&v6)) {
            if (0x2::table::is_empty<address, 0x1::string::String>(&v5)) {
                0x2::table::is_empty<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&v4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 3);
        0x2::table::destroy_empty<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(v4);
        0x2::table::drop<0x1::string::String, vector<address>>(v6);
        0x2::table::drop<address, 0x1::string::String>(v5);
        0x2::object::delete(v0);
    }

    entry fun delete(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license(arg2, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserDelete());
        check_exists(arg0, arg1);
        let v0 = 0x2::table::remove<0x1::string::String, vector<address>>(&mut arg0.map, arg1);
        0x1::vector::reverse<address>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.map_address, 0x1::vector::pop_back<address>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(v0);
        let v2 = 0x2::table::remove<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg1);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_admin(arg2, arg3), 2);
        let v3 = borrow_mut(arg0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::proposer(&v2));
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::remove_propose(v3, &v2);
        let v4 = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::proposed_mut(&mut v2);
        while (0x2::table_vec::length<0x1::string::String>(v4) > 0) {
            let v5 = 0x2::table::remove<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::SYSTEM_UID());
            let v6 = borrow_mut(arg0, 0x2::table_vec::pop_back<0x1::string::String>(v4));
            0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::set_proposer(v6, &mut v5, arg2, arg3);
            0x2::table::add<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::SYSTEM_UID(), v5);
        };
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::destroy_empty(v2, arg3);
    }

    public(friend) entry fun deposit<T0>(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg5: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_op(arg4, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserDeposit(), arg5);
        let v0 = borrow_mut(arg0, arg1);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_op(arg4, arg5) || 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::is_itself(v0, arg5), 2);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::deposit<T0>(v0, arg2, arg3, arg5);
    }

    public fun proposed(arg0: &UserPool, arg1: 0x1::string::String) : vector<0x1::string::String> {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::proposed(borrow(arg0, arg1))
    }

    entry fun set_owner(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: vector<address>, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_op(arg3, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserSetOwner(), arg4);
        let v0 = borrow_mut(arg0, arg1);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_op(arg3, arg4) || 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::is_itself(v0, arg4), 2);
        let v1 = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::owner(borrow(arg0, arg1));
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.map_address, 0x1::vector::pop_back<address>(&mut v1));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        0x2::table::remove<0x1::string::String, vector<address>>(&mut arg0.map, arg1);
        0x2::table::add<0x1::string::String, vector<address>>(&mut arg0.map, arg1, arg2);
        0x1::vector::reverse<address>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::add<address, 0x1::string::String>(&mut arg0.map_address, 0x1::vector::pop_back<address>(&mut arg2), arg1);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::set_owner(borrow_mut(arg0, arg1), arg2, arg4);
    }

    entry fun set_profit_layer(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg5: &0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_admin(arg4, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserSetProfitLayer(), arg5);
        assert!(0x2::ed25519::ed25519_verify(&arg3, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::get_config<vector<u8>>(arg4, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::CONFIG_KEY_AUTH_PUBLIC()), &arg2) == true, 0);
        let v0 = 0x2::bcs::new(arg2);
        assert!(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)) == arg1, 1);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::set_profit_layer(borrow_mut(arg0, arg1), 0x2::bcs::peel_u8(&mut v0));
    }

    entry fun set_proposer(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_op(arg3, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserSetProposer(), arg4);
        let v0 = 0x2::table::remove<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg1);
        let v1 = 0x2::table::remove<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg2);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_op(arg3, arg4) || 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::is_itself(&v0, arg4), 2);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::set_proposer(&mut v0, &mut v1, arg3, arg4);
        0x2::table::add<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg1, v0);
        0x2::table::add<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg2, v1);
    }

    public(friend) fun withdraw<T0>(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_admin(arg4, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserWithdraw(), arg5);
        let v0 = borrow_mut(arg0, arg1);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_admin(arg4, arg5) || 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::is_itself(v0, arg5), 2);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::withdraw<T0>(v0, arg2, arg3, arg5)
    }

    public(friend) fun check_exists(arg0: &UserPool, arg1: 0x1::string::String) {
        assert!(exists(arg0, arg1), 1);
    }

    entry fun create(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license(arg2, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserCreate());
        assert!(!exists(arg0, arg1), 0);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg3));
        0x2::table::add<0x1::string::String, vector<address>>(&mut arg0.map, arg1, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.map_address, 0x2::tx_context::sender(arg3), arg1);
        0x2::table::add<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut arg0.users, arg1, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::new(arg1, arg3));
    }

    fun create_user_pool_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserPool{
            id          : 0x2::object::new(arg0),
            map         : 0x2::table::new<0x1::string::String, vector<address>>(arg0),
            map_address : 0x2::table::new<address, 0x1::string::String>(arg0),
            users       : 0x2::table::new<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(arg0),
        };
        let v1 = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::SYSTEM_UID();
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x2::tx_context::sender(arg0));
        0x2::table::add<0x1::string::String, vector<address>>(&mut v0.map, v1, v2);
        0x2::table::add<address, 0x1::string::String>(&mut v0.map_address, 0x2::tx_context::sender(arg0), v1);
        0x2::table::add<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&mut v0.users, v1, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::new(v1, arg0));
        0x2::transfer::share_object<UserPool>(v0);
    }

    public(friend) fun exists(arg0: &UserPool, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User>(&arg0.users, arg1)
    }

    fun init(arg0: USER_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        create_user_pool_(arg1);
    }

    public(friend) fun map(arg0: &UserPool) : &0x2::table::Table<0x1::string::String, vector<address>> {
        &arg0.map
    }

    public(friend) fun map_address(arg0: &UserPool) : &0x2::table::Table<address, 0x1::string::String> {
        &arg0.map_address
    }

    public(friend) fun users(arg0: &UserPool) : &0x2::table::Table<0x1::string::String, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::User> {
        &arg0.users
    }

    entry fun withdraw_and_transfer<T0>(arg0: &mut UserPool, arg1: 0x1::string::String, arg2: u64, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_admin(arg3, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0UserWithdraw(), arg4);
        let v0 = borrow_mut(arg0, arg1);
        assert!(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_admin(arg3, arg4) || 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::is_itself(v0, arg4), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::user::withdraw<T0>(v0, arg2, 0x1::string::utf8(b"manual withdraw"), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

