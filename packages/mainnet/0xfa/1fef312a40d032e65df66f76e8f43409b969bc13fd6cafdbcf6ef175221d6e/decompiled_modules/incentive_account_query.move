module 0xfa1fef312a40d032e65df66f76e8f43409b969bc13fd6cafdbcf6ef175221d6e::incentive_account_query {
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

    public fun incentive_account_data(arg0: &0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::IncentiveAccounts, arg1: &0x9e30efa44fc125b7b704dab2ca3536a7d83228f00b0d1415569eed60455b9c06::obligation::Obligation) {
        let v0 = 0x1::vector::empty<IncentiveStateData>();
        let v1 = 0;
        if (0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::incentive_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::incentive_state(v2, v5);
                let v7 = IncentiveStateData{
                    pool_type    : v5,
                    amount       : 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::amount(v6),
                    points       : 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::points(v6),
                    total_points : 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::total_points(v6),
                    index        : 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::index(v6),
                };
                0x1::vector::push_back<IncentiveStateData>(&mut v0, v7);
                v1 = v1 + 0xeb0ed5f46db9e9ef9a628746620b1e107bc7b2a4f18f075dbc2091324c794d52::incentive_account::total_points(v6);
                v4 = v4 + 1;
            };
        };
        let v8 = IncentiveAccountData{
            incentive_states : v0,
            total_points     : v1,
        };
        0x2::event::emit<IncentiveAccountData>(v8);
    }

    // decompiled from Move bytecode v6
}

