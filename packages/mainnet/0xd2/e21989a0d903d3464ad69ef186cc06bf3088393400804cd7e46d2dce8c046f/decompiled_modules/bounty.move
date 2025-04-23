module 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::bounty {
    struct BountyRegistry has key {
        id: 0x2::object::UID,
        target: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        v_allocation: 0x2::vec_map::VecMap<0x1::string::String, u8>,
    }

    struct BountyShootEvent has copy, drop {
        points_earned: u8,
        player: address,
        random_value: u8,
        has_won: bool,
    }

    public fun add_target_config(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut BountyRegistry, arg4: 0x1::string::String, arg5: u8, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg7), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        assert!(!0x2::vec_map::contains<0x1::string::String, u8>(&arg3.target, &arg4), 0);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut arg3.target, arg4, arg5);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut arg3.v_allocation, arg4, arg6);
    }

    public fun initialize_bounty_registry(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg3), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        let v0 = BountyRegistry{
            id           : 0x2::object::new(arg3),
            target       : 0x2::vec_map::empty<0x1::string::String, u8>(),
            v_allocation : 0x2::vec_map::empty<0x1::string::String, u8>(),
        };
        0x2::transfer::share_object<BountyRegistry>(v0);
    }

    entry fun shoot(arg0: &BountyRegistry, arg1: &mut 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::QuestRegistry, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: 0x1::string::String, arg4: &mut 0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::QuestTicket, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg0.target, &arg3), 2);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::decrease_ticket_count(arg4);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::validate_quest_status(arg1);
        let v0 = false;
        let v1 = 0x2::random::new_generator(arg5, arg6);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 1, 100);
        let v3 = if (v2 < *0x2::vec_map::get<0x1::string::String, u8>(&arg0.target, &arg3)) {
            v0 = true;
            *0x2::vec_map::get<0x1::string::String, u8>(&arg0.v_allocation, &arg3)
        } else {
            0
        };
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::quest::add_current_quest_point(arg1, (v3 as u64));
        let v4 = BountyShootEvent{
            points_earned : v3,
            player        : 0x2::tx_context::sender(arg6),
            random_value  : v2,
            has_won       : v0,
        };
        0x2::event::emit<BountyShootEvent>(v4);
    }

    public fun update_target_config(arg0: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCap, arg1: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::OperatorCapsBag, arg2: &0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::Version, arg3: &mut BountyRegistry, arg4: 0x1::string::String, arg5: u8, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg7), arg1);
        0x26dbda3f935362da3b6ad85abce3bc90b95507c156cc7d8a9c17f441ecfcb605::version::validate_version(arg2, 2);
        assert!(0x2::vec_map::contains<0x1::string::String, u8>(&arg3.target, &arg4), 1);
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg3.target, &arg4) = arg5;
        *0x2::vec_map::get_mut<0x1::string::String, u8>(&mut arg3.v_allocation, &arg4) = arg6;
    }

    // decompiled from Move bytecode v6
}

