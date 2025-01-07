module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::contributor {
    struct DevCap has store, key {
        id: 0x2::object::UID,
        shares: u64,
    }

    struct ContributorCap has key {
        id: 0x2::object::UID,
        shares: u64,
    }

    public(friend) fun deduct_shares(arg0: &mut ContributorCap) {
        assert!(arg0.shares > 0, 1);
        arg0.shares = arg0.shares - 1;
    }

    public fun get_shares(arg0: &ContributorCap) : u64 {
        arg0.shares
    }

    public fun give_shares_to(arg0: &mut DevCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.shares >= arg1, 0);
        arg0.shares = arg0.shares - arg1;
        let v0 = ContributorCap{
            id     : 0x2::object::new(arg3),
            shares : arg1,
        };
        0x2::transfer::transfer<ContributorCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DevCap{
            id     : 0x2::object::new(arg0),
            shares : 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::fortune_bag_supply(),
        };
        0x2::transfer::transfer<DevCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

