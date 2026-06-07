module 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_allowed_versions {
    struct AV has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AllowedVersions has drop {
        pos0: vector<u64>,
    }

    public fun remove(arg0: &mut AV, arg1: &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::acl::AdminWitness<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam::SAM>, arg2: u64) {
        assert!(arg2 != 2, 4);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    public fun add(arg0: &mut AV, arg1: &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::acl::AdminWitness<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam::SAM>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public(friend) fun assert_pkg_version(arg0: &AllowedVersions) {
        let v0 = 2;
        assert!(0x1::vector::contains<u64>(&arg0.pos0, &v0), 3);
    }

    public fun get_allowed_versions(arg0: &AV) : AllowedVersions {
        AllowedVersions{pos0: *0x2::vec_set::keys<u64>(&arg0.allowed_versions)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AV{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(2),
        };
        0x2::transfer::share_object<AV>(v0);
    }

    // decompiled from Move bytecode v7
}

