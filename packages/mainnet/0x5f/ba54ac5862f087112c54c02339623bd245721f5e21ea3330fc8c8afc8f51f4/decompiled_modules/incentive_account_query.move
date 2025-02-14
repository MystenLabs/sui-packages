module 0x5fba54ac5862f087112c54c02339623bd245721f5e21ea3330fc8c8afc8f51f4::incentive_account_query {
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

    fun account_pool_points(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::AccountPoolRecord) : vector<AccountPoolPointData> {
        let v0 = 0x1::vector::empty<AccountPoolPointData>();
        let v1 = *0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::point_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::pool_point(arg0, v3);
            let v5 = AccountPoolPointData{
                point_type      : v3,
                weighted_amount : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::weighted_amount(v4),
                points          : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::points(v4),
                total_points    : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::total_points(v4),
                index           : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::index(v4),
            };
            0x1::vector::push_back<AccountPoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    public fun incentive_account_data(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg1: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation) {
        let v0 = 0x1::vector::empty<AccountPoolRecordData>();
        let v1 = 0x1::option::none<0x2::object::ID>();
        if (0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg0, arg1)) {
            let v2 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::incentive_account(arg0, arg1);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::pool_types(v2));
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
                let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
                let v6 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::account_pool_record(v2, v5);
                let v7 = AccountPoolRecordData{
                    pool_type   : v5,
                    points_list : account_pool_points(v6),
                    debt_amount : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::amount(v6),
                };
                0x1::vector::push_back<AccountPoolRecordData>(&mut v0, v7);
                v4 = v4 + 1;
            };
            if (0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg0, arg1)) {
                v1 = 0x1::option::some<0x2::object::ID>(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg0, arg1)));
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

