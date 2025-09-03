module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::bounty {
    public fun add_additional_bounty(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128) {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_valid_player(arg2, arg3), 1);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_assigner(arg1, arg2, arg3), 5);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::add_additional_bounty(arg1, arg2, arg3, arg4);
    }

    public fun claim_reward(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : u128 {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::borrow_winner_id(arg1, arg3) == arg2, 1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::claim_reward(arg1, arg3)
    }

    public fun close_bounty(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : u128 {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_assigner(arg1, arg2, arg3), 1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::close_bounty(arg1, arg2, arg3)
    }

    public fun create_bounty_session(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128, arg5: &0x2::clock::Clock) {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(arg4 >= 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::min_bounty(arg1), 4);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_valid_player(arg2, arg3), 1);
        if (0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::has_target_player(arg1, arg3)) {
            assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::max_count(arg1, arg3) < 5, 4);
        };
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::create_bounty_session(arg1, arg2, arg3, arg4, arg5);
    }

    public fun evaluate_winner(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) : u128 {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_attack(arg1, arg2), 3);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::evaluate_winner(arg1, arg2, arg3, arg4)
    }

    public fun initialize_magazine(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::LucaCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::initialize_magazine(arg1, 0x2::object::id_from_address(0x2::tx_context::sender(arg2)), arg2)
    }

    public fun pay_off_bounty(arg0: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u128) {
        assert!(arg4 == 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::borrow_bounty_amount(arg0, arg2, arg3), 6);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_assigner(arg0, arg3, arg2), 5);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::pay_off_bounty(arg0, arg2, arg3);
    }

    public fun set_magazine(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::LucaCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::MagazineInfo, arg2: vector<u8>) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_magazine(arg1, arg2);
    }

    public fun shoot(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::CrimesCap, arg1: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(!0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_paused(arg1), 0);
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_bounty_waiting(arg1, arg3), 2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::shoot(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

