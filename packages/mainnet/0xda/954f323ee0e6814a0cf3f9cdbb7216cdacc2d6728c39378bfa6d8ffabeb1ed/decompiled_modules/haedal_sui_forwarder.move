module 0xda954f323ee0e6814a0cf3f9cdbb7216cdacc2d6728c39378bfa6d8ffabeb1ed::haedal_sui_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        hasui: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        staking_id: 0x2::object::ID,
        principal_mist: u64,
        hasui_amount: u64,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        staking_id: 0x2::object::ID,
        principal_mist: u64,
        hasui_amount: u64,
    }

    struct Withdrawn has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        staking_id: 0x2::object::ID,
        principal_mist: u64,
        hasui_amount: u64,
        measured_return_mist: u64,
    }

    struct HasuiRecovered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        staking_id: 0x2::object::ID,
        principal_mist: u64,
        hasui_amount: u64,
    }

    fun assert_deposit_authority(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        assert!(0x2::object::id_address<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg0) == @0x47b224762220393057ebf4f70501b6e657c3e56684737568439a04f80849b2ca, 5);
    }

    fun assert_exit_authority(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: &Position, arg2: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg1, 0x2::tx_context::sender(arg2));
        assert!(!arg1.record.closed, 7);
        assert!(0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg0) == arg1.record.staking_id, 5);
        assert!(0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1.hasui) == arg1.record.hasui_amount, 13);
        assert!(arg1.record.hasui_amount > 0, 13);
    }

    fun assert_nonzero_owner(arg0: address) {
        assert!(arg0 != @0x0, 11);
    }

    fun assert_nonzero_principal(arg0: u64) {
        assert!(arg0 > 0, 9);
    }

    fun assert_recorded_owner(arg0: &Position, arg1: address) {
        assert!(arg1 == arg0.record.owner, 6);
    }

    fun close_position(arg0: &mut Position) : address {
        arg0.record.closed = true;
        arg0.record.payout_destination
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun deposit_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        deposit_sui_for_owner(arg0, arg1, arg2, v0, arg3);
    }

    public fun deposit_sui_for_owner(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority(arg1);
        assert_nonzero_owner(arg3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_nonzero_principal(v0);
        assert!(v0 >= 1000000000, 12);
        let v1 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_stake_coin(arg0, arg1, arg2, @0x0, arg4);
        let v2 = 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1);
        assert!(v2 > 0, 13);
        let v3 = 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1);
        let v4 = PositionRecord{
            owner              : arg3,
            payout_destination : arg3,
            staking_id         : v3,
            principal_mist     : v0,
            hasui_amount       : v2,
            closed             : false,
        };
        let v5 = Position{
            id     : 0x2::object::new(arg4),
            record : v4,
            hasui  : 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1),
        };
        let v6 = Deposited{
            position_id    : 0x2::object::id<Position>(&v5),
            owner          : arg3,
            staking_id     : v3,
            principal_mist : v0,
            hasui_amount   : v2,
        };
        0x2::event::emit<Deposited>(v6);
        0x2::transfer::transfer<Position>(v5, arg3);
    }

    public fun hasui_amount(arg0: &Position) : u64 {
        arg0.record.hasui_amount
    }

    public fun min_stake_mist() : u64 {
        1000000000
    }

    public fun owner(arg0: &Position) : address {
        arg0.record.owner
    }

    public fun payout_destination(arg0: &Position) : address {
        arg0.record.payout_destination
    }

    public fun principal_mist(arg0: &Position) : u64 {
        arg0.record.principal_mist
    }

    public fun recover_hasui(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        assert!(!arg0.record.closed, 7);
        let v0 = arg0.record.hasui_amount;
        let v1 = 0x2::balance::withdraw_all<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.hasui);
        assert!(0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1) == v0, 13);
        let v2 = arg0.record.owner;
        let v3 = 0x2::object::id<Position>(arg0);
        let v4 = arg0.record.staking_id;
        let v5 = arg0.record.principal_mist;
        close_position(arg0);
        let v6 = HasuiRecovered{
            position_id    : v3,
            owner          : v2,
            staking_id     : v4,
            principal_mist : v5,
            hasui_amount   : v0,
        };
        0x2::event::emit<HasuiRecovered>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>>(0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg1), v2);
    }

    public fun staking_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.staking_id
    }

    public fun withdraw_all_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &mut Position, arg3: &mut 0x2::tx_context::TxContext) {
        assert_exit_authority(arg1, arg2, arg3);
        let v0 = arg2.record.hasui_amount;
        let v1 = 0x2::balance::withdraw_all<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg2.hasui);
        assert!(0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v1) == v0, 13);
        let v2 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::request_unstake_instant_coin(arg0, arg1, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v1, arg3), arg3);
        let v3 = close_position(arg2);
        let v4 = Withdrawn{
            position_id          : 0x2::object::id<Position>(arg2),
            owner                : arg2.record.owner,
            payout_destination   : v3,
            staking_id           : arg2.record.staking_id,
            principal_mist       : arg2.record.principal_mist,
            hasui_amount         : v0,
            measured_return_mist : 0x2::coin::value<0x2::sui::SUI>(&v2),
        };
        0x2::event::emit<Withdrawn>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v3);
    }

    // decompiled from Move bytecode v7
}

