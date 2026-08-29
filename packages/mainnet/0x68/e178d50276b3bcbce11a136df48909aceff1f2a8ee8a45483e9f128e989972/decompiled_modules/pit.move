module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit {
    struct Pit<phantom T0> has key {
        id: 0x2::object::UID,
        pot: 0x2::balance::Balance<T0>,
        round: u64,
        round_end_ms: u64,
        leader_id: 0x1::option::Option<0x2::object::ID>,
        leader_metric: u64,
        winner_id: 0x1::option::Option<0x2::object::ID>,
        settled: bool,
    }

    public fun id<T0>(arg0: &Pit<T0>) : 0x2::object::ID {
        0x2::object::id<Pit<T0>>(arg0)
    }

    public(friend) fun create_and_share<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pit<T0>{
            id            : 0x2::object::new(arg0),
            pot           : 0x2::balance::zero<T0>(),
            round         : 1,
            round_end_ms  : 0,
            leader_id     : 0x1::option::none<0x2::object::ID>(),
            leader_metric : 0,
            winner_id     : 0x1::option::none<0x2::object::ID>(),
            settled       : true,
        };
        0x2::transfer::share_object<Pit<T0>>(v0);
    }

    public fun create_pit<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        create_and_share<T0>(arg0);
    }

    public fun leader_id<T0>(arg0: &Pit<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.leader_id
    }

    public fun leader_metric<T0>(arg0: &Pit<T0>) : u64 {
        arg0.leader_metric
    }

    public fun nudge<T0>(arg0: &mut Pit<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        if (arg3) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        if (arg0.round_end_ms == 0) {
            arg0.round_end_ms = v0 + arg4;
        };
        if (v0 >= arg0.round_end_ms) {
            return
        };
        if (arg2 > arg0.leader_metric) {
            arg0.leader_id = 0x1::option::some<0x2::object::ID>(arg1);
            arg0.leader_metric = arg2;
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_pit_nudge(arg1, arg2, arg0.round);
        };
    }

    public fun pot_value<T0>(arg0: &Pit<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun ring<T0>(arg0: &mut Pit<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.round_end_ms > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::round_not_started());
        assert!(v0 >= arg0.round_end_ms, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::too_early());
        assert!(arg0.settled, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::unsettled_winner());
        let v1 = arg0.leader_id;
        arg0.winner_id = v1;
        arg0.settled = 0x1::option::is_none<0x2::object::ID>(&v1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_bell(v1, arg0.round, 0x2::balance::value<T0>(&arg0.pot));
        arg0.round = arg0.round + 1;
        arg0.round_end_ms = v0 + arg1;
        arg0.leader_id = 0x1::option::none<0x2::object::ID>();
        arg0.leader_metric = 0;
    }

    public fun round<T0>(arg0: &Pit<T0>) : u64 {
        arg0.round
    }

    public fun round_end_ms<T0>(arg0: &Pit<T0>) : u64 {
        arg0.round_end_ms
    }

    public fun settle_burn_quote<T0>(arg0: &mut Pit<T0>, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        take_pot<T0>(arg0, arg1, 1)
    }

    public fun settle_to_holders<T0>(arg0: &mut Pit<T0>, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        take_pot<T0>(arg0, arg1, 0)
    }

    public fun settled<T0>(arg0: &Pit<T0>) : bool {
        arg0.settled
    }

    public fun take_fee<T0>(arg0: &mut Pit<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.pot, arg1);
    }

    fun take_pot<T0>(arg0: &mut Pit<T0>, arg1: 0x2::object::ID, arg2: u8) : 0x2::balance::Balance<T0> {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.winner_id), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_winner());
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.winner_id) == arg1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_winner());
        assert!(!arg0.settled, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::already_settled());
        arg0.settled = true;
        let v0 = 0x2::balance::value<T0>(&arg0.pot);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_pit_settle(arg1, v0, arg2);
        0x2::balance::split<T0>(&mut arg0.pot, v0)
    }

    public fun winner_id<T0>(arg0: &Pit<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.winner_id
    }

    // decompiled from Move bytecode v7
}

