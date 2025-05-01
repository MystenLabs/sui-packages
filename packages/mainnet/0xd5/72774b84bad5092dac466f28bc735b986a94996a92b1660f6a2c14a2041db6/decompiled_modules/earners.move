module 0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::earners {
    struct EarnerRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        earners: 0x2::vec_map::VecMap<address, u64>,
        total_percentage: u64,
    }

    public(friend) fun claim_fees(arg0: &EarnerRegistry, arg1: &0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::State, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xd572774b84bad5092dac466f28bc735b986a94996a92b1660f6a2c14a2041db6::state::assert_not_paused(arg1);
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2);
        let v1 = 0x2::vec_map::keys<address, u64>(&arg0.earners);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2);
            let v4 = *0x2::vec_map::get<address, u64>(&arg0.earners, &v3);
            if (v4 > 0) {
                let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg2) * v4 / 10000;
                if (v5 > 0) {
                    if (0x2::balance::value<0x2::sui::SUI>(v0) >= v5) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v0, v5), arg3), v3);
                    };
                };
            };
            v2 = v2 + 1;
        };
        arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EarnerRegistry{
            id               : 0x2::object::new(arg0),
            owner            : 0x2::tx_context::sender(arg0),
            earners          : 0x2::vec_map::empty<address, u64>(),
            total_percentage : 0,
        };
        0x2::vec_map::insert<address, u64>(&mut v0.earners, @0xdcf03dadf52a919de99874938457522a806ceb1b46e4ce6f12ad88ce36adb329, 2000);
        0x2::vec_map::insert<address, u64>(&mut v0.earners, @0x958f2560a2dd2869cf658497aa0c9598056c322b96c49f1fb5f23aba0db4bc93, 4000);
        0x2::vec_map::insert<address, u64>(&mut v0.earners, @0xa13cee5cfd5ffcb0bd246656cfc489b661976eac786dbc600382b5ae141f73d3, 4000);
        v0.total_percentage = 10000;
        0x2::transfer::share_object<EarnerRegistry>(v0);
    }

    public(friend) entry fun remove_earner(arg0: &mut EarnerRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.earners, &arg1), 3);
        let (_, v1) = 0x2::vec_map::remove<address, u64>(&mut arg0.earners, &arg1);
        arg0.total_percentage = arg0.total_percentage - v1;
    }

    public(friend) entry fun set_earner(arg0: &mut EarnerRegistry, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(arg2 <= 10000, 0);
        let v0 = if (0x2::vec_map::contains<address, u64>(&arg0.earners, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.earners, &arg1)
        } else {
            0
        };
        let v1 = arg0.total_percentage - v0 + arg2;
        assert!(v1 <= 10000, 1);
        if (0x2::vec_map::contains<address, u64>(&arg0.earners, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.earners, &arg1);
        };
        if (arg2 > 0) {
            0x2::vec_map::insert<address, u64>(&mut arg0.earners, arg1, arg2);
        };
        arg0.total_percentage = v1;
    }

    // decompiled from Move bytecode v6
}

