module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::governance {
    struct Proposal has copy, drop, store {
        taker_fee: u64,
        maker_fee: u64,
        stake_required: u64,
        votes: u64,
    }

    struct Governance has store {
        epoch: u64,
        whitelisted: bool,
        stable: bool,
        proposals: 0x2::vec_map::VecMap<0x2::object::ID, Proposal>,
        trade_params: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams,
        next_trade_params: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams,
        voting_power: u64,
        quorum: u64,
    }

    struct TradeParamsUpdateEvent has copy, drop {
        taker_fee: u64,
        maker_fee: u64,
        stake_required: u64,
    }

    public(friend) fun empty(arg0: bool, arg1: &0x2::tx_context::TxContext) : Governance {
        let v0 = if (arg0) {
            100000
        } else {
            1000000
        };
        let v1 = if (arg0) {
            50000
        } else {
            500000
        };
        Governance{
            epoch             : 0x2::tx_context::epoch(arg1),
            whitelisted       : false,
            stable            : arg0,
            proposals         : 0x2::vec_map::empty<0x2::object::ID, Proposal>(),
            trade_params      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(v0, v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::default_stake_required()),
            next_trade_params : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(v0, v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::default_stake_required()),
            voting_power      : 0,
            quorum            : 0,
        }
    }

    public(friend) fun add_proposal(arg0: &mut Governance, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::object::ID) {
        assert!(!arg0.whitelisted, 5);
        assert!(arg1 % 1000 == 0, 2);
        assert!(arg2 % 1000 == 0, 1);
        if (arg0.stable) {
            assert!(arg1 >= 50000 && arg1 <= 100000, 2);
            assert!(arg2 >= 20000 && arg2 <= 50000, 1);
        } else {
            assert!(arg1 >= 500000 && arg1 <= 1000000, 2);
            assert!(arg2 >= 200000 && arg2 <= 500000, 1);
        };
        if (0x2::vec_map::size<0x2::object::ID, Proposal>(&arg0.proposals) == 100) {
            remove_lowest_proposal(arg0, stake_to_voting_power(arg4));
        };
        0x2::vec_map::insert<0x2::object::ID, Proposal>(&mut arg0.proposals, arg5, new_proposal(arg1, arg2, arg3));
    }

    public(friend) fun adjust_vote(arg0: &mut Governance, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64) {
        let v0 = stake_to_voting_power(arg3);
        if (0x1::option::is_some<0x2::object::ID>(&arg1) && 0x2::vec_map::contains<0x2::object::ID, Proposal>(&arg0.proposals, 0x1::option::borrow<0x2::object::ID>(&arg1))) {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, 0x1::option::borrow<0x2::object::ID>(&arg1));
            v1.votes = v1.votes - v0;
            if (v1.votes + v0 > arg0.quorum && v1.votes < arg0.quorum) {
                arg0.next_trade_params = arg0.trade_params;
            };
        };
        let v2 = &arg2;
        if (0x1::option::is_some<0x2::object::ID>(v2)) {
            let v3 = 0x1::option::borrow<0x2::object::ID>(v2);
            assert!(0x2::vec_map::contains<0x2::object::ID, Proposal>(&arg0.proposals, v3), 3);
            let v4 = 0x2::vec_map::get_mut<0x2::object::ID, Proposal>(&mut arg0.proposals, v3);
            v4.votes = v4.votes + v0;
            if (v4.votes > arg0.quorum) {
                arg0.next_trade_params = to_trade_params(v4);
            };
        };
    }

    public(friend) fun adjust_voting_power(arg0: &mut Governance, arg1: u64, arg2: u64) {
        arg0.voting_power = arg0.voting_power + stake_to_voting_power(arg2) - stake_to_voting_power(arg1);
    }

    fun new_proposal(arg0: u64, arg1: u64, arg2: u64) : Proposal {
        Proposal{
            taker_fee      : arg0,
            maker_fee      : arg1,
            stake_required : arg2,
            votes          : 0,
        }
    }

    fun remove_lowest_proposal(arg0: &mut Governance, arg1: u64) {
        let v0 = 0x1::option::none<0x2::object::ID>();
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64();
        let (v2, v3) = 0x2::vec_map::into_keys_values<0x2::object::ID, Proposal>(arg0.proposals);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0;
        while (v6 < 0x2::vec_map::size<0x2::object::ID, Proposal>(&arg0.proposals)) {
            v1 = 0x1::vector::borrow<Proposal>(&v4, v6).votes;
            if (v1 < arg1 && v1 <= v1) {
                v0 = 0x1::option::some<0x2::object::ID>(*0x1::vector::borrow<0x2::object::ID>(&v5, v6));
            };
            v6 = v6 + 1;
        };
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 4);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, Proposal>(&mut arg0.proposals, 0x1::option::borrow<0x2::object::ID>(&v0));
    }

    fun reset_trade_params(arg0: &mut Governance) {
        arg0.proposals = 0x2::vec_map::empty<0x2::object::ID, Proposal>();
        if (arg0.whitelisted) {
            arg0.trade_params = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(0, 0, 0);
        } else if (arg0.stable) {
            arg0.trade_params = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(100000, 50000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::stake_required(&arg0.trade_params));
        } else {
            arg0.trade_params = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(1000000, 500000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::stake_required(&arg0.trade_params));
        };
        arg0.next_trade_params = arg0.trade_params;
    }

    public(friend) fun set_whitelist(arg0: &mut Governance, arg1: bool) {
        arg0.whitelisted = arg1;
        reset_trade_params(arg0);
    }

    fun stake_to_voting_power(arg0: u64) : u64 {
        let v0 = 0x1::u64::min(arg0, 100000000000);
        let v1 = v0;
        if (arg0 > 100000000000) {
            v1 = v0 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::sqrt(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::deep_unit()) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::sqrt(100000000000, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::deep_unit());
        };
        v1
    }

    fun to_trade_params(arg0: &Proposal) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::new(arg0.taker_fee, arg0.maker_fee, arg0.stake_required)
    }

    public(friend) fun trade_params(arg0: &Governance) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::TradeParams {
        arg0.trade_params
    }

    public(friend) fun update(arg0: &mut Governance, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (arg0.epoch == v0) {
            return
        };
        arg0.epoch = v0;
        arg0.quorum = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0.voting_power, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::half());
        arg0.proposals = 0x2::vec_map::empty<0x2::object::ID, Proposal>();
        arg0.trade_params = arg0.next_trade_params;
        let v1 = TradeParamsUpdateEvent{
            taker_fee      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::taker_fee(&arg0.trade_params),
            maker_fee      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::maker_fee(&arg0.trade_params),
            stake_required : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::trade_params::stake_required(&arg0.trade_params),
        };
        0x2::event::emit<TradeParamsUpdateEvent>(v1);
    }

    public(friend) fun whitelisted(arg0: &Governance) : bool {
        arg0.whitelisted
    }

    // decompiled from Move bytecode v6
}

