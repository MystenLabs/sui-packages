module 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control {
    struct AccessConfig has key {
        id: 0x2::object::UID,
        proposed_admin: 0x1::option::Option<AdminChange>,
        paused: bool,
        pause_admin: vector<address>,
        minter_caps: 0x2::table::Table<0x2::object::ID, address>,
        burner_caps: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminChange has drop, store {
        proposed_admin: address,
        accepted: bool,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct BurnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCapTransferred has copy, drop {
        cap_id: address,
        from: address,
        to: address,
    }

    struct ProposedAdminChange has copy, drop {
        new_admin: address,
        old_admin: address,
    }

    struct PauseAdminSet has copy, drop {
        pause_admin: address,
        add: bool,
    }

    struct MinterCapIssued has copy, drop {
        minter: address,
        minter_cap_id: 0x2::object::ID,
    }

    struct MinterCapRevoked has copy, drop {
        minter_cap_id: 0x2::object::ID,
    }

    struct MinterCapDestroyed has copy, drop {
        minter_cap_id: 0x2::object::ID,
    }

    struct BurnerCapIssued has copy, drop {
        burner: address,
        burner_cap_id: 0x2::object::ID,
    }

    struct BurnerCapRevoked has copy, drop {
        burner_cap_id: 0x2::object::ID,
    }

    struct BurnerCapDestroyed has copy, drop {
        burner_cap_id: 0x2::object::ID,
    }

    struct PauseSet has copy, drop {
        paused: bool,
    }

    public entry fun accept_admin(arg0: &mut AccessConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<AdminChange>(&mut arg0.proposed_admin);
        assert!(0x2::tx_context::sender(arg1) == v0.proposed_admin, 2);
        v0.accepted = true;
    }

    public(friend) fun assert_not_paused(arg0: &AccessConfig) {
        assert!(!is_paused(arg0), 0);
    }

    public fun assert_pause_admin(arg0: &AccessConfig, arg1: address) {
        let v0 = get_pause_admin(arg0);
        assert!(0x1::vector::contains<address>(&v0, &arg1), 2);
    }

    public(friend) fun burner_cap_revoked(arg0: 0x2::object::ID, arg1: &mut AccessConfig) {
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.burner_caps, arg0)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.burner_caps, arg0);
        };
        let v0 = BurnerCapRevoked{burner_cap_id: arg0};
        0x2::event::emit<BurnerCapRevoked>(v0);
    }

    public entry fun destroy_burner_cap(arg0: BurnerCap, arg1: &mut AccessConfig) {
        let BurnerCap { id: v0 } = arg0;
        let v1 = 0x2::object::uid_to_inner(&v0);
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.burner_caps, v1)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.burner_caps, v1);
        };
        0x2::object::delete(v0);
        let v2 = BurnerCapDestroyed{burner_cap_id: v1};
        0x2::event::emit<BurnerCapDestroyed>(v2);
    }

    public entry fun destroy_minter_cap(arg0: MinterCap, arg1: &mut AccessConfig) {
        let MinterCap { id: v0 } = arg0;
        let v1 = 0x2::object::uid_to_inner(&v0);
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.minter_caps, v1)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.minter_caps, v1);
        };
        0x2::object::delete(v0);
        let v2 = MinterCapDestroyed{minter_cap_id: v1};
        0x2::event::emit<MinterCapDestroyed>(v2);
    }

    public entry fun execute_admin_change_proposal(arg0: &mut AccessConfig, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<AdminChange>(&arg0.proposed_admin);
        let v1 = v0.proposed_admin;
        assert!(v0.accepted == true, 4);
        arg0.proposed_admin = 0x1::option::none<AdminChange>();
        0x2::transfer::transfer<AdminCap>(arg1, v1);
        let v2 = AdminCapTransferred{
            cap_id : 0x2::object::uid_to_address(&arg1.id),
            from   : 0x2::tx_context::sender(arg2),
            to     : v1,
        };
        0x2::event::emit<AdminCapTransferred>(v2);
    }

    public(friend) fun get_burner_cap_id(arg0: &BurnerCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_minter_cap_id(arg0: &MinterCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_pause_admin(arg0: &AccessConfig) : vector<address> {
        arg0.pause_admin
    }

    public fun has_pause_admin(arg0: &AccessConfig) : bool {
        let v0 = get_pause_admin(arg0);
        0x1::vector::length<address>(&v0) != 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = AdminCapTransferred{
            cap_id : 0x2::object::uid_to_address(&v1.id),
            from   : @0x0,
            to     : v0,
        };
        0x2::event::emit<AdminCapTransferred>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let v4 = AccessConfig{
            id             : 0x2::object::new(arg0),
            proposed_admin : 0x1::option::none<AdminChange>(),
            paused         : false,
            pause_admin    : v3,
            minter_caps    : 0x2::table::new<0x2::object::ID, address>(arg0),
            burner_caps    : 0x2::table::new<0x2::object::ID, address>(arg0),
        };
        0x2::transfer::share_object<AccessConfig>(v4);
    }

    public(friend) fun is_paused(arg0: &AccessConfig) : bool {
        arg0.paused
    }

    public entry fun issue_burner_cap(arg0: address, arg1: &mut AccessConfig, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnerCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.burner_caps, v1, arg0);
        0x2::transfer::transfer<BurnerCap>(v0, arg0);
        let v2 = BurnerCapIssued{
            burner        : arg0,
            burner_cap_id : v1,
        };
        0x2::event::emit<BurnerCapIssued>(v2);
    }

    public entry fun issue_minter_cap(arg0: address, arg1: &mut AccessConfig, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.minter_caps, v1, arg0);
        0x2::transfer::transfer<MinterCap>(v0, arg0);
        let v2 = MinterCapIssued{
            minter        : arg0,
            minter_cap_id : v1,
        };
        0x2::event::emit<MinterCapIssued>(v2);
    }

    public(friend) fun minter_cap_revoked(arg0: 0x2::object::ID, arg1: &mut AccessConfig) {
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.minter_caps, arg0)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.minter_caps, arg0);
        };
        let v0 = MinterCapRevoked{minter_cap_id: arg0};
        0x2::event::emit<MinterCapRevoked>(v0);
    }

    public entry fun propose_admin_change(arg0: &mut AccessConfig, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 != @0x0, 3);
        assert!(arg1 != v0, 1);
        let v1 = AdminChange{
            proposed_admin : arg1,
            accepted       : false,
        };
        arg0.proposed_admin = 0x1::option::some<AdminChange>(v1);
        let v2 = ProposedAdminChange{
            new_admin : arg1,
            old_admin : v0,
        };
        0x2::event::emit<ProposedAdminChange>(v2);
    }

    public entry fun retract_admin_change_proposal(arg0: &mut AccessConfig, arg1: &AdminCap) {
        arg0.proposed_admin = 0x1::option::none<AdminChange>();
    }

    public(friend) fun set_pause(arg0: &mut AccessConfig, arg1: bool) {
        assert!(is_paused(arg0) != arg1, 1);
        arg0.paused = arg1;
        let v0 = PauseSet{paused: arg1};
        0x2::event::emit<PauseSet>(v0);
    }

    public entry fun set_pause_admin(arg0: &mut AccessConfig, arg1: address, arg2: bool, arg3: &AdminCap) {
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.pause_admin, &arg1), 1);
            0x1::vector::push_back<address>(&mut arg0.pause_admin, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.pause_admin, &arg1);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.pause_admin, v1);
        };
        let v2 = PauseAdminSet{
            pause_admin : arg1,
            add         : arg2,
        };
        0x2::event::emit<PauseAdminSet>(v2);
    }

    // decompiled from Move bytecode v6
}

