module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::timelock {
    struct Timelock has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct TimelockStateV1 has store, key {
        id: 0x2::object::UID,
        min_delay_ms: u64,
        slots: 0x2::table::Table<0x2::object::ID, UpgradeSlot>,
    }

    struct UpgradeSlot has store {
        pending_digest: 0x1::option::Option<vector<u8>>,
        eta_ms: u64,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun commit_upgrade(arg0: &mut Timelock, arg1: 0x2::object::ID, arg2: 0x2::package::UpgradeReceipt) {
        assert!(arg0.version == 1, 13835058794016538625);
        let v0 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1), 13836466181785649163);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v0.slots, arg1);
        assert!(0x2::package::receipt_cap(&arg2) == 0x2::object::id<0x2::package::UpgradeCap>(&v1.upgrade_cap), 13837029140329267215);
        0x2::package::commit_upgrade(&mut v1.upgrade_cap, arg2);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Timelock>(arg0), 30);
    }

    public fun upgrade_package(arg0: &Timelock, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        let v0 = state(arg0);
        if (!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2::package::upgrade_package(&0x2::table::borrow<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1).upgrade_cap))
        }
    }

    public fun cancel_upgrade(arg0: &mut Timelock, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::object::ID) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058600743010305);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg3), 13836465992807088139);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v0.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v1.pending_digest), 13835621576466497541);
        v1.pending_digest = 0x1::option::none<vector<u8>>();
        v1.eta_ms = 0;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Timelock>(arg0), 76);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Timelock {
        let v0 = 1;
        let v1 = Timelock{
            id      : 0x2::object::new(arg0),
            version : v0,
        };
        let v2 = TimelockStateV1{
            id           : 0x2::object::new(arg0),
            min_delay_ms : 86400000,
            slots        : 0x2::table::new<0x2::object::ID, UpgradeSlot>(arg0),
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::add<TimelockStateV1>(&mut v1.id, v0, v2);
        v1
    }

    public fun deposit_upgrade_cap(arg0: &mut Timelock, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::package::UpgradeCap) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058407469481985);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut(arg0);
        let v1 = 0x2::package::upgrade_package(&arg3);
        assert!(!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, v1), 13836747278805368845);
        let v2 = UpgradeSlot{
            pending_digest : 0x1::option::none<vector<u8>>(),
            eta_ms         : 0,
            upgrade_cap    : arg3,
        };
        0x2::table::add<0x2::object::ID, UpgradeSlot>(&mut v0.slots, v1, v2);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v3, 0x2::object::id<Timelock>(arg0), 29);
    }

    public fun execute_upgrade(arg0: &mut Timelock, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058708117192705);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg3), 13836466100181270539);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v0.slots, arg3);
        assert!(0x1::option::is_some<vector<u8>>(&v1.pending_digest), 13835621683840679941);
        assert!(*0x1::option::borrow<vector<u8>>(&v1.pending_digest) == arg4, 13836184638089330697);
        assert!(0x2::clock::timestamp_ms(arg5) >= v1.eta_ms, 13835903167407456263);
        0x1::option::extract<vector<u8>>(&mut v1.pending_digest);
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Timelock>(arg0), 27);
        0x2::package::authorize_upgrade(&mut v1.upgrade_cap, 0x2::package::upgrade_policy(&v1.upgrade_cap), arg4)
    }

    public fun has_upgrade_cap(arg0: &Timelock, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, UpgradeSlot>(&state(arg0).slots, arg1)
    }

    public fun min_delay_ms(arg0: &Timelock) : u64 {
        state(arg0).min_delay_ms
    }

    public fun pending_upgrade(arg0: &Timelock, arg1: 0x2::object::ID) : (0x1::option::Option<vector<u8>>, u64) {
        let v0 = state(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1), 13836466332109504523);
        let v1 = 0x2::table::borrow<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1);
        (v1.pending_digest, v1.eta_ms)
    }

    public fun raise_delay(arg0: &mut Timelock, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: u64) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835059021649805313);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        let v0 = state_mut(arg0);
        assert!(arg3 >= v0.min_delay_ms && arg3 >= 86400000, 13835340513806516227);
        assert!(arg3 <= 2592000000, 13837310847234342929);
        v0.min_delay_ms = arg3;
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v1, 0x2::object::id<Timelock>(arg0), 28);
    }

    public fun schedule_upgrade(arg0: &mut Timelock, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        assert!(arg0.version == 1, 13835058501958762497);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 13836184410456064009);
        let v0 = state_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg3), 13836465902612774923);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, UpgradeSlot>(&mut v0.slots, arg3);
        v1.pending_digest = 0x1::option::some<vector<u8>>(arg4);
        v1.eta_ms = 0x2::clock::timestamp_ms(arg5) + v0.min_delay_ms;
        let v2 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access::new();
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_admin_action(&v2, 0x2::object::id<Timelock>(arg0), 26);
    }

    public(friend) fun share(arg0: Timelock) {
        0x2::transfer::share_object<Timelock>(arg0);
    }

    fun state(arg0: &Timelock) : &TimelockStateV1 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow<TimelockStateV1>(&arg0.id, arg0.version)
    }

    fun state_mut(arg0: &mut Timelock) : &mut TimelockStateV1 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::extended_field::borrow_mut<TimelockStateV1>(&mut arg0.id, arg0.version)
    }

    public fun upgrade_version(arg0: &Timelock, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = state(arg0);
        if (!0x2::table::contains<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0x2::package::version(&0x2::table::borrow<0x2::object::ID, UpgradeSlot>(&v0.slots, arg1).upgrade_cap))
        }
    }

    // decompiled from Move bytecode v7
}

