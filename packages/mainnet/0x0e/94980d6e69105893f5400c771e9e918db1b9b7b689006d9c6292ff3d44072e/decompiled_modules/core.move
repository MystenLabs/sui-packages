module 0x7d8d4534554f3e160f2fa1da5673df7598243419d4a36c03e2e5a05874c265c4::core {
    struct UserInfoData has copy, drop {
        user: address,
        total_points: u256,
    }

    struct UserInformation has copy, drop {
        user: address,
        user_info: 0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo,
    }

    public fun get_dashboard_user_detailed_informations<T0>(arg0: &0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::PointDashBoard<T0>, arg1: vector<address>) : vector<UserInformation> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<UserInformation>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            let v3 = 0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::get_user_info<T0>(arg0, v2);
            if (0x1::option::is_some<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>(&v3)) {
                let v4 = UserInformation{
                    user      : v2,
                    user_info : 0x1::option::destroy_some<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>(v3),
                };
                0x1::vector::push_back<UserInformation>(&mut v1, v4);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_dashboard_user_detailed_infos<T0>(arg0: &0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::PointDashBoard<T0>, arg1: vector<address>) : vector<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = 0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::get_user_info<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v0));
            if (0x1::option::is_some<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>(&v2)) {
                0x1::vector::push_back<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>(&mut v1, 0x1::option::destroy_some<0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::UserInfo>(v2));
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_dashboard_user_infos<T0>(arg0: &0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::PointDashBoard<T0>, arg1: vector<address>, arg2: &0x2::clock::Clock) : vector<UserInfoData> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<UserInfoData>();
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v0);
            let v3 = UserInfoData{
                user         : v2,
                total_points : 0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::get_user_info_points<T0>(arg0, v2, arg2),
            };
            0x1::vector::push_back<UserInfoData>(&mut v1, v3);
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

