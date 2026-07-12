module 0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_upgrade {
    struct ProtocolUpgradeCap has key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
    }

    fun id(arg0: &ProtocolUpgradeCap) : 0x2::object::ID {
        0x2::object::id<ProtocolUpgradeCap>(arg0)
    }

    public fun new(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : ProtocolUpgradeCap {
        let v0 = 0x2::package::upgrade_package(&arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su::SU>(), 38);
        let v1 = ProtocolUpgradeCap{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        };
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_cap_created(id(&v1), v0, 0x2::package::upgrade_policy(&v1.cap));
        v1
    }

    public fun authorize_upgrade(arg0: &mut ProtocolUpgradeCap, arg1: &0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::AdminWitness, arg2: u8, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::assert_has_role(arg1, 1);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_authorized(id(arg0), 0x2::package::upgrade_package(&arg0.cap), arg2, arg3);
        0x2::package::authorize_upgrade(&mut arg0.cap, arg2, arg3)
    }

    public fun commit_upgrade(arg0: &mut ProtocolUpgradeCap, arg1: &0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::AdminWitness, arg2: 0x2::package::UpgradeReceipt) {
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::assert_has_role(arg1, 1);
        0x2::package::commit_upgrade(&mut arg0.cap, arg2);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_committed(id(arg0), 0x2::package::upgrade_package(&arg0.cap), 0x2::package::version(&arg0.cap));
    }

    public fun make_immutable(arg0: ProtocolUpgradeCap, arg1: &0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::AdminWitness) {
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::assert_has_role(arg1, 1);
        let ProtocolUpgradeCap {
            id  : v0,
            cap : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        0x2::object::delete(v3);
        0x2::package::make_immutable(v2);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_cap_made_immutable(0x2::object::id_from_address(0x2::object::uid_to_address(&v3)), 0x2::package::upgrade_package(&v2));
    }

    public fun only_additive_upgrades(arg0: &mut ProtocolUpgradeCap, arg1: &0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::AdminWitness) {
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::assert_has_role(arg1, 1);
        0x2::package::only_additive_upgrades(&mut arg0.cap);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_policy_restricted(id(arg0), 0x2::package::upgrade_package(&arg0.cap), 0x2::package::upgrade_policy(&arg0.cap));
    }

    public fun only_dep_upgrades(arg0: &mut ProtocolUpgradeCap, arg1: &0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::AdminWitness) {
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl::assert_has_role(arg1, 1);
        0x2::package::only_dep_upgrades(&mut arg0.cap);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::protocol_upgrade_policy_restricted(id(arg0), 0x2::package::upgrade_package(&arg0.cap), 0x2::package::upgrade_policy(&arg0.cap));
    }

    public fun share(arg0: ProtocolUpgradeCap) {
        0x2::transfer::share_object<ProtocolUpgradeCap>(arg0);
    }

    // decompiled from Move bytecode v7
}

