module 0x22955b7a13502d3b20383a6904abadad683456128141d9ff6820260c7020f0cb::navi_farm {
    struct NaviFarmEntity has drop {
        dummy_field: bool,
    }

    struct NaviFarm has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        creditor_account_caps: 0x2::vec_map::VecMap<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>,
    }

    struct DecimalConfig has key {
        id: 0x2::object::UID,
        decimals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
    }

    public fun add_version(arg0: &mut NaviFarm, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_valid_package_version(arg0: &NaviFarm) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun claim_interest<T0, T1>(arg0: &mut NaviFarm, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x2::clock::Clock, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = debt_amount<T0>(arg0, v0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = extract_account_cap(arg0, v0, arg10);
            let v4 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v3);
            let v5 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg8, 0x2::object::id_to_address(&v4)) as u64);
            if (v5 > v2) {
                0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, NaviFarmEntity>(arg9, stamp(), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg5, arg1, arg2, arg7, arg8, v5 - v2, arg3, arg4, &v3, arg6, arg10));
            };
            fill_account_cap(arg0, v0, v3);
        } else {
            0x1::option::destroy_none<u64>(v1);
        };
    }

    public fun claim_interest_v2<T0, T1>(arg0: &mut NaviFarm, arg1: &DecimalConfig, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg11: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = debt_amount<T0>(arg0, v0);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = extract_account_cap(arg0, v0, arg11);
            let v4 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v3);
            let v5 = 0x1::type_name::with_defining_ids<T0>();
            let v6 = ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg9, 0x2::object::id_to_address(&v4)) / 0x1::u256::pow(10, 9 - *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg1.decimals, &v5))) as u64);
            if (v6 > v2) {
                0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, NaviFarmEntity>(arg10, stamp(), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg6, arg2, arg3, arg8, arg9, v6 - v2, arg4, arg5, &v3, arg7, arg11));
            };
            fill_account_cap(arg0, v0, v3);
        } else {
            0x1::option::destroy_none<u64>(v1);
        };
    }

    public fun create_config(arg0: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DecimalConfig{
            id       : 0x2::object::new(arg1),
            decimals : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
        };
        0x2::transfer::share_object<DecimalConfig>(v0);
    }

    fun debt_amount<T0>(arg0: &NaviFarm, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity>>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity>>(&arg0.id, v0);
            if (0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviFarmEntity>(v2), &arg1)) {
                0x1::option::some<u64>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T0>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T0, NaviFarmEntity>(v2), &arg1)))
            } else {
                0x1::option::none<u64>()
            }
        } else {
            0x1::option::none<u64>()
        }
    }

    fun err_invalid_package_version() {
        abort 1
    }

    fun extract_account_cap(arg0: &mut NaviFarm, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&arg0.creditor_account_caps, &arg1)) {
            0x2::vec_map::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, arg1, 0x1::option::some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2)));
        };
        0x1::option::extract<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, &arg1))
    }

    fun fill_account_cap(arg0: &mut NaviFarm, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x1::option::fill<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(&mut arg0.creditor_account_caps, &arg1), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviFarm{
            id                    : 0x2::object::new(arg0),
            versions              : 0x2::vec_set::singleton<u16>(package_version()),
            creditor_account_caps : 0x2::vec_map::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>>(),
        };
        0x2::transfer::share_object<NaviFarm>(v0);
    }

    public fun package_version() : u16 {
        2
    }

    public fun receive_loan<T0, T1>(arg0: &mut NaviFarm, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &0x2::clock::Clock, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T0, T1, NaviFarmEntity>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = sheet_mut<T0>(arg0, v0);
        let v2 = 0x2::coin::from_balance<T0>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T0, T1, NaviFarmEntity>(v1, arg7, stamp()), arg8);
        let v3 = extract_account_cap(arg0, v0, arg8);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg4, arg1, arg5, arg6, v2, arg2, arg3, &v3);
        fill_account_cap(arg0, v0, v3);
    }

    public fun remove_version(arg0: &mut NaviFarm, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun repay<T0, T1>(arg0: &mut NaviFarm, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x2::clock::Clock, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        let v1 = extract_account_cap(arg0, v0, arg10);
        let v2 = sheet_mut<T0>(arg0, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T0, T1, NaviFarmEntity>(v2, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg5, arg1, arg2, arg7, arg8, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::shortage<T0, T1>(arg9), arg3, arg4, &v1, arg6, arg10), stamp());
        fill_account_cap(arg0, v0, v1);
    }

    public fun set_decimal<T0>(arg0: &mut DecimalConfig, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.decimals, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg0.decimals, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u8>(&mut arg0.decimals, &v0) = arg2;
        };
    }

    fun sheet_mut<T0>(arg0: &mut NaviFarm, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity>>(&mut arg0.id, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, NaviFarmEntity>(stamp()));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NaviFarmEntity>>(&mut arg0.id, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T0, NaviFarmEntity>(v1, arg1, stamp());
        v1
    }

    fun stamp() : NaviFarmEntity {
        NaviFarmEntity{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

