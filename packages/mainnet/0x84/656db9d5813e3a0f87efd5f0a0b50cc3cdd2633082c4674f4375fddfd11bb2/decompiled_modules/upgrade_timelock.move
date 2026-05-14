module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::upgrade_timelock {
    struct TimelockedUpgradeCap has key {
        id: 0x2::object::UID,
        inner: 0x2::package::UpgradeCap,
        delay_ms: u64,
        pending_digest: vector<u8>,
        pending_policy: u8,
        pending_unlock_ts_ms: u64,
    }

    struct UpgradeProposed has copy, drop {
        digest: vector<u8>,
        policy: u8,
        unlock_ts_ms: u64,
    }

    struct UpgradeCancelled has copy, drop {
        digest: vector<u8>,
        cancelled_by: address,
        cancelled_at_ms: u64,
    }

    struct UpgradeAuthorized has copy, drop {
        digest: vector<u8>,
    }

    public fun authorize(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &mut TimelockedUpgradeCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x2::package::UpgradeTicket {
        assert!(0x1::vector::length<u8>(&arg1.pending_digest) > 0, 103);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.pending_unlock_ts_ms, 104);
        assert!(arg1.pending_digest == arg2, 105);
        let v0 = arg1.pending_digest;
        arg1.pending_digest = b"";
        arg1.pending_policy = 0;
        arg1.pending_unlock_ts_ms = 0;
        let v1 = UpgradeAuthorized{digest: v0};
        0x2::event::emit<UpgradeAuthorized>(v1);
        0x2::package::authorize_upgrade(&mut arg1.inner, arg1.pending_policy, v0)
    }

    public fun cancel(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::GuardianCap, arg1: &mut TimelockedUpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1.pending_digest) > 0, 103);
        arg1.pending_digest = b"";
        arg1.pending_policy = 0;
        arg1.pending_unlock_ts_ms = 0;
        let v0 = UpgradeCancelled{
            digest          : arg1.pending_digest,
            cancelled_by    : 0x2::tx_context::sender(arg3),
            cancelled_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UpgradeCancelled>(v0);
    }

    public fun commit(arg0: &mut TimelockedUpgradeCap, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.inner, arg1);
    }

    public fun delay_ms(arg0: &TimelockedUpgradeCap) : u64 {
        arg0.delay_ms
    }

    public fun has_pending(arg0: &TimelockedUpgradeCap) : bool {
        0x1::vector::length<u8>(&arg0.pending_digest) > 0
    }

    public fun max_delay_ms() : u64 {
        2592000000
    }

    public fun min_delay_ms() : u64 {
        86400000
    }

    public fun pending_digest(arg0: &TimelockedUpgradeCap) : &vector<u8> {
        &arg0.pending_digest
    }

    public fun pending_unlock_ts_ms(arg0: &TimelockedUpgradeCap) : u64 {
        arg0.pending_unlock_ts_ms
    }

    public fun propose(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: &mut TimelockedUpgradeCap, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 102);
        assert!(0x1::vector::length<u8>(&arg1.pending_digest) == 0, 106);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg1.delay_ms;
        arg1.pending_digest = arg2;
        arg1.pending_policy = arg3;
        arg1.pending_unlock_ts_ms = v0;
        let v1 = UpgradeProposed{
            digest       : arg2,
            policy       : arg3,
            unlock_ts_ms : v0,
        };
        0x2::event::emit<UpgradeProposed>(v1);
    }

    public fun share(arg0: TimelockedUpgradeCap) {
        0x2::transfer::share_object<TimelockedUpgradeCap>(arg0);
    }

    public fun wrap(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: 0x2::package::UpgradeCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : TimelockedUpgradeCap {
        assert!(arg2 >= 86400000, 100);
        assert!(arg2 <= 2592000000, 101);
        TimelockedUpgradeCap{
            id                   : 0x2::object::new(arg3),
            inner                : arg1,
            delay_ms             : arg2,
            pending_digest       : b"",
            pending_policy       : 0,
            pending_unlock_ts_ms : 0,
        }
    }

    // decompiled from Move bytecode v7
}

