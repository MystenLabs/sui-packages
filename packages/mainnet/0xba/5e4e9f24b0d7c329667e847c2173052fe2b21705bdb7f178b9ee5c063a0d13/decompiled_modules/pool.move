module 0xba5e4e9f24b0d7c329667e847c2173052fe2b21705bdb7f178b9ee5c063a0d13::pool {
    struct Pool has store {
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        funders: 0x2::table::Table<address, u64>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            funds   : 0x2::balance::zero<0x2::sui::SUI>(),
            funders : 0x2::table::new<address, u64>(arg0),
        }
    }

    public fun funders(arg0: &Pool) : &0x2::table::Table<address, u64> {
        &arg0.funders
    }

    public(friend) fun funders_mut(arg0: &mut Pool) : &mut 0x2::table::Table<address, u64> {
        &mut arg0.funders
    }

    public fun funds(arg0: &Pool) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.funds
    }

    public(friend) fun funds_mut(arg0: &mut Pool) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.funds
    }

    // decompiled from Move bytecode v6
}

