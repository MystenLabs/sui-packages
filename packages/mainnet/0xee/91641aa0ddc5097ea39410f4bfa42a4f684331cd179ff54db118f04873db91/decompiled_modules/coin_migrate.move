module 0xee91641aa0ddc5097ea39410f4bfa42a4f684331cd179ff54db118f04873db91::coin_migrate {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Migrate has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, u64>,
        migrate_user: 0x2::table::Table<address, u64>,
        vault_b: 0x2::balance::Balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>,
        token_a_type: 0x1::option::Option<0x1::type_name::TypeName>,
        version: u64,
        pause_migrate: bool,
    }

    struct VersionUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct UserMigrateLogs has copy, drop {
        user: address,
        amount: u64,
    }

    struct RspMigrated has store {
        user: address,
        amount: u64,
    }

    public fun admin_del_users(arg0: &AdminCap, arg1: &mut Migrate, arg2: vector<address>) {
        assert_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.users, v1)) {
                0x2::table::remove<address, u64>(&mut arg1.users, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun admin_deposit_token_b(arg0: &AdminCap, arg1: &mut Migrate, arg2: 0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>) {
        0x2::balance::join<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg1.vault_b, 0x2::coin::into_balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(arg2));
    }

    public fun admin_set_users(arg0: &AdminCap, arg1: &mut Migrate, arg2: vector<address>, arg3: vector<u64>) {
        assert_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg3), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::table::contains<address, u64>(&arg1.users, v2)) {
                0x2::table::remove<address, u64>(&mut arg1.users, v2);
            };
            0x2::table::add<address, u64>(&mut arg1.users, v2, *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    public fun admin_toggle_migrate(arg0: &AdminCap, arg1: &mut Migrate, arg2: bool) {
        assert_version(arg1);
        arg1.pause_migrate = arg2;
    }

    public fun assert_version(arg0: &Migrate) {
        assert!(arg0.version <= 0, 8);
    }

    public fun get_user_amount(arg0: &Migrate, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.users, arg1)
        } else {
            0
        }
    }

    public fun get_user_migrated(arg0: &Migrate, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.migrate_user, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.migrate_user, arg1)
        } else {
            0
        }
    }

    public fun get_users_migrated(arg0: &Migrate, arg1: vector<address>) : vector<RspMigrated> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<RspMigrated>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            let v3 = if (0x2::table::contains<address, u64>(&arg0.migrate_user, v2)) {
                *0x2::table::borrow<address, u64>(&arg0.migrate_user, v2)
            } else {
                0
            };
            let v4 = RspMigrated{
                user   : v2,
                amount : v3,
            };
            0x1::vector::push_back<RspMigrated>(&mut v1, v4);
            v0 = v0 + 1;
        };
        v1
    }

    public fun has_user(arg0: &Migrate, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.users, arg1)
    }

    public fun initialize<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Migrate{
            id            : 0x2::object::new(arg0),
            users         : 0x2::table::new<address, u64>(arg0),
            migrate_user  : 0x2::table::new<address, u64>(arg0),
            vault_b       : 0x2::balance::zero<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(),
            token_a_type  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            version       : 0,
            pause_migrate : true,
        };
        0x2::transfer::share_object<Migrate>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Migrate) {
        assert_version(arg1);
        let v0 = VersionUpdated{
            old : arg1.version,
            new : 0,
        };
        0x2::event::emit<VersionUpdated>(v0);
        arg1.version = 0;
    }

    public fun set_token_a_type<T0>(arg0: &AdminCap, arg1: &mut Migrate) {
        assert_version(arg1);
        arg1.token_a_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    public fun user_migrate<T0>(arg0: &mut Migrate, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.pause_migrate, 9);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.token_a_type), 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.token_a_type) == &v0, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.users, 0x2::tx_context::sender(arg2)), 5);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.users, 0x2::tx_context::sender(arg2));
        assert!(v1 > 0, 6);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 <= v1, 7);
        assert!(0x2::balance::value<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&arg0.vault_b) >= v2, 10);
        let v3 = 0x2::tx_context::sender(arg2);
        if (v1 >= v2) {
            0x2::table::remove<address, u64>(&mut arg0.users, v3);
            0x2::table::add<address, u64>(&mut arg0.users, v3, v1 - v2);
        };
        let v4 = v2;
        if (0x2::table::contains<address, u64>(&arg0.migrate_user, v3)) {
            0x2::table::remove<address, u64>(&mut arg0.migrate_user, v3);
            v4 = v2 + *0x2::table::borrow<address, u64>(&arg0.migrate_user, v3);
        };
        0x2::table::add<address, u64>(&mut arg0.migrate_user, v3, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>>(0x2::coin::from_balance<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(0x2::balance::split<0x99cc0e7834326ec6ac571421e9b8e042e9eb63062771c77ac592bd194180b5da::deagent_token::DEAGENT_TOKEN>(&mut arg0.vault_b, v2), arg2), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        let v5 = UserMigrateLogs{
            user   : v3,
            amount : v2,
        };
        0x2::event::emit<UserMigrateLogs>(v5);
    }

    // decompiled from Move bytecode v6
}

