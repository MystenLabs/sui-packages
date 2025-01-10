module 0xcec332da791450cfed3df7b7529b4e2346d56c25d53732470b685b631a80b268::dao_config {
    struct GlobalDaoFee has key {
        id: 0x2::object::UID,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    struct GlobalDaoFeeChangedEvent has copy, drop {
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    struct GlobalDaoFeeInitEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        platform_fee_numerator: u64,
        platform_fee_denominator: u64,
    }

    public(friend) fun get_dao_fee_config(arg0: &GlobalDaoFee) : (u64, u64) {
        (arg0.platform_fee_numerator, arg0.platform_fee_denominator)
    }

    public(friend) fun new_global_dao_fee_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalDaoFee{
            id                       : 0x2::object::new(arg0),
            platform_fee_numerator   : 1,
            platform_fee_denominator : 100,
        };
        let v1 = 0x2::object::id<GlobalDaoFee>(&v0);
        let v2 = GlobalDaoFeeInitEvent{
            id                       : v1,
            sender                   : 0x2::tx_context::sender(arg0),
            platform_fee_numerator   : v0.platform_fee_numerator,
            platform_fee_denominator : v0.platform_fee_denominator,
        };
        0x2::event::emit<GlobalDaoFeeInitEvent>(v2);
        0x2::transfer::share_object<GlobalDaoFee>(v0);
        v1
    }

    public(friend) fun set_platform_fee(arg0: &mut GlobalDaoFee, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.platform_fee_numerator = arg1;
        arg0.platform_fee_denominator = arg2;
        let v0 = GlobalDaoFeeChangedEvent{
            sender                   : 0x2::tx_context::sender(arg3),
            platform_fee_numerator   : arg1,
            platform_fee_denominator : arg2,
        };
        0x2::event::emit<GlobalDaoFeeChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

