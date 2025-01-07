module 0xa37eb0404e699c89d794eff5c8f43a0a2d21b1d4edbb31f53d75c129dd5adee9::incentive_account_query {
    struct IncentiveStateData has copy, drop, store {
        pool_type: 0x1::type_name::TypeName,
        amount: u64,
        points: u64,
        total_points: u64,
        index: u64,
    }

    struct IncentiveAccountData has copy, drop {
        incentive_states: vector<IncentiveStateData>,
        total_points: u64,
    }

    public fun incentive_account_data(arg0: &0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::IncentiveAccounts, arg1: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation) {
        let v0 = 0x1::vector::empty<IncentiveStateData>();
        let v1 = 0;
        let v2 = 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::incentive_account(arg0, arg1);
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::incentive_types(v2));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v6 = 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::incentive_state(v2, v5);
            let v7 = IncentiveStateData{
                pool_type    : v5,
                amount       : 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::amount(v6),
                points       : 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::points(v6),
                total_points : 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::total_points(v6),
                index        : 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::index(v6),
            };
            0x1::vector::push_back<IncentiveStateData>(&mut v0, v7);
            v1 = v1 + 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::incentive_account::total_points(v6);
            v4 = v4 + 1;
        };
        let v8 = IncentiveAccountData{
            incentive_states : v0,
            total_points     : v1,
        };
        0x2::event::emit<IncentiveAccountData>(v8);
    }

    // decompiled from Move bytecode v6
}

