module 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::local_fees {
    struct LocalFees has store {
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: u64,
        protocol: u64,
        referrers: 0x2::linked_table::LinkedTable<address, u64>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LocalFees {
        LocalFees{
            funds     : 0x2::balance::zero<0x2::sui::SUI>(),
            creator   : 0,
            protocol  : 0,
            referrers : 0x2::linked_table::new<address, u64>(arg0),
        }
    }

    public(friend) fun accrue(arg0: &mut LocalFees, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, arg1);
        let v1 = 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(v0, arg3);
        let v2 = if (0x1::option::is_some<address>(&arg2)) {
            0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::mul_bps(v0, arg4)
        } else {
            0
        };
        arg0.creator = arg0.creator + v1;
        arg0.protocol = arg0.protocol + v0 - v1 - v2;
        if (v2 > 0) {
            let v3 = *0x1::option::borrow<address>(&arg2);
            if (0x2::linked_table::contains<address, u64>(&arg0.referrers, v3)) {
                let v4 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.referrers, v3);
                *v4 = *v4 + v2;
            } else {
                0x2::linked_table::push_back<address, u64>(&mut arg0.referrers, v3, v2);
            };
        };
    }

    public fun creator_pending(arg0: &LocalFees) : u64 {
        arg0.creator
    }

    public(friend) fun drain(arg0: &mut LocalFees) : (0x2::balance::Balance<0x2::sui::SUI>, u64, vector<address>, vector<u64>, u64) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (!0x2::linked_table::is_empty<address, u64>(&arg0.referrers)) {
            let (v3, v4) = 0x2::linked_table::pop_front<address, u64>(&mut arg0.referrers);
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + v4;
        };
        let v5 = arg0.creator;
        let v6 = arg0.protocol;
        arg0.creator = 0;
        arg0.protocol = 0;
        let v7 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) == v5 + v6 + v2, 0);
        (v7, v5, v0, v1, v6)
    }

    public fun pending(arg0: &LocalFees) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun protocol_pending(arg0: &LocalFees) : u64 {
        arg0.protocol
    }

    public fun referrer_count(arg0: &LocalFees) : u64 {
        0x2::linked_table::length<address, u64>(&arg0.referrers)
    }

    public fun referrer_pending(arg0: &LocalFees, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, u64>(&arg0.referrers, arg1)) {
            *0x2::linked_table::borrow<address, u64>(&arg0.referrers, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

