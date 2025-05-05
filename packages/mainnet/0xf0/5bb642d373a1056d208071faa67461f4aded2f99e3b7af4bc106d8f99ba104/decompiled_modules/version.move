module 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version {
    struct VERSION has drop {
        dummy_field: bool,
    }

    struct VerAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        versions: 0x2::table::Table<u8, u64>,
    }

    public fun check_version(arg0: &Version, arg1: u8, arg2: u64) {
        assert!(0x2::table::contains<u8, u64>(&arg0.versions, arg1), 2002);
        assert!(*0x2::table::borrow<u8, u64>(&arg0.versions, arg1) == arg2, 2001);
    }

    fun init(arg0: VERSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VerAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VerAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::table::new<u8, u64>(arg1);
        0x2::table::add<u8, u64>(&mut v1, module_type_archive(), 1);
        0x2::table::add<u8, u64>(&mut v1, module_type_checkin(), 1);
        0x2::table::add<u8, u64>(&mut v1, module_type_mission(), 1);
        0x2::table::add<u8, u64>(&mut v1, module_type_game(), 1);
        let v2 = Version{
            id       : 0x2::object::new(arg1),
            versions : v1,
        };
        0x2::transfer::public_share_object<Version>(v2);
    }

    public fun migrate_version(arg0: &VerAdminCap, arg1: &mut Version, arg2: u8, arg3: u64) {
        assert!(0x2::table::contains<u8, u64>(&arg1.versions, arg2), 2002);
        let v0 = 0x2::table::borrow_mut<u8, u64>(&mut arg1.versions, arg2);
        assert!(arg3 > *v0, 2001);
        *v0 = arg3;
    }

    public fun module_type_archive() : u8 {
        0
    }

    public fun module_type_checkin() : u8 {
        1
    }

    public fun module_type_game() : u8 {
        3
    }

    public fun module_type_mission() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

