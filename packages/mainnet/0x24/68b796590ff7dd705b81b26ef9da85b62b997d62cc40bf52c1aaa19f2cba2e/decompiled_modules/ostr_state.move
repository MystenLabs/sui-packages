module 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state {
    struct State has store, key {
        id: 0x2::object::UID,
        pearl_minter: 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>,
        balances: 0x2::table::Table<address, u64>,
        total_supply: u64,
    }

    struct WrappedPearlMinterDfKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            id           : 0x2::object::new(arg0),
            pearl_minter : 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>(arg0),
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

    public(friend) fun borrow_pearl_minter(arg0: &State) : &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE> {
        &arg0.pearl_minter
    }

    public(friend) fun borrow_wrapped_prl_minter(arg0: &State) : &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE> {
        let v0 = WrappedPearlMinterDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<WrappedPearlMinterDfKey, 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>>(&arg0.id, v0)
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

    entry fun init_wrapped_prl_minter(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedPearlMinterDfKey{dummy_field: false};
        0x2::dynamic_field::add<WrappedPearlMinterDfKey, 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>>(&mut arg0.id, v0, 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_member<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>(arg1));
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

