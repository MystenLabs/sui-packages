module 0x3513dd3a697b217997e6681a2ecee0ed25f7ec3e033a06ca63df1b78d79d920e::delayed_upgrades_and_locked_upgrade_content {
    struct Policy has store, key {
        id: 0x2::object::UID,
        digest: vector<u8>,
        temporize: u64,
        eta_ms: u64,
        cap: 0x2::package::UpgradeCap,
        get: u64,
    }

    public fun authorize_upgrade(arg0: &mut Policy, arg1: u8, arg2: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(arg0.eta_ms > 0, 0);
        assert!(arg0.eta_ms < 0x2::clock::timestamp_ms(arg2), 1);
        arg0.eta_ms = 0;
        0x2::package::authorize_upgrade(&mut arg0.cap, arg1, arg0.digest)
    }

    public fun commit_upgrade(arg0: &mut Policy, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    public fun make_immutable(arg0: Policy) {
        let Policy {
            id        : v0,
            digest    : _,
            temporize : _,
            eta_ms    : _,
            cap       : v4,
            get       : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::package::make_immutable(v4);
    }

    public fun get_upgradecap(arg0: Policy, arg1: &0x2::clock::Clock) : 0x2::package::UpgradeCap {
        assert!(arg0.get > 0, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.get, 1);
        let Policy {
            id        : v0,
            digest    : _,
            temporize : _,
            eta_ms    : _,
            cap       : v4,
            get       : _,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    public entry fun init_Policy(arg0: &mut Policy, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.eta_ms = 0x2::clock::timestamp_ms(arg2) + arg0.temporize;
        arg0.digest = arg1;
    }

    public entry fun new_policy(arg0: 0x2::package::UpgradeCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Policy{
            id        : 0x2::object::new(arg2),
            digest    : 0x1::vector::empty<u8>(),
            temporize : arg1 * 60000,
            eta_ms    : 0,
            cap       : arg0,
            get       : 0,
        };
        0x2::transfer::public_transfer<Policy>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun revise_get_upgradecap(arg0: &mut Policy, arg1: &0x2::clock::Clock) {
        arg0.get = 0x2::clock::timestamp_ms(arg1) + 864000000;
    }

    // decompiled from Move bytecode v6
}

