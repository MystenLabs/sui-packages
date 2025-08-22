module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_allowed_versions {
    struct MemezAV has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AllowedVersions has drop {
        pos0: vector<u64>,
    }

    public fun remove(arg0: &mut MemezAV, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: u64) {
        assert!(arg2 != 3, 21);
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
    }

    public fun add(arg0: &mut MemezAV, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<0x6101835e1df12852440c3ad3f079130e31702fe201eb1e3b77d141a0c6a58539::memez::MEMEZ>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
    }

    public(friend) fun assert_pkg_version(arg0: &AllowedVersions) {
        let v0 = 3;
        assert!(0x1::vector::contains<u64>(&arg0.pos0, &v0), 14);
    }

    public fun get_allowed_versions(arg0: &MemezAV) : AllowedVersions {
        AllowedVersions{pos0: *0x2::vec_set::keys<u64>(&arg0.allowed_versions)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemezAV{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<MemezAV>(v0);
    }

    // decompiled from Move bytecode v6
}

