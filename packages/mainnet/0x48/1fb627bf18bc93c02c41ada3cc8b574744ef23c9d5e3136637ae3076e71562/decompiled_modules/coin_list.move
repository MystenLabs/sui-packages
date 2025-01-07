module 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::coin_list {
    struct CoinInfo has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        official_symbol: 0x1::ascii::String,
        coingecko_id: 0x1::ascii::String,
        decimals: u8,
        logo_url: 0x1::ascii::String,
        project_url: 0x1::ascii::String,
        address: 0x1::ascii::String,
        extensions: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct CoinKey has copy, drop, store {
        name: 0x1::ascii::String,
    }

    struct FetchCoinListEvent<T0: copy + drop + store> has copy, drop, store {
        full_list: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::FullList<T0>,
    }

    public entry fun add_approver_to_list(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: address, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg3: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::add_approver_to_list<CoinKey>(arg1, arg2);
    }

    public entry fun add_approver_to_registry(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: address, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg3: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::add_approver_to_registry<CoinKey, CoinInfo>(arg1, arg2);
    }

    public entry fun add_extension<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &0x2::coin::TreasuryCap<T0>, arg4: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg5: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        if (arg2 == 0x1::ascii::string(b"bridge")) {
            abort 12
        };
        if (arg2 == 0x1::ascii::string(b"verified")) {
            abort 12
        };
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        let v1 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_info<CoinKey, CoinInfo>(v0, arg4);
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1.extensions, arg1, arg2);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::set_info<CoinKey, CoinInfo>(v0, v1, arg4);
    }

    public entry fun add_extension_by_approver<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg4: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        assert!(0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::is_registry_approvers<CoinKey, CoinInfo>(arg3, arg4), 13);
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        let v1 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_info<CoinKey, CoinInfo>(v0, arg3);
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1.extensions, arg1, arg2);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::set_info<CoinKey, CoinInfo>(v0, v1, arg3);
    }

    public entry fun add_to_list<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg3: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::add_to_list<CoinKey, CoinInfo>(v0, arg1, arg2, arg3);
    }

    public entry fun add_to_registry_by_approver<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u8, arg7: bool, arg8: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg9: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        let v0 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = CoinInfo{
            name            : arg1,
            symbol          : arg2,
            official_symbol : arg2,
            coingecko_id    : arg3,
            decimals        : arg6,
            logo_url        : arg4,
            project_url     : arg5,
            address         : v0,
            extensions      : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        let v2 = CoinKey{name: v0};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::add_to_registry_by_approver<CoinKey, CoinInfo>(v2, v1, arg7, arg8, arg9);
    }

    public entry fun add_to_registry_by_signer<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u8, arg7: bool, arg8: &0x2::coin::TreasuryCap<T0>, arg9: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg10: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        let v0 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = CoinInfo{
            name            : arg1,
            symbol          : arg2,
            official_symbol : arg2,
            coingecko_id    : arg3,
            decimals        : arg6,
            logo_url        : arg4,
            project_url     : arg5,
            address         : v0,
            extensions      : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        let v2 = CoinKey{name: v0};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::add_to_registry_by_signer<CoinKey, CoinInfo>(v2, v1, arg7, arg9);
    }

    public entry fun create_list(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::create_list<CoinKey>(arg1);
    }

    public entry fun drop_extension<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg4: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        let v1 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_info<CoinKey, CoinInfo>(v0, arg3);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(&mut v1.extensions, &arg1);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::set_info<CoinKey, CoinInfo>(v0, v1, arg3);
    }

    public entry fun drop_extension_by_approver<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: 0x1::ascii::String, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg3: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        assert!(0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::is_registry_approvers<CoinKey, CoinInfo>(arg2, arg3), 13);
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        let v1 = 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_info<CoinKey, CoinInfo>(v0, arg2);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(&mut v1.extensions, &arg1);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::set_info<CoinKey, CoinInfo>(v0, v1, arg2);
    }

    public entry fun fetch_all_registered_coin_info(arg0: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchCoinListEvent<CoinInfo>{full_list: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::new_full_list<CoinInfo>()};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_all_registered_coin_info<CoinKey, CoinInfo>(&mut v0.full_list, arg0);
        0x2::event::emit<FetchCoinListEvent<CoinInfo>>(v0);
    }

    public entry fun fetch_all_registered_coin_info_with_limit(arg0: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchCoinListEvent<CoinInfo>{full_list: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::new_full_list<CoinInfo>()};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_all_registered_coin_info_with_limit<CoinKey, CoinInfo>(&mut v0.full_list, arg0, arg1, arg2);
        0x2::event::emit<FetchCoinListEvent<CoinInfo>>(v0);
    }

    public entry fun fetch_full_list(arg0: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg1: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchCoinListEvent<CoinInfo>{full_list: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::new_full_list<CoinInfo>()};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_full_list<CoinKey, CoinInfo>(arg1, &mut v0.full_list, arg0);
        0x2::event::emit<FetchCoinListEvent<CoinInfo>>(v0);
    }

    public entry fun fetch_full_list_with_limit(arg0: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg1: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FetchCoinListEvent<CoinInfo>{full_list: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::new_full_list<CoinInfo>()};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_full_list_with_limit<CoinKey, CoinInfo>(arg1, &mut v0.full_list, arg0, arg2, arg3);
        0x2::event::emit<FetchCoinListEvent<CoinInfo>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::initialize<CoinKey, CoinInfo>(arg0);
    }

    public entry fun remove_approver_from_list(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: address, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg3: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::remove_approver_from_list<CoinKey>(arg1, arg2);
    }

    public entry fun remove_approver_from_registry(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: address, arg2: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::Registry<CoinKey, CoinInfo>, arg3: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::remove_approver_from_registry<CoinKey, CoinInfo>(arg1, arg2);
    }

    public entry fun remove_from_list<T0>(arg0: &0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::GlobalConfig, arg1: &mut 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::List<CoinKey>, arg2: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::checked_package_version(arg0);
        let v0 = CoinKey{name: 0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::get_complete_address(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::remove_from_list<CoinKey>(v0, arg1);
    }

    public entry fun remove_from_registry_by_approver(arg0: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::remove_from_registry_by_approver<CoinKey, CoinInfo>(arg0);
    }

    public entry fun remove_from_registry_by_signer(arg0: &mut 0x2::tx_context::TxContext) {
        0x481fb627bf18bc93c02c41ada3cc8b574744ef23c9d5e3136637ae3076e71562::core::remove_from_registry_by_signer<CoinKey, CoinInfo>(arg0);
    }

    // decompiled from Move bytecode v6
}

