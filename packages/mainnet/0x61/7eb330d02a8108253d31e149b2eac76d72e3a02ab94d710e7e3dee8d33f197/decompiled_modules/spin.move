module 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::spin {
    struct SpinRegistry has key {
        id: 0x2::object::UID,
        chances: 0x2::vec_map::VecMap<u8, u8>,
    }

    struct SpinTheWheelEvent has copy, drop {
        dvd_id: 0x2::object::ID,
        reward_type: 0x1::string::String,
        reward_value: u64,
        spinner: address,
        slot: u8,
    }

    entry fun spin(arg0: &mut 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::Config, arg3: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_rewards::RewardRegistry, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::validate_version(arg1, 2);
        assert!(0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::validate_spin_reward(arg0), 0);
        assert!(!0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::is_spin_paused(arg2), 1);
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::update_spin_count(arg0, 1);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let v2 = if (v1 < 25) {
            1
        } else if (v1 < 48) {
            2
        } else if (v1 < 65) {
            3
        } else if (v1 < 75) {
            4
        } else if (v1 < 80) {
            5
        } else {
            6
        };
        let v3 = v2 - 1;
        let (v4, v5) = 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::add_spin_reward(arg0, arg3, arg1, v3, arg5);
        let v6 = SpinTheWheelEvent{
            dvd_id       : 0x2::object::id<0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_dvd::VendettaDVD>(arg0),
            reward_type  : v4,
            reward_value : v5,
            spinner      : 0x2::tx_context::sender(arg5),
            slot         : v3,
        };
        0x2::event::emit<SpinTheWheelEvent>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpinRegistry{
            id      : 0x2::object::new(arg0),
            chances : 0x2::vec_map::empty<u8, u8>(),
        };
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 1, 25);
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 2, 48);
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 3, 65);
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 4, 75);
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 5, 80);
        0x2::vec_map::insert<u8, u8>(&mut v0.chances, 6, 100);
        0x2::transfer::share_object<SpinRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

