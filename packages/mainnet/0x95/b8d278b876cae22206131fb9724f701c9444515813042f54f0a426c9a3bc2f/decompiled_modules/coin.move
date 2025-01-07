module 0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::coin {
    struct CoinList has store, key {
        id: 0x2::object::UID,
        coins: 0x2::table::Table<0x1::type_name::TypeName, Coin>,
    }

    struct Coin has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        coingecko_id: 0x1::string::String,
        pyth_id: 0x1::string::String,
        decimals: u8,
        logo_url: 0x1::string::String,
        project_url: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct InitCoinListEvent has copy, drop, store {
        coin_list_id: 0x2::object::ID,
    }

    struct AddCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
    }

    struct UpdateCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
    }

    struct RemoveCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
    }

    struct UpdateCoinNameEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        old_coin_name: 0x1::string::String,
        new_coin_name: 0x1::string::String,
    }

    struct UpdateCoinSymbolEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        old_coin_symbol: 0x1::string::String,
        new_coin_symbol: 0x1::string::String,
    }

    struct UpdateCoingeckoIDEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        old_coingecko_id: 0x1::string::String,
        new_coingecko_id: 0x1::string::String,
    }

    struct UpdatePythIDEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        old_pyth_id: 0x1::string::String,
        new_pyth_id: 0x1::string::String,
    }

    struct AddExtensionToCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionFromCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        key: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionFromCoinEvent has copy, drop, store {
        coin_type: 0x1::string::String,
        key: 0x1::string::String,
    }

    public entry fun add_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg9));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 0);
        let v1 = Coin{
            name             : arg2,
            symbol           : arg3,
            coingecko_id     : arg4,
            pyth_id          : arg5,
            decimals         : arg6,
            logo_url         : arg7,
            project_url      : arg8,
            coin_type        : v0,
            extension_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::table::add<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0, v1);
        let v2 = AddCoinEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<AddCoinEvent>(v2);
    }

    public entry fun add_extension_to_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.extension_fields, &arg2), 3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1.extension_fields, arg2, arg3);
        let v2 = AddExtensionToCoinEvent{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            key       : arg2,
            value     : arg3,
        };
        0x2::event::emit<AddExtensionToCoinEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinList{
            id    : 0x2::object::new(arg0),
            coins : 0x2::table::new<0x1::type_name::TypeName, Coin>(arg0),
        };
        0x2::transfer::share_object<CoinList>(v0);
        let v1 = InitCoinListEvent{coin_list_id: 0x2::object::id<CoinList>(&v0)};
        0x2::event::emit<InitCoinListEvent>(v1);
    }

    public entry fun remove_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        0x2::table::remove<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        let v1 = RemoveCoinEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<RemoveCoinEvent>(v1);
    }

    public entry fun remove_extension_from_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.extension_fields, &arg2), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.extension_fields, &arg2);
        let v4 = RemoveExtensionFromCoinEvent{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            key       : arg2,
        };
        0x2::event::emit<RemoveExtensionFromCoinEvent>(v4);
    }

    public entry fun update_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg9));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        v1.name = arg2;
        v1.symbol = arg3;
        v1.coingecko_id = arg4;
        v1.pyth_id = arg5;
        v1.decimals = arg6;
        v1.logo_url = arg7;
        v1.project_url = arg8;
        v1.coin_type = v0;
        let v2 = UpdateCoinEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<UpdateCoinEvent>(v2);
    }

    public entry fun update_coin_name<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        v1.name = arg2;
        let v2 = UpdateCoinNameEvent{
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            old_coin_name : v1.name,
            new_coin_name : arg2,
        };
        0x2::event::emit<UpdateCoinNameEvent>(v2);
    }

    public entry fun update_coin_symbol<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        v1.symbol = arg2;
        let v2 = UpdateCoinSymbolEvent{
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            old_coin_symbol : v1.symbol,
            new_coin_symbol : arg2,
        };
        0x2::event::emit<UpdateCoinSymbolEvent>(v2);
    }

    public entry fun update_coingecko_id<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        v1.coingecko_id = arg2;
        let v2 = UpdateCoingeckoIDEvent{
            coin_type        : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            old_coingecko_id : v1.coingecko_id,
            new_coingecko_id : arg2,
        };
        0x2::event::emit<UpdateCoingeckoIDEvent>(v2);
    }

    public entry fun update_extension_from_coin<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.extension_fields, &arg2), 2);
        let v2 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v1.extension_fields, &arg2);
        *v2 = arg3;
        let v3 = UpdateExtensionFromCoinEvent{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            key       : arg2,
            old_value : *v2,
            new_value : arg3,
        };
        0x2::event::emit<UpdateExtensionFromCoinEvent>(v3);
    }

    public entry fun update_pyth_id<T0>(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut CoinList, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Coin>(&arg1.coins, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Coin>(&mut arg1.coins, v0);
        v1.pyth_id = arg2;
        let v2 = UpdatePythIDEvent{
            coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            old_pyth_id : v1.pyth_id,
            new_pyth_id : arg2,
        };
        0x2::event::emit<UpdatePythIDEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

