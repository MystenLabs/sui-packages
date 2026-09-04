module 0xc74a7df07b4089d92f196d1db73ce0574db7f58ae0ba2b19b2a59d402958d394::compliance {
    struct ComplianceRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        denied: 0x2::vec_set::VecSet<address>,
        allowed: 0x2::vec_set::VecSet<address>,
        allowlist_required: bool,
        paused: bool,
    }

    struct ComplianceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AddressDenied has copy, drop {
        addr: address,
    }

    struct AddressUndenied has copy, drop {
        addr: address,
    }

    struct AddressAllowed has copy, drop {
        addr: address,
    }

    struct AddressDisallowed has copy, drop {
        addr: address,
    }

    struct AllowlistRequirementChanged has copy, drop {
        required: bool,
    }

    struct CompliancePauseChanged has copy, drop {
        paused: bool,
    }

    public fun allow(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg0.allowed, &arg2), 705);
        0x2::vec_set::insert<address>(&mut arg0.allowed, arg2);
        let v0 = AddressAllowed{addr: arg2};
        0x2::event::emit<AddressAllowed>(v0);
    }

    public fun allowlist_required(arg0: &ComplianceRegistry) : bool {
        arg0.allowlist_required
    }

    public(friend) fun assert_clear(arg0: &ComplianceRegistry, arg1: address) {
        assert!(!arg0.paused, 700);
        assert!(!0x2::vec_set::contains<address>(&arg0.denied, &arg1), 701);
        if (arg0.allowlist_required) {
            assert!(0x2::vec_set::contains<address>(&arg0.allowed, &arg1), 702);
        };
    }

    public fun assert_clear_external(arg0: &ComplianceRegistry, arg1: address) {
        assert_clear(arg0, arg1);
    }

    public(friend) fun assert_pair_clear(arg0: &ComplianceRegistry, arg1: address, arg2: address) {
        assert_clear(arg0, arg1);
        assert_clear(arg0, arg2);
    }

    public fun assert_pair_clear_external(arg0: &ComplianceRegistry, arg1: address, arg2: address) {
        assert_pair_clear(arg0, arg1, arg2);
    }

    public fun deny(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg0.denied, &arg2), 703);
        0x2::vec_set::insert<address>(&mut arg0.denied, arg2);
        let v0 = AddressDenied{addr: arg2};
        0x2::event::emit<AddressDenied>(v0);
    }

    public fun disallow(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.allowed, &arg2), 706);
        0x2::vec_set::remove<address>(&mut arg0.allowed, &arg2);
        let v0 = AddressDisallowed{addr: arg2};
        0x2::event::emit<AddressDisallowed>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ComplianceRegistry{
            id                 : 0x2::object::new(arg0),
            admin              : 0x2::tx_context::sender(arg0),
            denied             : 0x2::vec_set::empty<address>(),
            allowed            : 0x2::vec_set::empty<address>(),
            allowlist_required : false,
            paused             : false,
        };
        0x2::transfer::share_object<ComplianceRegistry>(v0);
        let v1 = ComplianceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ComplianceAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_allowed(arg0: &ComplianceRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowed, &arg1)
    }

    public fun is_allowed_external(arg0: &ComplianceRegistry, arg1: address) : bool {
        is_allowed(arg0, arg1)
    }

    public fun is_denied(arg0: &ComplianceRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.denied, &arg1)
    }

    public fun is_paused(arg0: &ComplianceRegistry) : bool {
        arg0.paused
    }

    public fun is_paused_external(arg0: &ComplianceRegistry) : bool {
        is_paused(arg0)
    }

    public fun set_allowlist_required(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: bool) {
        arg0.allowlist_required = arg2;
        let v0 = AllowlistRequirementChanged{required: arg2};
        0x2::event::emit<AllowlistRequirementChanged>(v0);
    }

    public fun set_paused(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = CompliancePauseChanged{paused: arg2};
        0x2::event::emit<CompliancePauseChanged>(v0);
    }

    public fun undeny(arg0: &mut ComplianceRegistry, arg1: &ComplianceAdminCap, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.denied, &arg2), 704);
        0x2::vec_set::remove<address>(&mut arg0.denied, &arg2);
        let v0 = AddressUndenied{addr: arg2};
        0x2::event::emit<AddressUndenied>(v0);
    }

    // decompiled from Move bytecode v7
}

