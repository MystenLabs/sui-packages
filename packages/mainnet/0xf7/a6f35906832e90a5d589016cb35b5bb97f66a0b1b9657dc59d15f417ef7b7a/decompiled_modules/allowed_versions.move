module 0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::allowed_versions {
    struct InterestStableSwapAV has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AllowedVersions has drop {
        pos0: vector<u64>,
    }

    public fun remove(arg0: &mut InterestStableSwapAV, arg1: &0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::acl::AuthWitness, arg2: u64) {
        assert!(arg2 != 1, 9);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    public fun add(arg0: &mut InterestStableSwapAV, arg1: &0xf7a6f35906832e90a5d589016cb35b5bb97f66a0b1b9657dc59d15f417ef7b7a::acl::AuthWitness, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public(friend) fun assert_pkg_version(arg0: &AllowedVersions) {
        let v0 = 1;
        assert!(0x1::vector::contains<u64>(&arg0.pos0, &v0), 10);
    }

    public fun get_allowed_versions(arg0: &InterestStableSwapAV) : AllowedVersions {
        AllowedVersions{pos0: *0x2::vec_set::keys<u64>(&arg0.allowed_versions)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InterestStableSwapAV{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<InterestStableSwapAV>(v0);
    }

    // decompiled from Move bytecode v6
}

