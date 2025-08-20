module 0xc3a1347c4eb100d4b370b6b35065501742b6e946e1e0d59abf662c22fa747881::delayed_upgrades_and_locked_upgrade_content {
    struct Policy has store, key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        digest: vector<u8>,
        eta_ms: u64,
    }

    public fun authorize_upgrade(arg0: &mut Policy, arg1: &mut Proposal, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert!(arg1.eta_ms > 0, 0);
        assert!(arg1.eta_ms < 0x2::clock::timestamp_ms(arg3), 1);
        arg1.eta_ms = 0;
        0x2::package::authorize_upgrade(&mut arg0.cap, arg2, arg1.digest)
    }

    public fun commit_upgrade(arg0: &mut Policy, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    public fun make_immutable(arg0: Policy) {
        let Policy {
            id  : v0,
            cap : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::package::make_immutable(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Proposal{
            id     : 0x2::object::new(arg0),
            digest : 0x1::vector::empty<u8>(),
            eta_ms : 0,
        };
        0x2::transfer::public_transfer<Proposal>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_ploy(arg0: &mut Proposal, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.eta_ms = 0x2::clock::timestamp_ms(arg2) + 172800000;
        arg0.digest = arg1;
    }

    public entry fun new_policy(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Policy{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0x2::transfer::public_transfer<Policy>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

