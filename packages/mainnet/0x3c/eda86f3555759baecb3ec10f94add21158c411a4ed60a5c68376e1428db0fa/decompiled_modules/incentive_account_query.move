module 0x3ceda86f3555759baecb3ec10f94add21158c411a4ed60a5c68376e1428db0fa::incentive_account_query {
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

    fun account_pool_points(arg0: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::AccountPoolRecord) : vector<AccountPoolPointData> {
        let v0 = 0x1::vector::empty<AccountPoolPointData>();
        let v1 = *0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::point_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::pool_point(arg0, v3);
            let v5 = AccountPoolPointData{
                point_type      : v3,
                weighted_amount : 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::weighted_amount(v4),
                points          : 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::points(v4),
                total_points    : 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::total_points(v4),
                index           : 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::index(v4),
            };
            0x1::vector::push_back<AccountPoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    public fun incentive_account_data(arg0: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        let v0 = 0x1::vector::empty<AccountPoolRecordData>();
        if (0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v1 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::incentive_account(arg0, arg1);
            let v2 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::pool_types(v1));
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
                let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
                let v5 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::account_pool_record(v1, v4);
                let v6 = AccountPoolRecordData{
                    pool_type   : v4,
                    points_list : account_pool_points(v5),
                    debt_amount : 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::amount(v5),
                };
                0x1::vector::push_back<AccountPoolRecordData>(&mut v0, v6);
                v3 = v3 + 1;
            };
        };
        let v7 = if (0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::is_ve_sca_key_binded(arg0, arg1)) {
            0x1::option::some<0x2::object::ID>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::get_binded_ve_sca(arg0, arg1)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v8 = IncentiveAccountData{
            pool_records  : v0,
            ve_sca_binded : v7,
        };
        0x2::event::emit<IncentiveAccountData>(v8);
    }

    // decompiled from Move bytecode v6
}

