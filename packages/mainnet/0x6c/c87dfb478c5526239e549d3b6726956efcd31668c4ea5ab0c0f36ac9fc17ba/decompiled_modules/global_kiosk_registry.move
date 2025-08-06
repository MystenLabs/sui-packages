module 0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::global_kiosk_registry {
    struct GlobalKioskRegistry has key {
        id: 0x2::object::UID,
        user_kiosks: 0x2::table::Table<address, 0x2::object::ID>,
        admin: 0x2::object::ID,
    }

    struct GlobalKioskRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct UserKioskRegistered has copy, drop {
        user_address: address,
        kiosk_id: 0x2::object::ID,
    }

    public entry fun create_global_kiosk_registry(arg0: &0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::admin::get_admin_cap_id(arg0);
        let v2 = GlobalKioskRegistry{
            id          : v0,
            user_kiosks : 0x2::table::new<address, 0x2::object::ID>(arg1),
            admin       : v1,
        };
        let v3 = GlobalKioskRegistryCreated{
            registry_id  : 0x2::object::uid_to_inner(&v0),
            admin_cap_id : v1,
        };
        0x2::event::emit<GlobalKioskRegistryCreated>(v3);
        0x2::transfer::share_object<GlobalKioskRegistry>(v2);
    }

    public fun get_user_kiosk(arg0: &GlobalKioskRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_kiosks, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_user_kiosk_or_fail(arg0: &GlobalKioskRegistry, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1), 4);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)
    }

    public fun has_user_kiosk(arg0: &GlobalKioskRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)
    }

    public entry fun remove_user_kiosk(arg0: &mut GlobalKioskRegistry, arg1: &0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::admin::AdminCap, arg2: address) {
        assert!(arg0.admin == 0xfdeaffe188ef912954a9ac3458edadde0aa872b4d27e306c2606d8691cc017b9::admin::get_admin_cap_id(arg1), 0);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg2)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_kiosks, arg2);
        };
    }

    public(friend) fun set_user_kiosk(arg0: &mut GlobalKioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1, 2);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg3) == arg2, 1);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            return
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_kiosks, arg1, arg2);
        let v0 = UserKioskRegistered{
            user_address : arg1,
            kiosk_id     : arg2,
        };
        0x2::event::emit<UserKioskRegistered>(v0);
    }

    public fun total_registered_kiosks(arg0: &GlobalKioskRegistry) : u64 {
        0x2::table::length<address, 0x2::object::ID>(&arg0.user_kiosks)
    }

    public fun verify_user_kiosk_capability(arg0: &GlobalKioskRegistry, arg1: address, arg2: &0x2::kiosk::KioskOwnerCap) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            return false
        };
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_kiosks, arg1) == 0x2::kiosk::kiosk_owner_cap_for(arg2)
    }

    public fun verify_user_kiosk_match(arg0: &GlobalKioskRegistry, arg1: address, arg2: 0x2::object::ID) : bool {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            return false
        };
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_kiosks, arg1) == arg2
    }

    // decompiled from Move bytecode v6
}

