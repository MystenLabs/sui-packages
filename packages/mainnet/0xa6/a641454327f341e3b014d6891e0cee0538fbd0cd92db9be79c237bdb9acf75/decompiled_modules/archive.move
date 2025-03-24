module 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::archive {
    struct ARCHIVE has drop {
        dummy_field: bool,
    }

    struct Reg has store, key {
        id: 0x2::object::UID,
        regs: 0x2::table::Table<address, bool>,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        bird: 0x1::option::Option<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>,
        owner: address,
        checkin_day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
        nonce_type: 0x2::table::Table<u8, u128>,
        bird_type: u8,
        deposit_time: u64,
        withdrawal_time: u64,
        boost: u64,
        rare: u8,
        preying: bool,
        energy: u64,
        preying_time: u64,
        claiming_time: u64,
    }

    struct RegisterEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
        bird: 0x2::object::ID,
        bird_type: u8,
    }

    public(friend) fun fill_bird(arg0: &mut UserArchive, arg1: u64, arg2: u8, arg3: 0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT) {
        0x1::option::fill<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&mut arg0.bird, arg3);
        arg0.deposit_time = arg1;
        arg0.bird_type = arg2;
    }

    public fun get_archive(arg0: &UserArchive) : (u8, u64, u64, u8, u64, u64, u64, u8) {
        (arg0.checkin_day, arg0.last_checkin_time, arg0.total_checkin_reward, arg0.bird_type, arg0.withdrawal_time, arg0.deposit_time, arg0.boost, arg0.rare)
    }

    public(friend) fun inc_checkin_reward(arg0: &mut UserArchive, arg1: u64) : u64 {
        arg0.total_checkin_reward = arg0.total_checkin_reward + arg1;
        arg0.total_checkin_reward
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

    public fun register(arg0: &mut Reg, arg1: &mut 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::Config, arg2: 0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT, arg3: &0x2::clock::Clock, arg4: &0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::validate_paused(arg1, 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::module_type_archive());
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::check_version(arg4, 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::module_type_archive(), 1);
        let (_, v1, _) = 0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::info(&arg2);
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::validate_bird_type(arg1, v1);
        let v3 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v3), 4001);
        0x2::table::add<address, bool>(&mut arg0.regs, v3, true);
        let v4 = 0x2::object::new(arg5);
        let v5 = UserArchive{
            id                   : v4,
            bird                 : 0x1::option::none<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(),
            owner                : v3,
            checkin_day          : 0,
            last_checkin_time    : 0,
            total_checkin_reward : 0,
            nonce_type           : init_nonce_archive(arg5),
            bird_type            : v1,
            deposit_time         : 0x2::clock::timestamp_ms(arg3),
            withdrawal_time      : 0,
            boost                : 0,
            rare                 : 0,
            preying              : false,
            energy               : 0,
            preying_time         : 0,
            claiming_time        : 0,
        };
        0x1::option::fill<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&mut v5.bird, arg2);
        let v6 = RegisterEvent{
            archive_id : 0x2::object::id<UserArchive>(&v5),
            owner      : v3,
            bird       : 0x2::object::id<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&arg2),
            bird_type  : v1,
        };
        0x2::event::emit<RegisterEvent>(v6);
        0x2::transfer::public_transfer<UserArchive>(v5, v3);
    }

    public(friend) fun reset_archive(arg0: &mut UserArchive) {
        arg0.bird_type = 0;
        arg0.deposit_time = 0;
        arg0.boost = 0;
        arg0.rare = 0;
        arg0.preying = false;
        arg0.energy = 0;
        arg0.preying_time = 0;
        arg0.claiming_time = 0;
    }

    public(friend) fun reset_preying(arg0: &mut UserArchive) {
        arg0.preying = false;
        arg0.preying_time = 0;
        arg0.claiming_time = 0;
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

    public(friend) fun set_prey(arg0: &mut UserArchive, arg1: u64, arg2: u64) : (u64, u64) {
        arg0.preying = true;
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

    public(friend) fun transfer_bird(arg0: &mut UserArchive, arg1: address) : 0x2::object::ID {
        let v0 = 0x1::option::extract<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&mut arg0.bird);
        0x2::transfer::public_transfer<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(v0, arg1);
        0x2::object::id<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&v0)
    }

    public(friend) fun update_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        assert!(0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1) < arg2, 4005);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    public fun validate_bird_archive(arg0: &UserArchive, arg1: address) : u8 {
        assert!(arg0.owner == arg1, 4002);
        assert!(0x1::option::is_some<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&arg0.bird), 4003);
        arg0.bird_type
    }

    public fun validate_bird_energy(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.energy < arg1, 4008);
    }

    public fun validate_bird_energy_v2(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.energy >= arg1, 4008);
    }

    public fun validate_claim_bird(arg0: &UserArchive, arg1: u64) {
        assert!(!arg0.preying, 4006);
        assert!(arg0.withdrawal_time <= arg1, 4007);
    }

    public fun validate_claim_reward_prey(arg0: &UserArchive, arg1: u64) {
        assert!(arg0.preying, 4006);
        assert!(arg0.claiming_time <= arg1, 4007);
    }

    public fun validate_deposit_bird(arg0: &UserArchive, arg1: address) {
        assert!(!0x1::option::is_some<0x29aa65ab8acff97b0f6fef340d874b39e3574cab7d1388099c05864039260a9f::birds_nft::BirdNFT>(&arg0.bird), 4003);
        assert!(arg0.owner == arg1, 4002);
    }

    public fun validate_preying(arg0: &UserArchive) {
        assert!(!arg0.preying, 4006);
    }

    public fun validate_type_tasks(arg0: u8) {
        assert!(arg0 >= 0 && arg0 < 6, 4004);
    }

    // decompiled from Move bytecode v6
}

