module 0xfbf7c11e07763ed06bf615a91096f09a37e496a59b0edb35df727ac15a3bb9f9::user_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, User>,
        update_cost: u64,
    }

    struct User has drop, store {
        user: address,
        username: 0x1::string::String,
        avatar_url: 0x1::string::String,
        self_excluded_till: u64,
    }

    struct NewAvatar has copy, drop {
        user: address,
        avatar_url: 0x1::string::String,
    }

    struct NewUsername has copy, drop {
        user: address,
        username: 0x1::string::String,
    }

    struct NewSelfExclusion has copy, drop {
        user: address,
        self_excluded_till: u64,
    }

    public fun avatar(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, User>(&arg0.users, v0), 1);
        0x2::table::borrow<address, User>(&arg0.users, v0).avatar_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg0),
            users       : 0x2::table::new<address, User>(arg0),
            update_cost : 1000000000,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun self_exclusion(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, User>(&arg0.users, v0), 1);
        0x2::table::borrow<address, User>(&arg0.users, v0).self_excluded_till
    }

    public fun set_avatar(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.update_cost, 0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::deposit<0x2::sui::SUI>(arg0, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NewAvatar{
            user       : v0,
            avatar_url : arg2,
        };
        if (0x2::table::contains<address, User>(&arg1.users, v0)) {
            0x2::table::borrow_mut<address, User>(&mut arg1.users, v0).avatar_url = arg2;
        } else {
            let v2 = User{
                user               : v0,
                username           : 0x1::string::utf8(b" "),
                avatar_url         : arg2,
                self_excluded_till : 0,
            };
            0x2::table::add<address, User>(&mut arg1.users, v0, v2);
        };
        0x2::event::emit<NewAvatar>(v1);
    }

    public fun set_self_exclusion(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = NewSelfExclusion{
            user               : v0,
            self_excluded_till : arg1,
        };
        if (0x2::table::contains<address, User>(&arg0.users, v0)) {
            let v2 = 0x2::table::borrow_mut<address, User>(&mut arg0.users, v0);
            assert!(arg1 > v2.self_excluded_till, 2);
            v2.self_excluded_till = arg1;
        } else {
            let v3 = User{
                user               : v0,
                username           : 0x1::string::utf8(b" "),
                avatar_url         : 0x1::string::utf8(b" "),
                self_excluded_till : arg1,
            };
            0x2::table::add<address, User>(&mut arg0.users, v0, v3);
        };
        0x2::event::emit<NewSelfExclusion>(v1);
    }

    public fun set_update_cost(arg0: &mut Registry, arg1: u64, arg2: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap) {
        arg0.update_cost = arg1;
    }

    public fun set_username(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.update_cost, 0);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::deposit<0x2::sui::SUI>(arg0, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NewUsername{
            user     : v0,
            username : arg2,
        };
        if (0x2::table::contains<address, User>(&arg1.users, v0)) {
            0x2::table::borrow_mut<address, User>(&mut arg1.users, v0).username = arg2;
        } else {
            let v2 = User{
                user               : v0,
                username           : arg2,
                avatar_url         : 0x1::string::utf8(b" "),
                self_excluded_till : 0,
            };
            0x2::table::add<address, User>(&mut arg1.users, v0, v2);
        };
        0x2::event::emit<NewUsername>(v1);
    }

    public fun username(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, User>(&arg0.users, v0), 1);
        0x2::table::borrow<address, User>(&arg0.users, v0).username
    }

    // decompiled from Move bytecode v6
}

