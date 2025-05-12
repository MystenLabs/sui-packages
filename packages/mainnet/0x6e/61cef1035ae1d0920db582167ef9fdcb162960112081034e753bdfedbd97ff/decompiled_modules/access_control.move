module 0x6e61cef1035ae1d0920db582167ef9fdcb162960112081034e753bdfedbd97ff::access_control {
    struct AccessConfig has key {
        id: 0x2::object::UID,
        proposed_admin: 0x1::option::Option<AdminChange>,
        paused: bool,
        pause_admin: vector<address>,
        minter: vector<address>,
        burner: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminChange has drop, store {
        proposed_admin: address,
        accepted: bool,
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

    struct MinterSet has copy, drop {
        minter: address,
        add: bool,
    }

    struct BurnerSet has copy, drop {
        burner: address,
        add: bool,
    }

    struct PauseSet has copy, drop {
        paused: bool,
    }

    public entry fun accept_admin(arg0: &mut AccessConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow_mut<AdminChange>(&mut arg0.proposed_admin);
        assert!(0x2::tx_context::sender(arg1) == v0.proposed_admin, 2);
        v0.accepted = true;
    }

    public fun assert_burner(arg0: &AccessConfig, arg1: address) {
        let v0 = get_burner(arg0);
        assert!(0x1::vector::contains<address>(&v0, &arg1), 2);
    }

    public fun assert_minter(arg0: &AccessConfig, arg1: address) {
        let v0 = get_minter(arg0);
        assert!(0x1::vector::contains<address>(&v0, &arg1), 2);
    }

    public(friend) fun assert_not_paused(arg0: &AccessConfig) {
        assert!(!is_paused(arg0), 0);
    }

    public fun assert_pause_admin(arg0: &AccessConfig, arg1: address) {
        let v0 = get_pause_admin(arg0);
        assert!(0x1::vector::contains<address>(&v0, &arg1), 2);
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

    public fun get_burner(arg0: &AccessConfig) : vector<address> {
        arg0.burner
    }

    public fun get_minter(arg0: &AccessConfig) : vector<address> {
        arg0.minter
    }

    public fun get_pause_admin(arg0: &AccessConfig) : vector<address> {
        arg0.pause_admin
    }

    public fun has_pause_admin(arg0: &AccessConfig) : bool {
        let v0 = get_pause_admin(arg0);
        0x1::vector::length<address>(&v0) != 0
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
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
            minter         : 0x1::vector::empty<address>(),
            burner         : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<AccessConfig>(v4);
    }

    public(friend) fun is_paused(arg0: &AccessConfig) : bool {
        arg0.paused
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

    public entry fun set_burner(arg0: &mut AccessConfig, arg1: address, arg2: bool, arg3: &AdminCap) {
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.burner, &arg1), 1);
            0x1::vector::push_back<address>(&mut arg0.burner, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.burner, &arg1);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.burner, v1);
        };
        let v2 = BurnerSet{
            burner : arg1,
            add    : arg2,
        };
        0x2::event::emit<BurnerSet>(v2);
    }

    public entry fun set_minter(arg0: &mut AccessConfig, arg1: address, arg2: bool, arg3: &AdminCap) {
        if (arg2) {
            assert!(!0x1::vector::contains<address>(&arg0.minter, &arg1), 1);
            0x1::vector::push_back<address>(&mut arg0.minter, arg1);
        } else {
            let (v0, v1) = 0x1::vector::index_of<address>(&arg0.minter, &arg1);
            assert!(v0, 1);
            0x1::vector::remove<address>(&mut arg0.minter, v1);
        };
        let v2 = MinterSet{
            minter : arg1,
            add    : arg2,
        };
        0x2::event::emit<MinterSet>(v2);
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

