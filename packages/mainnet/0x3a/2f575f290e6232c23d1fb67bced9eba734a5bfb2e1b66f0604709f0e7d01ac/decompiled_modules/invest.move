module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invest {
    struct Invest has store, key {
        id: 0x2::object::UID,
        total_investment: 0x2::vec_map::VecMap<address, u64>,
        total_gains: 0x2::vec_map::VecMap<address, u64>,
        last_investment: 0x2::vec_map::VecMap<address, u64>,
        last_accumulated_gains: 0x2::vec_map::VecMap<address, u64>,
    }

    struct UpdateInvest has copy, drop {
        address: address,
        amount: u64,
        is_increase: bool,
        total_investment: u64,
    }

    struct UpdateGains has copy, drop {
        address: address,
        amount: u64,
        is_increase: bool,
        total_gains: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Invest{
            id                     : 0x2::object::new(arg0),
            total_investment       : 0x2::vec_map::empty<address, u64>(),
            total_gains            : 0x2::vec_map::empty<address, u64>(),
            last_investment        : 0x2::vec_map::empty<address, u64>(),
            last_accumulated_gains : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::public_share_object<Invest>(v0);
    }

    public fun info(arg0: &Invest, arg1: address) : (u64, u64, u64, u64) {
        let v0 = if (0x2::vec_map::contains<address, u64>(&arg0.total_investment, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.total_investment, &arg1)
        } else {
            0
        };
        let v1 = if (0x2::vec_map::contains<address, u64>(&arg0.total_gains, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.total_gains, &arg1)
        } else {
            0
        };
        let v2 = if (0x2::vec_map::contains<address, u64>(&arg0.last_investment, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.last_investment, &arg1)
        } else {
            0
        };
        let v3 = if (0x2::vec_map::contains<address, u64>(&arg0.last_accumulated_gains, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.last_accumulated_gains, &arg1)
        } else {
            0
        };
        (v0, v1, v2, v3)
    }

    public fun is_need_forbid_node(arg0: &Invest, arg1: address, arg2: u64) : bool {
        0x2::vec_map::contains<address, u64>(&arg0.last_investment, &arg1) && arg2 >= *0x2::vec_map::get<address, u64>(&arg0.last_investment, &arg1) * 2
    }

    public(friend) fun modify(arg0: &mut Invest, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : bool {
        let (v0, v1, v2) = if (0x2::vec_map::contains<address, u64>(&arg0.total_investment, &arg1)) {
            let v3 = *0x2::vec_map::get<address, u64>(&arg0.total_investment, &arg1);
            let v4 = arg2 > v3;
            let v5 = if (v4) {
                arg2 - v3
            } else {
                v3 - arg2
            };
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.total_investment, &arg1);
            (v5, v4, v3)
        } else {
            (arg2, true, arg2)
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.total_investment, arg1, arg2);
        if (0x2::vec_map::contains<address, u64>(&arg0.last_investment, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.last_investment, &arg1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.last_investment, arg1, arg4);
        let v10 = UpdateInvest{
            address          : arg1,
            amount           : v0,
            is_increase      : v1,
            total_investment : v2,
        };
        0x2::event::emit<UpdateInvest>(v10);
        let (v11, v12, v13) = if (0x2::vec_map::contains<address, u64>(&arg0.total_gains, &arg1)) {
            let v14 = *0x2::vec_map::get<address, u64>(&arg0.total_gains, &arg1);
            let v15 = arg3 > v14;
            let v16 = if (v15) {
                arg3 - v14
            } else {
                v14 - arg3
            };
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.total_gains, &arg1);
            (v16, v15, v14)
        } else {
            (arg3, true, arg3)
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.total_gains, arg1, arg3);
        if (0x2::vec_map::contains<address, u64>(&arg0.last_accumulated_gains, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.last_accumulated_gains, &arg1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.last_accumulated_gains, arg1, arg5);
        let v21 = UpdateGains{
            address     : arg1,
            amount      : v11,
            is_increase : v12,
            total_gains : v13,
        };
        0x2::event::emit<UpdateGains>(v21);
        is_need_forbid_node(arg0, arg1, arg5)
    }

    public fun uid(arg0: &Invest) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun update_gains(arg0: &mut Invest, arg1: address, arg2: u64) : bool {
        let v0 = if (0x2::vec_map::contains<address, u64>(&arg0.total_gains, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.total_gains, &arg1);
            *0x2::vec_map::get<address, u64>(&arg0.total_gains, &arg1) + arg2
        } else {
            arg2
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.total_gains, arg1, v0);
        let v3 = UpdateGains{
            address     : arg1,
            amount      : arg2,
            is_increase : true,
            total_gains : v0,
        };
        0x2::event::emit<UpdateGains>(v3);
        let v4 = if (0x2::vec_map::contains<address, u64>(&arg0.last_accumulated_gains, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.last_accumulated_gains, &arg1);
            *0x2::vec_map::get<address, u64>(&arg0.last_accumulated_gains, &arg1) + arg2
        } else {
            arg2
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.last_accumulated_gains, arg1, v4);
        is_need_forbid_node(arg0, arg1, v4)
    }

    public(friend) fun update_invest(arg0: &mut Invest, arg1: address, arg2: u64) {
        let v0 = if (0x2::vec_map::contains<address, u64>(&arg0.total_investment, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.total_investment, &arg1);
            *0x2::vec_map::get<address, u64>(&arg0.total_investment, &arg1) + arg2
        } else {
            arg2
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.total_investment, arg1, v0);
        if (0x2::vec_map::contains<address, u64>(&arg0.last_investment, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.last_investment, &arg1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.last_investment, arg1, arg2);
        let v5 = UpdateInvest{
            address          : arg1,
            amount           : arg2,
            is_increase      : true,
            total_investment : v0,
        };
        0x2::event::emit<UpdateInvest>(v5);
        let v6 = if (0x2::vec_map::contains<address, u64>(&arg0.total_gains, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.last_accumulated_gains, &arg1)
        } else {
            0
        };
        if (0x2::vec_map::contains<address, u64>(&arg0.last_accumulated_gains, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.last_accumulated_gains, &arg1);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.last_accumulated_gains, arg1, 0);
        let v9 = UpdateGains{
            address     : arg1,
            amount      : 0,
            is_increase : true,
            total_gains : v6,
        };
        0x2::event::emit<UpdateGains>(v9);
    }

    // decompiled from Move bytecode v6
}

