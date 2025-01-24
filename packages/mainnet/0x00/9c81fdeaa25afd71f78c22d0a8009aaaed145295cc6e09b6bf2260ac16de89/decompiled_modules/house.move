module 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house {
    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        max_stake: u64,
        min_stake: u64,
    }

    public(friend) fun borrow<T0>(arg0: &House<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut House<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut House<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public(friend) fun initialize_house<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : House<T0> {
        House<T0>{
            id        : 0x2::object::new(arg2),
            balance   : 0x2::balance::zero<T0>(),
            max_stake : arg1,
            min_stake : arg0,
        }
    }

    public fun max_stake<T0>(arg0: &House<T0>) : u64 {
        arg0.max_stake
    }

    public fun min_stake<T0>(arg0: &House<T0>) : u64 {
        arg0.min_stake
    }

    public fun top_up<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public(friend) fun update_max_stake<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.max_stake = arg1;
    }

    public(friend) fun update_min_stake<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.min_stake = arg1;
    }

    public(friend) fun withdraw<T0>(arg0: &mut House<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.balance, balance<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

