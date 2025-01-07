module 0x1bfd378f64110b616f3e5d52212f97015c04ecf2b79f1aa07fb00d004c4d8bfd::incentive_account_query {
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
    }

    fun account_pool_points(arg0: &0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::AccountPoolRecord) : vector<AccountPoolPointData> {
        let v0 = 0x1::vector::empty<AccountPoolPointData>();
        let v1 = *0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::point_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::pool_point(arg0, v3);
            let v5 = AccountPoolPointData{
                point_type      : v3,
                weighted_amount : 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::weighted_amount(v4),
                points          : 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::points(v4),
                total_points    : 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::total_points(v4),
                index           : 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::index(v4),
            };
            0x1::vector::push_back<AccountPoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    public fun incentive_account_data(arg0: &0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) {
        let v0 = 0x1::vector::empty<AccountPoolRecordData>();
        if (0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v1 = 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::incentive_account(arg0, arg1);
            let v2 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::pool_types(v1));
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
                let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
                let v5 = 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::account_pool_record(v1, v4);
                let v6 = AccountPoolRecordData{
                    pool_type   : v4,
                    points_list : account_pool_points(v5),
                    debt_amount : 0xbdca995ce04068fe41e703285cd8260ba011b357cbdb5f483bbe79a588df4a3b::incentive_account::amount(v5),
                };
                0x1::vector::push_back<AccountPoolRecordData>(&mut v0, v6);
                v3 = v3 + 1;
            };
        };
        let v7 = IncentiveAccountData{pool_records: v0};
        0x2::event::emit<IncentiveAccountData>(v7);
    }

    // decompiled from Move bytecode v6
}

