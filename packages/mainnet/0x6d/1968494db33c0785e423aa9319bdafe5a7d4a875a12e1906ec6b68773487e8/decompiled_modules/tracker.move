module 0x14f915a6c158f8ee8701f29646433b2a9be52e32ab01cf1b48272761b4c9ce06::tracker {
    struct Tracker has store, key {
        id: 0x2::object::UID,
        deposits: u64,
        withdrawals: u64,
        last_update: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Tracker {
        Tracker{
            id          : 0x2::object::new(arg0),
            deposits    : 0,
            withdrawals : 0,
            last_update : 0,
        }
    }

    public(friend) fun deposit(arg0: &mut Tracker, arg1: u64, arg2: u64) {
        arg0.deposits = arg0.deposits + arg1;
        arg0.last_update = arg2;
    }

    public(friend) fun withdraw(arg0: &mut Tracker, arg1: u64, arg2: u64) {
        arg0.withdrawals = arg0.withdrawals + arg1;
        arg0.last_update = arg2;
    }

    // decompiled from Move bytecode v6
}

