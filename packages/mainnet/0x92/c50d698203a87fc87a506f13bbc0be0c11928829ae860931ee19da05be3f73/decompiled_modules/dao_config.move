module 0x92c50d698203a87fc87a506f13bbc0be0c11928829ae860931ee19da05be3f73::dao_config {
    struct GlobalDaoFee has key {
        id: 0x2::object::UID,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
        hurdle_rate_numerator: u64,
        hurdle_rate_denominator: u64,
        carried_interest_numerator: u64,
        carried_interest_denominator: u64,
    }

    struct SetGlobalDaoFeeEvent has copy, drop {
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
        hurdle_rate_numerator: u64,
        hurdle_rate_denominator: u64,
        carried_interest_numerator: u64,
        carried_interest_denominator: u64,
    }

    struct GlobalDaoFeeInitEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
        hurdle_rate_numerator: u64,
        hurdle_rate_denominator: u64,
        carried_interest_numerator: u64,
        carried_interest_denominator: u64,
    }

    public(friend) fun get_dao_fee_config(arg0: &GlobalDaoFee) : (u64, u64, u64, u64, u64, u64) {
        (arg0.platform_fee_numerator, arg0.platform_fee_denominator, arg0.hurdle_rate_numerator, arg0.hurdle_rate_denominator, arg0.carried_interest_numerator, arg0.carried_interest_denominator)
    }

    public(friend) fun new_global_dao_fee_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalDaoFee{
            id                           : 0x2::object::new(arg0),
            platform_fee_numerator       : 1,
            platform_fee_denominator     : 100,
            hurdle_rate_numerator        : 5,
            hurdle_rate_denominator      : 100,
            carried_interest_numerator   : 15,
            carried_interest_denominator : 100,
        };
        let v1 = 0x2::object::id<GlobalDaoFee>(&v0);
        let v2 = GlobalDaoFeeInitEvent{
            id                           : v1,
            sender                       : 0x2::tx_context::sender(arg0),
            platform_fee_numerator       : v0.platform_fee_numerator,
            platform_fee_denominator     : v0.platform_fee_denominator,
            hurdle_rate_numerator        : v0.hurdle_rate_numerator,
            hurdle_rate_denominator      : v0.hurdle_rate_denominator,
            carried_interest_numerator   : v0.carried_interest_numerator,
            carried_interest_denominator : v0.carried_interest_denominator,
        };
        0x2::event::emit<GlobalDaoFeeInitEvent>(v2);
        0x2::transfer::share_object<GlobalDaoFee>(v0);
        v1
    }

    public(friend) fun set_dao_fee_config(arg0: &mut GlobalDaoFee, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        arg0.platform_fee_numerator = arg1;
        arg0.platform_fee_denominator = arg2;
        arg0.hurdle_rate_numerator = arg3;
        arg0.hurdle_rate_denominator = arg4;
        arg0.carried_interest_numerator = arg5;
        arg0.carried_interest_denominator = arg6;
        let v0 = SetGlobalDaoFeeEvent{
            sender                       : 0x2::tx_context::sender(arg7),
            platform_fee_numerator       : arg1,
            platform_fee_denominator     : arg2,
            hurdle_rate_numerator        : arg3,
            hurdle_rate_denominator      : arg4,
            carried_interest_numerator   : arg5,
            carried_interest_denominator : arg6,
        };
        0x2::event::emit<SetGlobalDaoFeeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

