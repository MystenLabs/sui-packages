module 0xb1a1d5735aaafb52dd16718fc765b77e716b9f52d3bc576d18ea56abe900de76::incentive_account_query {
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

    public fun incentive_account_data(arg0: &0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::IncentiveAccounts, arg1: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::obligation::Obligation) {
        let v0 = 0x1::vector::empty<IncentiveStateData>();
        let v1 = 0;
        if (0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::incentive_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::incentive_state(v2, v5);
                let v7 = IncentiveStateData{
                    pool_type    : v5,
                    amount       : 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::amount(v6),
                    points       : 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::points(v6),
                    total_points : 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::total_points(v6),
                    index        : 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::index(v6),
                };
                0x1::vector::push_back<IncentiveStateData>(&mut v0, v7);
                v1 = v1 + 0x74c4c606119064a340d2db04daa043becab0a6bcba3e7cfb14ce5f6415240fb::incentive_account::total_points(v6);
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

