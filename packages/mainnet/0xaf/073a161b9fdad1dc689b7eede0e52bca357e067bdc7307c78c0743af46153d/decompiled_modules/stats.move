module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats {
    struct Stats has store, key {
        id: 0x2::object::UID,
        staked_amount: u64,
        unstaking_amount: u64,
    }

    public(friend) fun add_staked_amount(arg0: &mut Stats, arg1: u64) {
        arg0.staked_amount = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(arg0.staked_amount, arg1);
    }

    public(friend) fun add_unstaking_amount(arg0: &mut Stats, arg1: u64) {
        arg0.unstaking_amount = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(arg0.unstaking_amount, arg1);
    }

    public fun get_total_amounts(arg0: &Stats) : (u64, u64) {
        (arg0.staked_amount, arg0.unstaking_amount)
    }

    public fun get_total_staked_amount(arg0: &Stats) : u64 {
        arg0.staked_amount
    }

    public fun get_total_unstaking_amount(arg0: &Stats) : u64 {
        arg0.unstaking_amount
    }

    public fun init_stats(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            id               : 0x2::object::new(arg1),
            staked_amount    : 0,
            unstaking_amount : 0,
        };
        0x2::transfer::public_share_object<Stats>(v0);
    }

    public(friend) fun sub_staked_amount(arg0: &mut Stats, arg1: u64) {
        arg0.staked_amount = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(arg0.staked_amount, arg1);
    }

    public(friend) fun sub_unstaking_amount(arg0: &mut Stats, arg1: u64) {
        arg0.unstaking_amount = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(arg0.unstaking_amount, arg1);
    }

    // decompiled from Move bytecode v6
}

