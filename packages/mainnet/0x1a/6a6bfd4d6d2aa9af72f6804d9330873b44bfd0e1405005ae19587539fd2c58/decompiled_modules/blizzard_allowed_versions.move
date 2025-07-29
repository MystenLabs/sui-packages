module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions {
    struct BlizzardAV has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AllowedVersions has drop {
        pos0: vector<u64>,
    }

    public fun remove(arg0: &mut BlizzardAV, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg2: u64) {
        assert!(arg2 != 2, 5);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    public fun add(arg0: &mut BlizzardAV, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::AdminWitness<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard::BLIZZARD>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public(friend) fun assert_pkg_version(arg0: &AllowedVersions) {
        let v0 = 2;
        assert!(0x1::vector::contains<u64>(&arg0.pos0, &v0), 3);
    }

    public fun get_allowed_versions(arg0: &BlizzardAV) : AllowedVersions {
        AllowedVersions{pos0: *0x2::vec_set::keys<u64>(&arg0.allowed_versions)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlizzardAV{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(2),
        };
        0x2::transfer::share_object<BlizzardAV>(v0);
    }

    // decompiled from Move bytecode v6
}

