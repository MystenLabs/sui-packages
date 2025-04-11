module 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::participation {
    struct Participation has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
        last_updated_epoch: u64,
        stake: u64,
        pending_stake: u64,
        claimable_balance: u64,
        unstake_requested: bool,
    }

    struct ParticipationCreatedEvent has copy, drop {
        participation_id: 0x2::object::ID,
    }

    struct ParticipationRemovedEvent has copy, drop {
        participation_id: 0x2::object::ID,
    }

    struct StakeAddedEvent has copy, drop {
        participation_id: 0x2::object::ID,
        amount: u64,
        pending: bool,
    }

    struct StakeRemovedEvent has copy, drop {
        participation_id: 0x2::object::ID,
        amount: u64,
        pending_stake_removed: u64,
    }

    struct ParticipationEndOfDayProcessedEvent has copy, drop {
        participation_id: 0x2::object::ID,
        profits: u64,
        losses: u64,
    }

    public(friend) fun empty(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Participation {
        let v0 = Participation{
            id                 : 0x2::object::new(arg1),
            house_id           : arg0,
            last_updated_epoch : 0x2::tx_context::epoch(arg1),
            stake              : 0,
            pending_stake      : 0,
            claimable_balance  : 0,
            unstake_requested  : false,
        };
        let v1 = ParticipationCreatedEvent{participation_id: id(&v0)};
        0x2::event::emit<ParticipationCreatedEvent>(v1);
        v0
    }

    public fun destroy_empty(arg0: Participation, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.last_updated_epoch == 0x2::tx_context::epoch(arg1), 3);
        assert!(arg0.stake == 0, 6);
        assert!(arg0.claimable_balance == 0, 6);
        let Participation {
            id                 : v0,
            house_id           : _,
            last_updated_epoch : _,
            stake              : _,
            pending_stake      : _,
            claimable_balance  : _,
            unstake_requested  : _,
        } = arg0;
        let v7 = v0;
        let v8 = ParticipationRemovedEvent{participation_id: 0x2::object::uid_to_inner(&v7)};
        0x2::event::emit<ParticipationRemovedEvent>(v8);
        0x2::object::delete(v7);
    }

    public(friend) fun add_stake(arg0: &mut Participation, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.last_updated_epoch == 0x2::tx_context::epoch(arg3), 3);
        assert!(arg0.unstake_requested == false, 2);
        if (arg2) {
            arg0.pending_stake = arg0.pending_stake + arg1;
        } else {
            arg0.stake = arg0.stake + arg1;
        };
        let v0 = StakeAddedEvent{
            participation_id : id(arg0),
            amount           : arg1,
            pending          : arg2,
        };
        0x2::event::emit<StakeAddedEvent>(v0);
    }

    public(friend) fun claim_all(arg0: &mut Participation, arg1: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.last_updated_epoch == 0x2::tx_context::epoch(arg1), 3);
        arg0.claimable_balance = 0;
        arg0.claimable_balance
    }

    public fun claimable_balance(arg0: &Participation) : u64 {
        arg0.claimable_balance
    }

    public(friend) fun current_state(arg0: &Participation) : (u64, u64, u64) {
        (arg0.last_updated_epoch, arg0.stake, arg0.pending_stake)
    }

    public fun house_id(arg0: &Participation) : 0x2::object::ID {
        arg0.house_id
    }

    public fun id(arg0: &Participation) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun last_updated_epoch(arg0: &Participation) : u64 {
        arg0.last_updated_epoch
    }

    public fun pending_stake(arg0: &Participation) : u64 {
        arg0.pending_stake
    }

    public(friend) fun process_end_of_day(arg0: &mut Participation, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg3 == 0, 1);
        assert!(arg0.last_updated_epoch == arg1, 3);
        assert!(0x2::tx_context::epoch(arg4) > arg0.last_updated_epoch, 4);
        if (arg2 > 0) {
            arg0.stake = arg0.stake + arg2;
        } else if (arg3 > 0) {
            if (arg0.stake >= arg3) {
                arg0.stake = arg0.stake - arg3;
            } else {
                assert!(arg3 - arg0.stake <= 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::precision_error_allowance(), 5);
                arg0.stake = 0;
            };
        };
        if (arg0.unstake_requested) {
            arg0.claimable_balance = arg0.claimable_balance + arg0.stake;
            arg0.stake = 0;
        };
        arg0.stake = arg0.stake + arg0.pending_stake;
        arg0.pending_stake = 0;
        arg0.unstake_requested = false;
        arg0.last_updated_epoch = arg0.last_updated_epoch + 1;
        let v0 = ParticipationEndOfDayProcessedEvent{
            participation_id : id(arg0),
            profits          : arg2,
            losses           : arg3,
        };
        0x2::event::emit<ParticipationEndOfDayProcessedEvent>(v0);
    }

    public fun stake(arg0: &Participation) : u64 {
        arg0.stake
    }

    public(friend) fun unstake(arg0: &mut Participation, arg1: bool, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.unstake_requested == false, 2);
        assert!(arg0.last_updated_epoch == 0x2::tx_context::epoch(arg2), 3);
        let v0 = arg0.stake;
        if (arg1) {
            arg0.unstake_requested = true;
        } else {
            arg0.claimable_balance = arg0.claimable_balance + arg0.stake;
            arg0.stake = 0;
        };
        let v1 = arg0.pending_stake;
        arg0.claimable_balance = arg0.claimable_balance + v1;
        arg0.pending_stake = 0;
        let v2 = StakeRemovedEvent{
            participation_id      : id(arg0),
            amount                : v0,
            pending_stake_removed : v1,
        };
        0x2::event::emit<StakeRemovedEvent>(v2);
        (v0, v1)
    }

    public fun unstake_requested(arg0: &Participation) : bool {
        arg0.unstake_requested
    }

    // decompiled from Move bytecode v6
}

