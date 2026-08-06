module 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::adventure {
    struct Adventure has key {
        id: 0x2::object::UID,
        game_battle: vector<u64>,
        payout_vector: vector<u64>,
        unlock_percentage: vector<u64>,
        start_stake_amount: u64,
        total_stake_amount: u64,
        locked_stake_amount: u64,
        unlocked_stake_amount: u64,
        is_active: bool,
    }

    struct EndAdventureEvent has copy, drop {
        player: address,
        bet_size: u64,
        locked_stake_amount: u64,
        unlocked_stake_amount: u64,
    }

    public fun create_adventure_with_unlock(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Adventure {
        Adventure{
            id                    : 0x2::object::new(arg3),
            game_battle           : vector[],
            payout_vector         : vector[],
            unlock_percentage     : vector[],
            start_stake_amount    : arg2,
            total_stake_amount    : arg2,
            locked_stake_amount   : arg1,
            unlocked_stake_amount : arg0,
            is_active             : true,
        }
    }

    public fun end_adventure(arg0: Adventure, arg1: &0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UpAdmin, arg2: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::UPTreasury, arg3: &mut 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::XUPState, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>> {
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::assert_valid_version(arg1);
        let Adventure {
            id                    : v0,
            game_battle           : _,
            payout_vector         : _,
            unlock_percentage     : _,
            start_stake_amount    : v4,
            total_stake_amount    : _,
            locked_stake_amount   : v6,
            unlocked_stake_amount : v7,
            is_active             : _,
        } = arg0;
        0x2::object::delete(v0);
        let v9 = EndAdventureEvent{
            player                : 0x2::tx_context::sender(arg4),
            bet_size              : v4,
            locked_stake_amount   : v6,
            unlocked_stake_amount : v7,
        };
        0x2::event::emit<EndAdventureEvent>(v9);
        0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::set_amount(arg3, 0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::get_amount(arg3) + v6);
        if (v7 > 0) {
            return 0x1::option::some<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>(0x2::coin::from_balance<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(0x2::balance::split<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>(0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::x_up::borrow_balance_mut(arg2), v7), arg4))
        };
        0x1::option::none<0x2::coin::Coin<0x1dbad50d3370999e65208da2face5af90f5443b6b63d20953a7f14d8ee018c91::up::UP>>()
    }

    // decompiled from Move bytecode v7
}

