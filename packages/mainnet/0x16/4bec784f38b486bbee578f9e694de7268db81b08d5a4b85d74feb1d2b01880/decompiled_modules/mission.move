module 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::mission {
    public(friend) fun initialize_player_mission(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u64, arg10: u64, arg11: u64, arg12: u64) : 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionConfig {
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::new_mission_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, (arg7 as u128) * 0x1::u128::pow(2, 64), (arg8 as u128) * 0x1::u128::pow(2, 64), arg9, arg10, arg11, arg12)
    }

    public fun start_mission(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap, arg1: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::Version, arg2: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionRegistry, arg3: &mut 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionInfo, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (bool, vector<u64>, vector<u128>) {
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::validate_version(arg1);
        validate_mission_level(arg2, &arg4);
        let (v0, v1) = 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::borrow_current_mission_config(arg2, arg4);
        let v2 = v1;
        validate_player_level(arg7, *0x1::vector::borrow<u64>(&v2, 1));
        (0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::process_current_success_chance(arg3, arg2, arg4, arg5, arg6, arg8), v2, v0)
    }

    public(friend) fun validate_level(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionRegistry, arg1: &u64) {
        assert!(!0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::has_level_config(arg0, arg1), 1);
    }

    public(friend) fun validate_mission_level(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::MissionRegistry, arg1: &u64) {
        assert!(0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::imission::has_level_config(arg0, arg1), 0);
    }

    public(friend) fun validate_player_level(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 3);
    }

    public fun validate_player_mission_info(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 == arg1, 2);
    }

    // decompiled from Move bytecode v6
}

