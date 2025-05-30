module 0x17ce87611c3edd46bbe97dc14ba93e7d5f10d6428c4bcbc5059c1323938a3e57::kiosk_registry {
    struct KioskRegistry has key {
        id: 0x2::object::UID,
        user_kiosks: 0x2::table::Table<address, 0x2::object::ID>,
        total_kiosks: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
    }

    struct KioskRegistered has copy, drop {
        user: address,
        kiosk_id: 0x2::object::ID,
        is_update: bool,
        timestamp_ms: u64,
    }

    struct KioskUnregistered has copy, drop {
        user: address,
        kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun get_registry_id(arg0: &KioskRegistry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_total_kiosks(arg0: &KioskRegistry) : u64 {
        arg0.total_kiosks
    }

    public fun get_user_kiosk(arg0: &KioskRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_kiosks, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun has_registered_kiosk(arg0: &KioskRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = KioskRegistry{
            id           : v0,
            user_kiosks  : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_kiosks : 0,
        };
        let v2 = RegistryCreated{
            registry_id : 0x2::object::uid_to_inner(&v0),
            creator     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<KioskRegistry>(v1);
    }

    public entry fun register_kiosk(arg0: &mut KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        let v2 = 0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, v0);
        if (v2) {
            *0x2::table::borrow_mut<address, 0x2::object::ID>(&mut arg0.user_kiosks, v0) = v1;
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_kiosks, v0, v1);
            arg0.total_kiosks = arg0.total_kiosks + 1;
        };
        let v3 = KioskRegistered{
            user         : v0,
            kiosk_id     : v1,
            is_update    : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<KioskRegistered>(v3);
    }

    public(friend) fun register_kiosk_internal(arg0: &mut KioskRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, arg1)) {
            *0x2::table::borrow_mut<address, 0x2::object::ID>(&mut arg0.user_kiosks, arg1) = arg2;
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_kiosks, arg1, arg2);
            arg0.total_kiosks = arg0.total_kiosks + 1;
        };
    }

    public entry fun unregister_kiosk(arg0: &mut KioskRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.user_kiosks, v0), 3);
        arg0.total_kiosks = arg0.total_kiosks - 1;
        let v1 = KioskUnregistered{
            user         : v0,
            kiosk_id     : 0x2::table::remove<address, 0x2::object::ID>(&mut arg0.user_kiosks, v0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<KioskUnregistered>(v1);
    }

    // decompiled from Move bytecode v6
}

