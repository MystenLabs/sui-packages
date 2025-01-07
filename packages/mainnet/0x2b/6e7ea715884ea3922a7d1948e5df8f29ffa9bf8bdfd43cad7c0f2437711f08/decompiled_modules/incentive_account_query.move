module 0x2b6e7ea715884ea3922a7d1948e5df8f29ffa9bf8bdfd43cad7c0f2437711f08::incentive_account_query {
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

    public fun incentive_account_data(arg0: &0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::IncentiveAccounts, arg1: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation) {
        let v0 = 0x1::vector::empty<IncentiveStateData>();
        let v1 = 0;
        let v2 = 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::incentive_account(arg0, arg1);
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::incentive_types(v2));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v6 = 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::incentive_state(v2, v5);
            let v7 = IncentiveStateData{
                pool_type    : v5,
                amount       : 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::amount(v6),
                points       : 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::points(v6),
                total_points : 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::total_points(v6),
                index        : 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::index(v6),
            };
            0x1::vector::push_back<IncentiveStateData>(&mut v0, v7);
            v1 = v1 + 0xd080be44f455b02fd2c270da6bac8e6ffd508e3fd98ee6b5bdfa9a337b96ed2d::incentive_account::total_points(v6);
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

