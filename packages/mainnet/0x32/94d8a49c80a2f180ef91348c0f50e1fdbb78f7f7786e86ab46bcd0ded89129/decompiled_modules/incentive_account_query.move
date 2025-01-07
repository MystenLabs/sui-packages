module 0x3294d8a49c80a2f180ef91348c0f50e1fdbb78f7f7786e86ab46bcd0ded89129::incentive_account_query {
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

    public fun incentive_account_data(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        let v0 = 0x1::vector::empty<IncentiveStateData>();
        let v1 = 0;
        if (0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::incentive_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::incentive_state(v2, v5);
                let v7 = IncentiveStateData{
                    pool_type    : v5,
                    amount       : 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::amount(v6),
                    points       : 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::points(v6),
                    total_points : 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::total_points(v6),
                    index        : 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::index(v6),
                };
                0x1::vector::push_back<IncentiveStateData>(&mut v0, v7);
                v1 = v1 + 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::total_points(v6);
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

