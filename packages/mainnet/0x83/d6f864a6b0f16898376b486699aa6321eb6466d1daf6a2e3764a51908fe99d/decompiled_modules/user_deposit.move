module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit {
    struct UserDeposit<phantom T0> has store, key {
        id: 0x2::object::UID,
        lp_amount: u64,
        reward_debt: u64,
    }

    public(friend) fun destroy_empty<T0>(arg0: UserDeposit<T0>) {
        assert!(arg0.lp_amount == 0, 0);
        let UserDeposit {
            id          : v0,
            lp_amount   : _,
            reward_debt : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : UserDeposit<T0> {
        UserDeposit<T0>{
            id          : 0x2::object::new(arg0),
            lp_amount   : 0,
            reward_debt : 0,
        }
    }

    public(friend) fun add<T0>(arg0: &mut UserDeposit<T0>, arg1: u64, arg2: u128) {
        arg0.lp_amount = arg0.lp_amount + arg1;
        update_reward_debt<T0>(arg0, arg2);
    }

    public(friend) fun lp_amount<T0>(arg0: &UserDeposit<T0>) : u64 {
        arg0.lp_amount
    }

    public(friend) fun remove<T0>(arg0: &mut UserDeposit<T0>, arg1: u64, arg2: u128) {
        assert!(arg0.lp_amount >= arg1, 0);
        arg0.lp_amount = arg0.lp_amount - arg1;
        update_reward_debt<T0>(arg0, arg2);
    }

    public(friend) fun reward_debt<T0>(arg0: &UserDeposit<T0>) : u64 {
        arg0.reward_debt
    }

    public(friend) fun update_reward_debt<T0>(arg0: &mut UserDeposit<T0>, arg1: u128) {
        arg0.reward_debt = (((arg0.lp_amount as u128) * arg1 >> 48) as u64);
    }

    // decompiled from Move bytecode v6
}

