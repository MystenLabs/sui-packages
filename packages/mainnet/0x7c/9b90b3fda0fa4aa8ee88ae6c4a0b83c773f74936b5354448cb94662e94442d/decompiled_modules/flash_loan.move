module 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        support_assets: 0x2::table::Table<vector<u8>, address>,
        assets: 0x2::table::Table<address, AssetConfig>,
    }

    struct AssetConfig has store, key {
        id: 0x2::object::UID,
        asset_id: u8,
        coin_type: 0x1::ascii::String,
        pool_id: address,
        rate_to_supplier: u64,
        rate_to_treasury: u64,
        max: u64,
        min: u64,
    }

    struct Receipt<phantom T0> {
        user: address,
        asset: address,
        amount: u64,
        pool: address,
        fee_to_supplier: u64,
        fee_to_treasury: u64,
    }

    struct ConfigCreated has copy, drop {
        sender: address,
        id: address,
    }

    struct AssetConfigCreated has copy, drop {
        sender: address,
        config_id: address,
        asset_id: address,
    }

    struct FlashLoan has copy, drop {
        sender: address,
        asset: address,
        amount: u64,
    }

    struct FlashRepay has copy, drop {
        sender: address,
        asset: address,
        amount: u64,
        fee_to_supplier: u64,
        fee_to_treasury: u64,
    }

    public(friend) fun create_asset(arg0: &mut Config, arg1: u8, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.support_assets, *0x1::ascii::as_bytes(&arg2)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::duplicate_config());
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = AssetConfig{
            id               : v0,
            asset_id         : arg1,
            coin_type        : arg2,
            pool_id          : arg3,
            rate_to_supplier : arg4,
            rate_to_treasury : arg5,
            max              : arg6,
            min              : arg7,
        };
        0x2::table::add<address, AssetConfig>(&mut arg0.assets, v1, v2);
        0x2::table::add<vector<u8>, address>(&mut arg0.support_assets, *0x1::ascii::as_bytes(&arg2), v1);
        let v3 = AssetConfigCreated{
            sender    : 0x2::tx_context::sender(arg8),
            config_id : 0x2::object::uid_to_address(&arg0.id),
            asset_id  : v1,
        };
        0x2::event::emit<AssetConfigCreated>(v3);
    }

    public(friend) fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Config{
            id             : v0,
            version        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version(),
            support_assets : 0x2::table::new<vector<u8>, address>(arg0),
            assets         : 0x2::table::new<address, AssetConfig>(arg0),
        };
        let v2 = ConfigCreated{
            sender : 0x2::tx_context::sender(arg0),
            id     : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<ConfigCreated>(v2);
        0x2::transfer::share_object<Config>(v1);
    }

    public fun get_asset<T0>(arg0: &Config) : (address, u8, vector<u8>, address, u64, u64, u64, u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.support_assets, *0x1::ascii::as_bytes(&v0)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::reserve_not_found());
        let v1 = 0x2::table::borrow<address, AssetConfig>(&arg0.assets, *0x2::table::borrow<vector<u8>, address>(&arg0.support_assets, *0x1::ascii::as_bytes(&v0)));
        (0x2::object::uid_to_address(&v1.id), v1.asset_id, *0x1::ascii::as_bytes(&v1.coin_type), v1.pool_id, v1.rate_to_supplier, v1.rate_to_treasury, v1.max, v1.min)
    }

    fun get_storage_asset_id_from_coin_type(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: 0x1::ascii::String) : u8 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg0);
        while (v0 > 0) {
            let v1 = v0 - 1;
            if (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, v1) == arg1) {
                return v1
            };
            v0 = v0 - 1;
        };
        abort 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::reserve_not_found()
    }

    public(friend) fun loan<T0>(arg0: &Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: address, arg3: u64) : (0x2::balance::Balance<T0>, Receipt<T0>) {
        version_verification(arg0);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.support_assets, *0x1::ascii::as_bytes(&v0)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::reserve_not_found());
        let v1 = 0x2::table::borrow<vector<u8>, address>(&arg0.support_assets, *0x1::ascii::as_bytes(&v0));
        let v2 = 0x2::table::borrow<address, AssetConfig>(&arg0.assets, *v1);
        let v3 = 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg1));
        assert!(arg3 >= v2.min && arg3 <= v2.max, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_amount());
        assert!(v2.pool_id == v3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_pool());
        let v4 = Receipt<T0>{
            user            : arg2,
            asset           : *v1,
            amount          : arg3,
            pool            : v3,
            fee_to_supplier : arg3 * v2.rate_to_supplier / 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::FlashLoanMultiple(),
            fee_to_treasury : arg3 * v2.rate_to_treasury / 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants::FlashLoanMultiple(),
        };
        let v5 = FlashLoan{
            sender : arg2,
            asset  : *v1,
            amount : arg3,
        };
        0x2::event::emit<FlashLoan>(v5);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::withdraw_balance<T0>(arg1, arg3, arg2), v4)
    }

    public fun parsed_receipt<T0>(arg0: &Receipt<T0>) : (address, address, u64, address, u64, u64) {
        (arg0.user, arg0.asset, arg0.amount, arg0.pool, arg0.fee_to_supplier, arg0.fee_to_treasury)
    }

    public(friend) fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: Receipt<T0>, arg4: address, arg5: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let Receipt {
            user            : v0,
            asset           : v1,
            amount          : v2,
            pool            : v3,
            fee_to_supplier : v4,
            fee_to_treasury : v5,
        } = arg3;
        assert!(v0 == arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_user());
        assert!(v3 == 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg2)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_pool());
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::update_state_of_all(arg0, arg1);
        let v6 = get_storage_asset_id_from_coin_type(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let (v7, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, v6);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::cumulate_to_supply_index(arg1, v6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_div((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::normal_amount<T0>(arg2, v4) as u256), v7));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::update_interest_rate(arg1, v6);
        assert!(0x2::balance::value<T0>(&arg5) >= v2 + v4 + v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::invalid_amount());
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::deposit_balance<T0>(arg2, 0x2::balance::split<T0>(&mut arg5, v2 + v4 + v5), arg4);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::deposit_treasury<T0>(arg2, v5);
        let v9 = FlashRepay{
            sender          : arg4,
            asset           : v1,
            amount          : v2,
            fee_to_supplier : v4,
            fee_to_treasury : v5,
        };
        0x2::event::emit<FlashRepay>(v9);
        arg5
    }

    public fun version_migrate(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap, arg1: &mut Config) {
        assert!(arg1.version < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version(), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::incorrect_version());
        arg1.version = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::this_version();
    }

    public fun version_verification(arg0: &Config) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::version::pre_check_version(arg0.version);
    }

    // decompiled from Move bytecode v6
}

