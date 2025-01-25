module 0x52bd129f592aeb4dd2f75b721165d890c4f83840d808416a0aae74a2da78115::dao_config {
    struct GlobalDaoFee has key {
        id: 0x2::object::UID,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
        dao_fee_address: address,
    }

    struct GlobalDaoFeeChangedEvent has copy, drop {
        dao_fee_address: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    struct GlobalDaoFeeInitEvent has copy, drop {
        id: 0x2::object::ID,
        dao_fee_address: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    public(friend) fun get_dao_fee_config(arg0: &GlobalDaoFee) : (u64, u64, address) {
        (arg0.platform_fee_numerator, arg0.platform_fee_denominator, arg0.dao_fee_address)
    }

    public(friend) fun new_global_dao_fee_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalDaoFee{
            id                       : 0x2::object::new(arg0),
            platform_fee_numerator   : 100,
            platform_fee_denominator : 10000,
            dao_fee_address          : 0x2::tx_context::sender(arg0),
        };
        let v1 = 0x2::object::id<GlobalDaoFee>(&v0);
        let v2 = GlobalDaoFeeInitEvent{
            id                       : v1,
            dao_fee_address          : 0x2::tx_context::sender(arg0),
            platform_fee_numerator   : v0.platform_fee_numerator,
            platform_fee_denominator : v0.platform_fee_denominator,
        };
        0x2::event::emit<GlobalDaoFeeInitEvent>(v2);
        0x2::transfer::share_object<GlobalDaoFee>(v0);
        v1
    }

    public(friend) fun set_platform_fee(arg0: &mut GlobalDaoFee, arg1: u64, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        arg0.platform_fee_numerator = arg1;
        arg0.platform_fee_denominator = arg2;
        arg0.dao_fee_address = arg3;
        let v0 = GlobalDaoFeeChangedEvent{
            dao_fee_address          : arg3,
            platform_fee_numerator   : arg1,
            platform_fee_denominator : arg2,
        };
        0x2::event::emit<GlobalDaoFeeChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

