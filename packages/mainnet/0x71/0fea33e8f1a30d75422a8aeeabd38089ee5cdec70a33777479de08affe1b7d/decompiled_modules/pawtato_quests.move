module 0x710fea33e8f1a30d75422a8aeeabd38089ee5cdec70a33777479de08affe1b7d::pawtato_quests {
    struct PAWTATO_QUESTS has drop {
        dummy_field: bool,
    }

    struct QuestSystem has key {
        id: 0x2::object::UID,
        treasury_address: address,
        version: u64,
        paused: bool,
        pawtato_package_cap: 0x1::option::Option<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>,
    }

    struct QuestAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RepresentingLandSet has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        land_type: 0x1::string::String,
    }

    struct InfluenceChanged has copy, drop {
        user: address,
        nft_id: 0x2::object::ID,
        old_influence: u64,
        new_influence: u64,
    }

    public entry fun add_pawtato_package_cap(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap) {
        0x1::option::fill<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&mut arg1.pawtato_package_cap, arg2);
    }

    fun check_not_paused(arg0: &QuestSystem) {
        assert!(!arg0.paused, 701);
    }

    fun check_version(arg0: &QuestSystem) {
        assert!(arg0.version == 1, 700);
    }

    fun init(arg0: PAWTATO_QUESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = QuestAdminCap{id: 0x2::object::new(arg1)};
        let v1 = QuestSystem{
            id                  : 0x2::object::new(arg1),
            treasury_address    : 0x2::tx_context::sender(arg1),
            version             : 1,
            paused              : false,
            pawtato_package_cap : 0x1::option::none<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(),
        };
        0x2::transfer::share_object<QuestSystem>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PAWTATO_QUESTS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<QuestAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_paused(arg0: &QuestAdminCap, arg1: &mut QuestSystem, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_representing_land(arg0: &mut QuestSystem, arg1: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::StakingPool, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Land Type");
        let v2 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato::get_attributes(0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::get_staked_land(arg1, v0, arg2)), &v1);
        let v3 = if (v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Estate")) {
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Estate")
        } else {
            assert!(v2 == 0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Province"), 702);
            0xa9d503feaf655e76df1de94b034bcdd9c4caa7cba5311269506b07100d03ee72::pawtato_helpers::utf8(b"Province")
        };
        0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_land::set_rep_land(0x1::option::borrow<0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_package_cap::PawtatoPackageCap>(&arg0.pawtato_package_cap), arg1, v0, arg2);
        let v4 = RepresentingLandSet{
            user      : v0,
            nft_id    : arg2,
            land_type : v3,
        };
        0x2::event::emit<RepresentingLandSet>(v4);
    }

    public entry fun upgrade_version(arg0: &QuestAdminCap, arg1: &mut QuestSystem) {
        assert!(arg1.version < 1, 13906834642494816255);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

