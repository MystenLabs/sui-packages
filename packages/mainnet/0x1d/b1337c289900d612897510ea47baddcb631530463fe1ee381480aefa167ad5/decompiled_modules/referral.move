module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::referral {
    struct Registry has key {
        id: 0x2::object::UID,
        referrer_of: 0x2::table::Table<address, address>,
        rewards: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        sealed: bool,
    }

    struct Bound has copy, drop {
        trader: address,
        referrer: address,
    }

    struct Claimed has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct BindingImported has copy, drop {
        trader: address,
        referrer: address,
    }

    struct RegistrySealed has copy, drop {
        imported: u64,
    }

    public(friend) fun accrue(arg0: &mut Registry, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, arg1)) {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, arg1), arg2);
        } else {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, arg1, arg2);
        };
    }

    public fun claim(arg0: &mut Registry, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, v0), 201);
        let v1 = 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        assert!(v2 > 0, 201);
        let v3 = Claimed{
            referrer : v0,
            amount   : v2,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2)
    }

    public fun import_bindings(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Registry, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: vector<address>, arg4: vector<address>) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        assert!(!arg1.sealed, 202);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<address>(&arg4), 203);
        assert!(v0 <= 500, 204);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            let v3 = *0x1::vector::borrow<address>(&arg4, v1);
            if (v2 != v3 && !0x2::table::contains<address, address>(&arg1.referrer_of, v2)) {
                0x2::table::add<address, address>(&mut arg1.referrer_of, v2, v3);
                let v4 = BindingImported{
                    trader   : v2,
                    referrer : v3,
                };
                0x2::event::emit<BindingImported>(v4);
            };
            v1 = v1 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg0),
            referrer_of : 0x2::table::new<address, address>(arg0),
            rewards     : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg0),
            sealed      : false,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_sealed(arg0: &Registry) : bool {
        arg0.sealed
    }

    public fun pending(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, arg1)) {
            0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, arg1))
        } else {
            0
        }
    }

    public fun referrer_of(arg0: &Registry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrer_of, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrer_of, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public(friend) fun resolve(arg0: &mut Registry, arg1: address, arg2: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrer_of, arg1)) {
            return 0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrer_of, arg1))
        };
        if (0x1::option::is_none<address>(&arg2)) {
            return 0x1::option::none<address>()
        };
        let v0 = 0x1::option::destroy_some<address>(arg2);
        assert!(v0 != arg1, 200);
        0x2::table::add<address, address>(&mut arg0.referrer_of, arg1, v0);
        let v1 = Bound{
            trader   : arg1,
            referrer : v0,
        };
        0x2::event::emit<Bound>(v1);
        0x1::option::some<address>(v0)
    }

    public fun seal(arg0: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::AdminCap, arg1: &mut Registry, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        assert!(!arg1.sealed, 202);
        arg1.sealed = true;
        let v0 = RegistrySealed{imported: 0x2::table::length<address, address>(&arg1.referrer_of)};
        0x2::event::emit<RegistrySealed>(v0);
    }

    // decompiled from Move bytecode v7
}

