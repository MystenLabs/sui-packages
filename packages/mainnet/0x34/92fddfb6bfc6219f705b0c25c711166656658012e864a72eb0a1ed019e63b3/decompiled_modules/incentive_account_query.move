module 0x3492fddfb6bfc6219f705b0c25c711166656658012e864a72eb0a1ed019e63b3::incentive_account_query {
    struct AccountPoolPointData has copy, drop, store {
        point_type: 0x1::type_name::TypeName,
        weighted_amount: u64,
        points: u64,
        total_points: u64,
        index: u64,
    }

    struct AccountPoolRecordData has copy, drop, store {
        pool_type: 0x1::type_name::TypeName,
        points_list: vector<AccountPoolPointData>,
        debt_amount: u64,
    }

    struct IncentiveAccountData has copy, drop {
        pool_records: vector<AccountPoolRecordData>,
        ve_sca_binded: 0x1::option::Option<0x2::object::ID>,
    }

    fun account_pool_points(arg0: &0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::AccountPoolRecord) : vector<AccountPoolPointData> {
        let v0 = 0x1::vector::empty<AccountPoolPointData>();
        let v1 = *0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::point_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::pool_point(arg0, v3);
            let v5 = AccountPoolPointData{
                point_type      : v3,
                weighted_amount : 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::weighted_amount(v4),
                points          : 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::points(v4),
                total_points    : 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::total_points(v4),
                index           : 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::index(v4),
            };
            0x1::vector::push_back<AccountPoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    public fun incentive_account_data(arg0: &0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::IncentiveAccounts, arg1: &0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::obligation::Obligation) {
        let v0 = 0x1::vector::empty<AccountPoolRecordData>();
        let v1 = 0x1::option::none<0x2::object::ID>();
        if (0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::pool_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::account_pool_record(v2, v5);
                let v7 = AccountPoolRecordData{
                    pool_type   : v5,
                    points_list : account_pool_points(v6),
                    debt_amount : 0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::amount(v6),
                };
                0x1::vector::push_back<AccountPoolRecordData>(&mut v0, v7);
                v4 = v4 + 1;
            };
            if (0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::is_ve_sca_key_binded(arg0, arg1)) {
                v1 = 0x1::option::some<0x2::object::ID>(0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::typed_id::to_id<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>(0xd016a70af9abbffd43af476588f9006af7d501bab197482cc04c9ec6846a2469::incentive_account::get_binded_ve_sca(arg0, arg1)));
            };
        };
        let v8 = IncentiveAccountData{
            pool_records  : v0,
            ve_sca_binded : v1,
        };
        0x2::event::emit<IncentiveAccountData>(v8);
    }

    // decompiled from Move bytecode v6
}

