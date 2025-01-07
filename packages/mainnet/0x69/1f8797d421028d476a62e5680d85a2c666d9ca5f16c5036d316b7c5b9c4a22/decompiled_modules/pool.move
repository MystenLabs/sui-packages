module 0x691f8797d421028d476a62e5680d85a2c666d9ca5f16c5036d316b7c5b9c4a22::pool {
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

    public(friend) fun delete(arg0: Pool) {
        let Pool {
            funds   : v0,
            funders : v1,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        0x2::table::drop<address, u64>(v1);
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

