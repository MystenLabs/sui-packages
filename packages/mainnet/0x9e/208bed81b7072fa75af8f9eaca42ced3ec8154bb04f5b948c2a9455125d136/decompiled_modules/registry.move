module 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        next_account_id: u64,
    }

    struct MarketInfo<phantom T0> has store {
        base_pfs_id: 0x2::object::ID,
        base_pfs_source_id: 0x2::object::ID,
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        scaling_factor: u256,
    }

    struct CollateralInfo<phantom T0> has store {
        collateral_pfs_id: 0x2::object::ID,
        collateral_pfs_source_id: 0x2::object::ID,
        scaling_factor: u256,
    }

    struct Config has store {
        stop_order_mist_cost: u64,
    }

    public(friend) fun create_account<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::Account<T0>, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::AccountSharePolicy, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::AccountCap<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::ADMIN>) {
        assert!(is_collateral_registered<T0>(arg0), 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::errors::collateral_is_not_registered());
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::account::create_account<T0>(inc_account_id(arg0), arg1)
    }

    public fun get_collateral_info<T0>(arg0: &Registry) : (0x2::object::ID, 0x2::object::ID, u256) {
        let v0 = 0x2::dynamic_field::borrow<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryCollateralInfo<T0>, CollateralInfo<T0>>(&arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_collateral_info<T0>());
        (v0.collateral_pfs_id, v0.collateral_pfs_source_id, v0.scaling_factor)
    }

    public fun get_market_info<T0>(arg0: &Registry, arg1: 0x2::object::ID) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u256) {
        let v0 = 0x2::dynamic_field::borrow<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1));
        (v0.base_pfs_id, v0.base_pfs_source_id, v0.collateral_pfs_id, v0.collateral_pfs_source_id, v0.scaling_factor)
    }

    public fun get_stop_order_mist_cost(arg0: &Registry) : u64 {
        0x2::dynamic_field::borrow<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryConfig, Config>(&arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_config()).stop_order_mist_cost
    }

    fun inc_account_id(arg0: &mut Registry) : u64 {
        let v0 = arg0.next_account_id;
        arg0.next_account_id = v0 + 1;
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            next_account_id : 0,
        };
        let v1 = Config{stop_order_mist_cost: 5000000};
        0x2::dynamic_field::add<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryConfig, Config>(&mut v0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_config(), v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_collateral_registered<T0>(arg0: &Registry) : bool {
        0x2::dynamic_field::exists_<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryCollateralInfo<T0>>(&arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_collateral_info<T0>())
    }

    public fun is_market_registered(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo>(&arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1))
    }

    public(friend) fun register_market<T0>(arg0: &mut Registry, arg1: &0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::ClearingHouse<T0>) {
        let v0 = 0x2::object::id<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::ClearingHouse<T0>>(arg1);
        assert!(!is_market_registered(arg0, v0), 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::errors::market_already_registered());
        let v1 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::get_market_params<T0>(arg1);
        let v2 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::market::get_base_pfs_id(v1);
        let v3 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::market::get_base_pfs_source_id(v1);
        let v4 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::market::get_collateral_pfs_id(v1);
        let v5 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::market::get_collateral_pfs_source_id(v1);
        let v6 = 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::market::get_scaling_factor(v1);
        let v7 = MarketInfo<T0>{
            base_pfs_id              : v2,
            base_pfs_source_id       : v3,
            collateral_pfs_id        : v4,
            collateral_pfs_source_id : v5,
            scaling_factor           : v6,
        };
        0x2::dynamic_field::add<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(v0), v7);
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::events::emit_registered_market_info<T0>(v0, v2, v3, v4, v5, v6);
        if (!is_collateral_registered<T0>(arg0)) {
            let v8 = CollateralInfo<T0>{
                collateral_pfs_id        : v4,
                collateral_pfs_source_id : v5,
                scaling_factor           : v6,
            };
            0x2::dynamic_field::add<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryCollateralInfo<T0>, CollateralInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_collateral_info<T0>(), v8);
            0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::events::emit_registered_collateral_info<T0>(v0, v4, v5, v6);
        };
    }

    public(friend) fun remove_registered_market<T0>(arg0: &mut Registry, arg1: &0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::ClearingHouse<T0>) {
        let v0 = 0x2::object::id<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::clearing_house::ClearingHouse<T0>>(arg1);
        assert!(is_market_registered(arg0, v0), 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::errors::market_is_not_registered());
        let MarketInfo {
            base_pfs_id              : _,
            base_pfs_source_id       : _,
            collateral_pfs_id        : _,
            collateral_pfs_source_id : _,
            scaling_factor           : _,
        } = 0x2::dynamic_field::remove<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(v0));
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::events::emit_removed_registered_market_info<T0>(v0);
    }

    public(friend) fun update_base_pfs_id<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1)).base_pfs_id = arg2;
    }

    public(friend) fun update_base_pfs_source_id<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1)).base_pfs_source_id = arg2;
    }

    public(friend) fun update_collateral_info<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryCollateralInfo<T0>, CollateralInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_collateral_info<T0>());
        v0.collateral_pfs_id = arg1;
        v0.collateral_pfs_source_id = arg2;
    }

    public(friend) fun update_collateral_pfs_id<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1)).collateral_pfs_id = arg2;
    }

    public(friend) fun update_collateral_pfs_source_id<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryMarketInfo, MarketInfo<T0>>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_market_info(arg1)).collateral_pfs_source_id = arg2;
    }

    public(friend) fun update_stop_order_mist_cost(arg0: &mut Registry, arg1: u64) {
        0x2::dynamic_field::borrow_mut<0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::RegistryConfig, Config>(&mut arg0.id, 0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::keys::registry_config()).stop_order_mist_cost = arg1;
        0x21d001e8b07da2e3facb3e2d636bbaef43ba3c978bd84810368840b7d57c5068::events::emit_updated_stop_order_mist_cost(arg1);
    }

    // decompiled from Move bytecode v6
}

