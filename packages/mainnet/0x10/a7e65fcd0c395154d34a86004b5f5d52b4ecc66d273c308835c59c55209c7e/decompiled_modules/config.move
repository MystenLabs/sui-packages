module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        trading_manager: address,
    }

    struct TradingManagerCap has store, key {
        id: 0x2::object::UID,
        trading_manager: address,
    }

    public fun add_allowed_quote_asset_for_limit_order(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config, arg2: 0x1::type_name::TypeName) {
        assert_interacting_with_most_up_to_date_package(arg1);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"allowed_quote_coin_types")) {
            0x2::dynamic_field::add<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types", 0x1::vector::empty<0x1::type_name::TypeName>());
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types"), arg2);
    }

    public fun add_allowed_quote_asset_for_limit_order_v2<T0>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config) {
        assert_interacting_with_most_up_to_date_package(arg1);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"allowed_quote_coin_types")) {
            0x2::dynamic_field::add<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types", 0x1::vector::empty<0x1::type_name::TypeName>());
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types"), 0x1::type_name::get<T0>());
    }

    public fun assert_address_is_not_trading_manager(arg0: address, arg1: &Config) {
        assert!(arg1.trading_manager != arg0, 2);
    }

    public fun assert_address_is_trading_manager(arg0: &TradingManagerCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.trading_manager == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.trading_manager == 0x2::tx_context::sender(arg2), 1);
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assert_quote_asset_is_allowed_for_limit_order(arg0: &Config, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"allowed_quote_coin_types"), 5);
        let (v0, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(0x2::dynamic_field::borrow<vector<u8>, vector<0x1::type_name::TypeName>>(&arg0.id, b"allowed_quote_coin_types"), &arg1);
        assert!(v0, 4);
    }

    public fun assign_trading_manager(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.trading_manager = arg2;
        let v0 = TradingManagerCap{
            id              : 0x2::object::new(arg3),
            trading_manager : arg2,
        };
        0x2::transfer::transfer<TradingManagerCap>(v0, arg2);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 3);
        let v0 = Config{
            id              : 0x2::object::new(arg1),
            version         : 1,
            trading_manager : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun remove_allowed_quote_asset_for_limit_order(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config, arg2: 0x1::type_name::TypeName) {
        assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"allowed_quote_coin_types"), 5);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types");
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(v0, &arg2);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(v0, v2);
        };
    }

    public fun remove_allowed_quote_asset_for_limit_order_v2<T0>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config) {
        assert_interacting_with_most_up_to_date_package(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"allowed_quote_coin_types"), 5);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.id, b"allowed_quote_coin_types");
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(v1, &v0);
        if (v2) {
            0x1::vector::remove<0x1::type_name::TypeName>(v1, v3);
        };
    }

    // decompiled from Move bytecode v6
}

