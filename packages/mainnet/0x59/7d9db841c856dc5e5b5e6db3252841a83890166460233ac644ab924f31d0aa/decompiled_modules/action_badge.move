module 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action_badge {
    struct ACTION_BADGE has drop {
        dummy_field: bool,
    }

    struct ActionBadge has store, key {
        id: 0x2::object::UID,
        action_id: 0x2::object::ID,
        earned_by: address,
        earned_ts: u64,
    }

    public(friend) fun new(arg0: &0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ActionBadge {
        ActionBadge{
            id        : 0x2::object::new(arg2),
            action_id : 0x2::object::id<0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action::Action>(arg0),
            earned_by : 0x2::tx_context::sender(arg2),
            earned_ts : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun earned_by(arg0: &ActionBadge) : address {
        arg0.earned_by
    }

    public fun earned_ts(arg0: &ActionBadge) : u64 {
        arg0.earned_ts
    }

    fun init(arg0: ACTION_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ACTION_BADGE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

