module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning {
    struct Versioning has store {
        enabled_versions: 0x2::vec_set::VecSet<u64>,
        upgrade_cap: 0x1::option::Option<0x2::package::UpgradeCap>,
    }

    public(friend) fun authorize_upgrade(arg0: &mut Versioning, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), 0x2::package::upgrade_policy(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_cap)), arg1)
    }

    public(friend) fun commit_upgrade(arg0: &mut Versioning, arg1: 0x2::package::UpgradeReceipt, arg2: bool) {
        0x2::package::commit_upgrade(0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap), arg1);
        if (arg2) {
            arg0.enabled_versions = 0x2::vec_set::singleton<u64>(0x2::package::version(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_cap)));
        } else {
            0x2::vec_set::insert<u64>(&mut arg0.enabled_versions, 0x2::package::version(0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_cap)));
        };
    }

    public(friend) fun assert_version_enabled(arg0: &Versioning) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.enabled_versions, &v0), 13835058317275234306);
    }

    public(friend) fun create() : Versioning {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1);
        Versioning{
            enabled_versions : 0x2::vec_set::from_keys<u64>(v0),
            upgrade_cap      : 0x1::option::none<0x2::package::UpgradeCap>(),
        }
    }

    public(friend) fun disable_version(arg0: &mut Versioning, arg1: u64) {
        assert!(arg1 != 1, 13835339809431945220);
        0x2::vec_set::remove<u64>(&mut arg0.enabled_versions, &arg1);
    }

    public(friend) fun enable_version(arg0: &mut Versioning, arg1: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.enabled_versions, arg1);
    }

    public(friend) fun has_upgrade_cap(arg0: &Versioning) : bool {
        0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap)
    }

    public(friend) fun is_version_enabled(arg0: &Versioning, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.enabled_versions, &arg1)
    }

    public(friend) fun set_upgrade_cap(arg0: &mut Versioning, arg1: 0x2::package::UpgradeCap) {
        0x1::option::fill<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap, arg1);
    }

    public(friend) fun upgrade_cap(arg0: &Versioning) : &0x2::package::UpgradeCap {
        0x1::option::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_cap)
    }

    // decompiled from Move bytecode v7
}

