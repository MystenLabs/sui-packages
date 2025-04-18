module 0xdbc22fe051d384691634cd3b9fe473b09723084a1e4c128728c42e2de3b2228f::incentive_account_query {
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

    fun account_pool_points(arg0: &0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::AccountPoolRecord) : vector<AccountPoolPointData> {
        let v0 = 0x1::vector::empty<AccountPoolPointData>();
        let v1 = *0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::point_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::pool_point(arg0, v3);
            let v5 = AccountPoolPointData{
                point_type      : v3,
                weighted_amount : 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::weighted_amount(v4),
                points          : 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::points(v4),
                total_points    : 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::total_points(v4),
                index           : 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::index(v4),
            };
            0x1::vector::push_back<AccountPoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    public fun incentive_account_data(arg0: &0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::IncentiveAccounts, arg1: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation) {
        let v0 = 0x1::vector::empty<AccountPoolRecordData>();
        let v1 = 0x1::option::none<0x2::object::ID>();
        if (0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::pool_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::account_pool_record(v2, v5);
                let v7 = AccountPoolRecordData{
                    pool_type   : v5,
                    points_list : account_pool_points(v6),
                    debt_amount : 0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::amount(v6),
                };
                0x1::vector::push_back<AccountPoolRecordData>(&mut v0, v7);
                v4 = v4 + 1;
            };
            if (0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::is_ve_sca_key_binded(arg0, arg1)) {
                v1 = 0x1::option::some<0x2::object::ID>(0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::typed_id::to_id<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(0x45811c127a4063d78683ea61fa987b9252a798b0d3ae9e927e25adcbe5549e2::incentive_account::get_binded_ve_sca(arg0, arg1)));
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

