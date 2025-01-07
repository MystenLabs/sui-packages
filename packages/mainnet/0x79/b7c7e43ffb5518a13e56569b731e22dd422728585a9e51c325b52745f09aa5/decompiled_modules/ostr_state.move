module 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state {
    struct State has store, key {
        id: 0x2::object::UID,
        pearl_minter: 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>,
        balances: 0x2::table::Table<address, u64>,
        total_supply: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            id           : 0x2::object::new(arg0),
            pearl_minter : 0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::create_member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>(arg0),
            balances     : 0x2::table::new<address, u64>(arg0),
            total_supply : 0,
        }
    }

    public fun assert_not_registerd(arg0: &State, arg1: address) {
        assert!(!0x2::table::contains<address, u64>(&arg0.balances, arg1), 1);
    }

    public fun assert_registerd(arg0: &State, arg1: address) {
        assert!(0x2::table::contains<address, u64>(&arg0.balances, arg1), 0);
    }

    public fun borrow_balances(arg0: &State) : &0x2::table::Table<address, u64> {
        &arg0.balances
    }

    public(friend) fun borrow_mut_balances(arg0: &mut State) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.balances
    }

    public(friend) fun borrow_pearl_minter(arg0: &State) : &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE> {
        &arg0.pearl_minter
    }

    public(friend) fun decrease_supply(arg0: &mut State, arg1: u64) {
        assert!(arg0.total_supply >= arg1, 2);
        arg0.total_supply = arg0.total_supply - arg1;
    }

    public(friend) fun increase_supply(arg0: &mut State, arg1: u64) {
        assert!(arg1 < 18446744073709551615 - arg0.total_supply, 2);
        arg0.total_supply = arg0.total_supply + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<State>(new(arg0));
    }

    public fun is_registerd(arg0: &State, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.balances, arg1)
    }

    public fun register(arg0: &mut State, arg1: address) {
        assert_not_registerd(arg0, arg1);
        0x2::table::add<address, u64>(&mut arg0.balances, arg1, 0);
    }

    public fun total_supply(arg0: &State) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

