module 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive {
    struct ARCHIVE has drop {
        dummy_field: bool,
    }

    struct Reg has store, key {
        id: 0x2::object::UID,
        regs: 0x2::table::Table<address, bool>,
    }

    struct GuestLog has store, key {
        id: 0x2::object::UID,
        guests: 0x2::table::Table<address, bool>,
    }

    struct GuestArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce_type: 0x2::table::Table<u8, u128>,
        total_mission_reward: u64,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        bird: 0x1::option::Option<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>,
        bird_type: u16,
        bird_sub_type: u8,
        deposit_time: u64,
        nonce_type: 0x2::table::Table<u8, u128>,
        checkin_day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
        preying: bool,
        preying_counts: u128,
        total_preying_reward: u64,
        total_preying_bonus: u64,
        preying_energy: u64,
        boost_time: u64,
        boost_reward: u64,
        preying_time: u64,
        preying_claiming_time: u64,
        mating_bird: 0x1::option::Option<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>,
        mating_deposit_time: u64,
        mating_bird_sub_type: u8,
        mating: bool,
        mating_energy: u64,
        mating_time: u64,
        claiming_mating_time: u64,
        mating_count: u64,
    }

    struct GuestEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
    }

    struct RegisterEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u16,
        bird_sub_type: u8,
    }

    public(friend) fun clear_mating_session(arg0: &mut UserArchive, arg1: u64) : (u16, u64, 0x2::object::ID, 0x2::object::ID) {
        assert!(arg0.mating, 4009);
        assert!(arg0.claiming_mating_time <= arg1, 4007);
        arg0.mating = false;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        arg0.mating_energy = 0;
        (arg0.bird_type, arg0.mating_count, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)), 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird)))
    }

    public(friend) fun clear_preying_session(arg0: &mut UserArchive, arg1: u64, arg2: u64, arg3: u64) : (u128, 0x2::object::ID) {
        assert!(arg0.preying, 4006);
        assert!(arg0.preying_claiming_time <= arg1, 4007);
        arg0.total_preying_reward = arg0.total_preying_reward + arg2;
        arg0.total_preying_bonus = arg0.total_preying_bonus + arg3;
        arg0.preying = false;
        arg0.preying_energy = 0;
        arg0.preying_time = 0;
        arg0.preying_claiming_time = 0;
        (arg0.preying_counts, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)))
    }

    public fun ensure_not_mating(arg0: &mut UserArchive) {
        assert!(!arg0.mating, 4009);
    }

    public fun ensure_not_preying(arg0: &UserArchive) {
        assert!(!arg0.preying, 4006);
    }

    public(friend) fun fill_bird(arg0: &mut UserArchive, arg1: address, arg2: u64, arg3: u16, arg4: 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT) {
        assert!(!0x1::option::is_some<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird), 4003);
        assert!(arg0.owner == arg1, 4002);
        0x1::option::fill<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.bird, arg4);
        arg0.deposit_time = arg2;
        arg0.bird_type = arg3;
    }

    public(friend) fun fill_mating_bird(arg0: &mut UserArchive, arg1: 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT, arg2: u16, arg3: u8, arg4: u64) {
        assert!(arg0.bird_type == arg2, 4009);
        0x1::option::fill<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.mating_bird, arg1);
        arg0.mating_deposit_time = arg4;
        arg0.mating_bird_sub_type = arg3;
    }

    public fun get_archive(arg0: &UserArchive) : (u8, u64, u64, u16, u64, u64, u64) {
        (arg0.checkin_day, arg0.last_checkin_time, arg0.total_checkin_reward, arg0.bird_type, arg0.deposit_time, arg0.boost_time, arg0.boost_reward)
    }

    public fun get_bird_type_mating(arg0: &UserArchive, arg1: address) : u16 {
        assert!(arg0.owner == arg1, 4002);
        assert!(0x1::option::is_some<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird), 4003);
        arg0.bird_type
    }

    public fun get_boost(arg0: &UserArchive) : (u64, u64) {
        (arg0.boost_time, arg0.boost_reward)
    }

    public(friend) fun inc_checkin_reward(arg0: &mut UserArchive, arg1: u64) : u64 {
        arg0.total_checkin_reward = arg0.total_checkin_reward + arg1;
        arg0.total_checkin_reward
    }

    public(friend) fun inc_mission_reward(arg0: &mut GuestArchive, arg1: u64) : u64 {
        arg0.total_mission_reward = arg0.total_mission_reward + arg1;
        arg0.total_mission_reward
    }

    fun init(arg0: ARCHIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reg{
            id   : 0x2::object::new(arg1),
            regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Reg>(v0);
        let v1 = GuestLog{
            id     : 0x2::object::new(arg1),
            guests : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<GuestLog>(v1);
    }

    public fun register(arg0: &mut Reg, arg1: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::Config, arg2: 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_paused(arg1, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_archive());
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::check_version(arg4, 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::version::module_type_archive(), 1);
        let (_, v1, v2, _, _, _) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::info(&arg2);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::config::validate_bird_type(arg1, v1);
        let v6 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v6), 4001);
        0x2::table::add<address, bool>(&mut arg0.regs, v6, true);
        let v7 = UserArchive{
            id                    : 0x2::object::new(arg5),
            owner                 : v6,
            bird                  : 0x1::option::none<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(),
            bird_type             : v1,
            bird_sub_type         : v2,
            deposit_time          : 0x2::clock::timestamp_ms(arg3),
            nonce_type            : 0x2::table::new<u8, u128>(arg5),
            checkin_day           : 0,
            last_checkin_time     : 0,
            total_checkin_reward  : 0,
            preying               : false,
            preying_counts        : 0,
            total_preying_reward  : 0,
            total_preying_bonus   : 0,
            preying_energy        : 0,
            boost_time            : 0,
            boost_reward          : 0,
            preying_time          : 0,
            preying_claiming_time : 0,
            mating_bird           : 0x1::option::none<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(),
            mating_deposit_time   : 0,
            mating_bird_sub_type  : 0,
            mating                : false,
            mating_energy         : 0,
            mating_time           : 0,
            claiming_mating_time  : 0,
            mating_count          : 0,
        };
        0x1::option::fill<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut v7.bird, arg2);
        let v8 = RegisterEvent{
            archive_id    : 0x2::object::id<UserArchive>(&v7),
            owner         : v6,
            bird          : 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg2),
            bird_type     : v1,
            bird_sub_type : v2,
        };
        0x2::event::emit<RegisterEvent>(v8);
        0x2::transfer::public_transfer<UserArchive>(v7, v6);
    }

    public(friend) fun set_checkin(arg0: &mut UserArchive, arg1: u64, arg2: u8, arg3: u64) : (u8, u64) {
        let v0 = if (arg1 - arg0.last_checkin_time > 86400000 || arg0.checkin_day + 1 > arg2) {
            1
        } else {
            arg0.checkin_day + 1
        };
        arg0.checkin_day = v0;
        arg0.last_checkin_time = arg3;
        (arg0.checkin_day, arg0.last_checkin_time)
    }

    public fun set_mating_energy(arg0: &mut UserArchive, arg1: u64, arg2: u64) : (u64, 0x2::object::ID, 0x2::object::ID) {
        assert!(0x1::option::is_some<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird), 4004);
        assert!(arg0.mating_energy < arg2, 4008);
        arg0.mating_energy = arg0.mating_energy + arg1;
        (arg0.mating_energy, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)), 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird)))
    }

    public(friend) fun set_preying_energy(arg0: &mut UserArchive, arg1: u64, arg2: u64) : (u64, 0x2::object::ID) {
        assert!(arg0.preying_energy < arg2, 4008);
        arg0.preying_energy = arg0.preying_energy + arg1;
        (arg0.preying_energy, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)))
    }

    public(friend) fun set_upgrade_boost(arg0: &mut UserArchive, arg1: u8, arg2: u64) : (u64, u64) {
        if (arg1 == 0) {
            arg0.boost_time = arg2;
            (arg0.boost_time, arg0.boost_time)
        } else {
            arg0.boost_reward = arg2;
            (arg0.boost_reward, arg0.boost_reward)
        }
    }

    public(friend) fun start_mating_session(arg0: &mut UserArchive, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64, u64, u64, 0x2::object::ID, 0x2::object::ID) {
        assert!(arg0.mating_energy >= arg3, 4008);
        assert!(0x1::option::is_some<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird), 4004);
        assert!(arg0.mating_energy >= arg3, 4008);
        let (_, _, _, _, _, v5) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::info(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird));
        assert!(v5 > 0, 4010);
        let (_, _, _, _, _, v11) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::info(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird));
        assert!(v11 > 0, 4010);
        arg0.mating = true;
        arg0.mating_count = arg0.mating_count + 1;
        arg0.mating_time = arg1;
        arg0.claiming_mating_time = arg1 + arg2;
        let (v12, v13) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::update_mating_left(0x1::option::borrow_mut<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.bird));
        let (v14, v15) = 0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::update_mating_left(0x1::option::borrow_mut<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.mating_bird));
        (arg0.mating_time, arg0.claiming_mating_time, arg0.mating_count, v12, v13, v14, v15, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)), 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.mating_bird)))
    }

    public(friend) fun start_prey_session(arg0: &mut UserArchive, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u128, 0x2::object::ID) {
        assert!(arg0.preying_energy >= arg3, 4008);
        arg0.preying = true;
        arg0.preying_counts = arg0.preying_counts + 1;
        arg0.preying_time = arg1;
        arg0.preying_claiming_time = arg1 + arg2 - arg0.boost_time;
        (arg0.preying_time, arg0.preying_claiming_time, arg0.preying_counts, 0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(0x1::option::borrow<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird)))
    }

    public(friend) fun update_guest_nonce(arg0: &mut GuestArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 4005);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public(friend) fun update_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 4005);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public fun validate_bird_archive(arg0: &UserArchive, arg1: address) : u16 {
        assert!(arg0.owner == arg1, 4002);
        assert!(0x1::option::is_some<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&arg0.bird), 4004);
        arg0.bird_type
    }

    public(friend) fun withdraw_bird(arg0: &mut UserArchive) : 0x2::object::ID {
        let v0 = 0x1::option::extract<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.bird);
        0x2::transfer::public_transfer<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(v0, arg0.owner);
        arg0.checkin_day = 0;
        arg0.bird_type = 0;
        arg0.bird_sub_type = 0;
        arg0.deposit_time = 0;
        arg0.preying = false;
        arg0.preying_energy = 0;
        arg0.preying_time = 0;
        arg0.preying_claiming_time = 0;
        arg0.mating = false;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        arg0.mating_energy = 0;
        0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&v0)
    }

    public(friend) fun withdraw_mating_bird(arg0: &mut UserArchive) : 0x2::object::ID {
        let v0 = 0x1::option::extract<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&mut arg0.mating_bird);
        0x2::transfer::public_transfer<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(v0, arg0.owner);
        arg0.mating = false;
        arg0.mating_deposit_time = 0;
        arg0.mating_bird_sub_type = 0;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        arg0.mating_energy = 0;
        0x2::object::id<0x7e4fbd6cf7e75e98c67a27fbf1c1183c6328b5478ce108b55de8eef542ddb414::birds_nft::BirdNFT>(&v0)
    }

    // decompiled from Move bytecode v6
}

