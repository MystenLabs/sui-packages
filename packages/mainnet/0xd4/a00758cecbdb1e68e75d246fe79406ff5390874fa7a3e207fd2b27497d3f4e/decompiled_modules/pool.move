module 0xd4a00758cecbdb1e68e75d246fe79406ff5390874fa7a3e207fd2b27497d3f4e::pool {
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

