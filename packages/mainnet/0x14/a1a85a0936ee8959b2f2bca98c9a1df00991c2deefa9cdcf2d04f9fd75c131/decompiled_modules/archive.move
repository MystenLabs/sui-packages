module 0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::archive {
    struct ARCHIVE has drop {
        dummy_field: bool,
    }

    struct Reg has store, key {
        id: 0x2::object::UID,
        regs: 0x2::table::Table<address, bool>,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        bird: 0x1::option::Option<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>,
        bird_type: u16,
        bird_sub_type: u8,
        deposit_time: u64,
        withdrawal_time: u64,
        nonce_type: 0x2::table::Table<u8, u128>,
        checkin_day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
        total_mission_reward: u64,
        preying: bool,
        preying_counts: u128,
        total_preying_reward: u64,
        total_preying_bonus: u64,
        energy: u64,
        boost: u64,
        rare: u8,
        preying_time: u64,
        claiming_time: u64,
        mating_bird: 0x1::option::Option<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>,
        mating_deposit_time: u64,
        mating_bird_sub_type: u8,
        mating: bool,
        mating_energy: u64,
        mating_time: u64,
        claiming_mating_time: u64,
        mating_count: u64,
    }

    struct RegisterEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u16,
        bird_sub_type: u8,
    }

    public(friend) fun clear_mating_session(arg0: &mut UserArchive, arg1: u64) : (u16, u64) {
        assert!(arg0.mating, 4011);
        assert!(arg0.claiming_mating_time <= arg1, 4007);
        arg0.mating = false;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        arg0.mating_energy = 0;
        (arg0.bird_type, arg0.mating_count)
    }

    public fun ensure_not_mating(arg0: &mut UserArchive) {
        assert!(!arg0.mating, 4011);
    }

    public(friend) fun fill_bird(arg0: &mut UserArchive, arg1: u64, arg2: u16, arg3: 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT) {
        0x1::option::fill<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&mut arg0.bird, arg3);
        arg0.deposit_time = arg1;
        arg0.bird_type = arg2;
    }

    public(friend) fun fill_mating_bird(arg0: &mut UserArchive, arg1: 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, arg2: u16, arg3: u8, arg4: u64) {
        assert!(arg0.bird_type == arg2, 4011);
        0x1::option::fill<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&mut arg0.mating_bird, arg1);
        arg0.mating_deposit_time = arg4;
        arg0.mating_bird_sub_type = arg3;
    }

    public fun get_archive(arg0: &UserArchive) : (u8, u64, u64, u16, u64, u64, u64, u8) {
        (arg0.checkin_day, arg0.last_checkin_time, arg0.total_checkin_reward, arg0.bird_type, arg0.withdrawal_time, arg0.deposit_time, arg0.boost, arg0.rare)
    }

    public fun get_bird_type_mating(arg0: &UserArchive, arg1: address) : u16 {
        assert!(arg0.owner == arg1, 4002);
        assert!(0x1::option::is_some<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg0.mating_bird), 4003);
        arg0.bird_type
    }

    public(friend) fun inc_checkin_reward(arg0: &mut UserArchive, arg1: u64) : u64 {
        arg0.total_checkin_reward = arg0.total_checkin_reward + arg1;
        arg0.total_checkin_reward
    }

    public(friend) fun inc_mission_reward(arg0: &mut UserArchive, arg1: u64) : u64 {
        arg0.total_mission_reward = arg0.total_mission_reward + arg1;
        arg0.total_mission_reward
    }

    fun init(arg0: ARCHIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reg{
            id   : 0x2::object::new(arg1),
            regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Reg>(v0);
    }

    fun init_nonce_archive(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u8, u128> {
        let v0 = 0x2::table::new<u8, u128>(arg0);
        0x2::table::add<u8, u128>(&mut v0, 0, 0);
        0x2::table::add<u8, u128>(&mut v0, 1, 0);
        0x2::table::add<u8, u128>(&mut v0, 2, 0);
        0x2::table::add<u8, u128>(&mut v0, 3, 0);
        0x2::table::add<u8, u128>(&mut v0, 4, 0);
        0x2::table::add<u8, u128>(&mut v0, 5, 0);
        v0
    }

    public fun register(arg0: &mut Reg, arg1: &mut 0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::config::Config, arg2: 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::config::validate_paused(arg1, 0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::version::module_type_archive());
        0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::version::check_version(arg4, 0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::version::module_type_archive(), 1);
        let (_, v1, v2, _) = 0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::info(&arg2);
        0x14a1a85a0936ee8959b2f2bca98c9a1df00991c2deefa9cdcf2d04f9fd75c131::config::validate_bird_type(arg1, v1);
        let v4 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v4), 4001);
        0x2::table::add<address, bool>(&mut arg0.regs, v4, true);
        let v5 = 0x2::object::new(arg5);
        let v6 = UserArchive{
            id                   : v5,
            owner                : v4,
            bird                 : 0x1::option::none<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(),
            bird_type            : v1,
            bird_sub_type        : v2,
            deposit_time         : 0x2::clock::timestamp_ms(arg3),
            withdrawal_time      : 0,
            nonce_type           : init_nonce_archive(arg5),
            checkin_day          : 0,
            last_checkin_time    : 0,
            total_checkin_reward : 0,
            total_mission_reward : 0,
            preying              : false,
            preying_counts       : 0,
            total_preying_reward : 0,
            total_preying_bonus  : 0,
            energy               : 0,
            boost                : 0,
            rare                 : 0,
            preying_time         : 0,
            claiming_time        : 0,
            mating_bird          : 0x1::option::none<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(),
            mating_deposit_time  : 0,
            mating_bird_sub_type : 0,
            mating               : false,
            mating_energy        : 0,
            mating_time          : 0,
            claiming_mating_time : 0,
            mating_count         : 0,
        };
        0x1::option::fill<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&mut v6.bird, arg2);
        let v7 = RegisterEvent{
            archive_id    : 0x2::object::id<UserArchive>(&v6),
            owner         : v4,
            bird          : 0x2::object::id<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg2),
            bird_type     : v1,
            bird_sub_type : v2,
        };
        0x2::event::emit<RegisterEvent>(v7);
        0x2::transfer::public_transfer<UserArchive>(v6, v4);
    }

    public(friend) fun reset_archive(arg0: &mut UserArchive) {
        arg0.checkin_day = 0;
        arg0.last_checkin_time = 0;
        arg0.bird_type = 0;
        arg0.bird_sub_type = 0;
        arg0.deposit_time = 0;
        arg0.boost = 0;
        arg0.rare = 0;
        arg0.preying = false;
        arg0.energy = 0;
        arg0.preying_time = 0;
        arg0.claiming_time = 0;
        arg0.mating = false;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        arg0.mating_energy = 0;
    }

    public(friend) fun reset_preying(arg0: &mut UserArchive, arg1: u64, arg2: u64) : u128 {
        arg0.total_preying_reward = arg0.total_preying_reward + arg1;
        arg0.total_preying_bonus = arg0.total_preying_bonus + arg2;
        arg0.energy = 0;
        arg0.preying = false;
        arg0.preying_time = 0;
        arg0.claiming_time = 0;
        arg0.preying_counts
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

    public(friend) fun set_energy(arg0: &mut UserArchive, arg1: u64) : u64 {
        arg0.energy = arg0.energy + arg1;
        arg0.energy
    }

    public fun set_mating_energy(arg0: &mut UserArchive, arg1: u64) : u64 {
        assert!(0x1::option::is_some<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg0.mating_bird), 4003);
        assert!(arg0.mating_energy <= arg1, 4008);
        arg0.mating_energy = arg0.mating_energy + arg1;
        arg0.mating_energy
    }

    public(friend) fun set_prey(arg0: &mut UserArchive, arg1: u64, arg2: u64) : (u64, u64) {
        arg0.preying = true;
        arg0.preying_counts = arg0.preying_counts + 1;
        arg0.preying_time = arg1;
        arg0.claiming_time = arg1 + arg2 - arg0.boost;
        (arg0.preying_time, arg0.claiming_time)
    }

    public(friend) fun set_time_withdraw_nft(arg0: &mut UserArchive, arg1: u64, arg2: u64) : u64 {
        arg0.withdrawal_time = arg1 + arg2;
        arg0.withdrawal_time
    }

    public(friend) fun set_upgrade(arg0: &mut UserArchive, arg1: u8, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0.boost = arg0.boost + arg2;
            arg0.boost
        } else {
            arg0.rare = arg0.rare + (arg2 as u8);
            (arg0.rare as u64)
        }
    }

    public(friend) fun start_mating_session(arg0: &mut UserArchive, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        assert!(arg0.mating_energy >= arg3, 4008);
        assert!(arg0.mating_energy >= arg3, 4008);
        assert!(arg0.mating_count < arg4, 4012);
        arg0.mating = true;
        arg0.mating_count = arg0.mating_count + 1;
        arg0.mating_time = arg1;
        arg0.claiming_mating_time = arg1 + arg2;
        (arg0.mating_time, arg0.claiming_mating_time)
    }

    public(friend) fun transfer_bird(arg0: &mut UserArchive, arg1: address) : 0x2::object::ID {
        let v0 = 0x1::option::extract<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&mut arg0.bird);
        0x2::transfer::public_transfer<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(v0, arg1);
        0x2::object::id<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&v0)
    }

    public(friend) fun update_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        assert!(0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1) < arg2, 4005);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public fun validate_bird_archive(arg0: &UserArchive, arg1: address) : u16 {
        assert!(arg0.owner == arg1, 4002);
        assert!(0x1::option::is_some<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg0.bird), 4003);
        assert!(arg0.withdrawal_time == 0, 4009);
        arg0.bird_type
    }

    public fun validate_bird_energy(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.energy < arg1, 4008);
    }

    public fun validate_bird_energy_v2(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.energy >= arg1, 4008);
    }

    public fun validate_claim_bird(arg0: &mut UserArchive, arg1: u64) : u16 {
        assert!(!arg0.preying, 4006);
        assert!(0x1::option::is_some<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg0.bird), 4003);
        assert!(arg0.withdrawal_time != 0 && arg0.withdrawal_time <= arg1, 4007);
        arg0.withdrawal_time = 0;
        arg0.bird_type
    }

    public fun validate_claim_reward_prey(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.preying, 4006);
        assert!(arg0.claiming_time <= arg1, 4007);
    }

    public fun validate_deposit_bird(arg0: &UserArchive, arg1: address) {
        assert!(!0x1::option::is_some<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&arg0.bird), 4003);
        assert!(arg0.owner == arg1, 4002);
    }

    public fun validate_preying(arg0: &UserArchive) {
        assert!(!arg0.preying, 4006);
    }

    public fun validate_type_tasks(arg0: u8) {
        assert!(arg0 >= 0 && arg0 < 6, 4004);
    }

    public(friend) fun withdraw_mating_bird(arg0: &mut UserArchive) : 0x2::object::ID {
        let v0 = 0x1::option::extract<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&mut arg0.mating_bird);
        0x2::transfer::public_transfer<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(v0, arg0.owner);
        arg0.mating = false;
        arg0.mating_deposit_time = 0;
        arg0.mating_bird_sub_type = 0;
        arg0.mating_time = 0;
        arg0.claiming_mating_time = 0;
        0x2::object::id<0x2a45cae4986125fc8872a054398b3c9a80201e61f75a011af48f2af0edea66ec::birds_nft::BirdNFT>(&v0)
    }

    // decompiled from Move bytecode v6
}

