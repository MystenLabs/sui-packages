module 0xdf56b7aea5cc758257260c8df3511bcfea8d920282c6f5091477a7cb19ab2844::allowed_versions {
    struct AV has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AllowedVersions has drop {
        pos0: vector<u64>,
    }

    public fun remove(arg0: &mut AV, arg1: &0xdf56b7aea5cc758257260c8df3511bcfea8d920282c6f5091477a7cb19ab2844::acl::AdminWitness<0xdf56b7aea5cc758257260c8df3511bcfea8d920282c6f5091477a7cb19ab2844::core::CORE>, arg2: u64) {
        assert!(arg2 != 1, 4);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    public fun add(arg0: &mut AV, arg1: &0xdf56b7aea5cc758257260c8df3511bcfea8d920282c6f5091477a7cb19ab2844::acl::AdminWitness<0xdf56b7aea5cc758257260c8df3511bcfea8d920282c6f5091477a7cb19ab2844::core::CORE>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public(friend) fun assert_pkg_version(arg0: &AllowedVersions) {
        let v0 = 1;
        assert!(0x1::vector::contains<u64>(&arg0.pos0, &v0), 3);
    }

    public fun get_allowed_versions(arg0: &AV) : AllowedVersions {
        AllowedVersions{pos0: *0x2::vec_set::keys<u64>(&arg0.allowed_versions)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AV{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<AV>(v0);
    }

    // decompiled from Move bytecode v6
}

