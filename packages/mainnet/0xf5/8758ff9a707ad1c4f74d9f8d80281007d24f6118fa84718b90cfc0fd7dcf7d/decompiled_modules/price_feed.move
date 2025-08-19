module 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceFeedConfig has store, key {
        id: 0x2::object::UID,
        price_feeds: 0x2::table::Table<0x1::ascii::String, vector<u8>>,
        vault_decimals: 0x2::table::Table<0x2::object::ID, u64>,
        extra_data: vector<u8>,
        max_age: u64,
    }

    struct AddPriceFeedEvent has copy, drop {
        token: 0x1::ascii::String,
        price_feed_id: vector<u8>,
    }

    struct RemovePriceFeedEvent has copy, drop {
        token: 0x1::ascii::String,
        price_feed_id: vector<u8>,
    }

    struct AddVaultDecimalEvent has copy, drop {
        vault_id: 0x2::object::ID,
        decimal: u64,
    }

    struct RemoveVaultDecimalEvent has copy, drop {
        vault_id: 0x2::object::ID,
        decimal: u64,
    }

    struct AddTokenDecimalEvent has copy, drop {
        token: 0x1::ascii::String,
        decimal: u64,
    }

    struct RemoveTokenDecimalEvent has copy, drop {
        token: 0x1::ascii::String,
        decimal: u64,
    }

    struct UpdateMaxAgeEvent has copy, drop {
        max_age: u64,
    }

    entry fun add_price_feed(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg1.price_feeds, arg2), 1);
        0x2::table::add<0x1::ascii::String, vector<u8>>(&mut arg1.price_feeds, arg2, arg3);
        let v0 = AddPriceFeedEvent{
            token         : arg2,
            price_feed_id : arg3,
        };
        0x2::event::emit<AddPriceFeedEvent>(v0);
    }

    entry fun add_vault_decimal(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x2::object::ID, u64>(&arg1.vault_decimals, arg2), 1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.vault_decimals, arg2, arg3);
        let v0 = AddVaultDecimalEvent{
            vault_id : arg2,
            decimal  : arg3,
        };
        0x2::event::emit<AddVaultDecimalEvent>(v0);
    }

    public fun get_max_age(arg0: &PriceFeedConfig) : u64 {
        arg0.max_age
    }

    public fun get_price_feed(arg0: &PriceFeedConfig, arg1: 0x1::ascii::String) : vector<u8> {
        assert!(0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg0.price_feeds, arg1), 2);
        *0x2::table::borrow<0x1::ascii::String, vector<u8>>(&arg0.price_feeds, arg1)
    }

    public fun get_token_decimal(arg0: &PriceFeedConfig, arg1: 0x1::ascii::String) : u64 {
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, u64>(&arg0.id, arg1), 2);
        *0x2::dynamic_field::borrow<0x1::ascii::String, u64>(&arg0.id, arg1)
    }

    public fun get_vault_decimal(arg0: &PriceFeedConfig, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.vault_decimals, arg1), 2);
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.vault_decimals, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = PriceFeedConfig{
            id             : 0x2::object::new(arg0),
            price_feeds    : 0x2::table::new<0x1::ascii::String, vector<u8>>(arg0),
            vault_decimals : 0x2::table::new<0x2::object::ID, u64>(arg0),
            extra_data     : b"",
            max_age        : 60,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PriceFeedConfig>(v1);
    }

    entry fun remove_price_feed(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, vector<u8>>(&arg1.price_feeds, arg2), 2);
        let v0 = RemovePriceFeedEvent{
            token         : arg2,
            price_feed_id : 0x2::table::remove<0x1::ascii::String, vector<u8>>(&mut arg1.price_feeds, arg2),
        };
        0x2::event::emit<RemovePriceFeedEvent>(v0);
    }

    public entry fun remove_token_decimal(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_with_type<0x1::ascii::String, u64>(&arg1.id, arg2), 2);
        let v0 = RemoveTokenDecimalEvent{
            token   : arg2,
            decimal : 0x2::dynamic_field::remove<0x1::ascii::String, u64>(&mut arg1.id, arg2),
        };
        0x2::event::emit<RemoveTokenDecimalEvent>(v0);
    }

    entry fun remove_vault_decimal(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg1.vault_decimals, arg2), 2);
        let v0 = RemoveVaultDecimalEvent{
            vault_id : arg2,
            decimal  : 0x2::table::remove<0x2::object::ID, u64>(&mut arg1.vault_decimals, arg2),
        };
        0x2::event::emit<RemoveVaultDecimalEvent>(v0);
    }

    public entry fun set_token_decimal(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_with_type<0x1::ascii::String, u64>(&arg1.id, arg2)) {
            0x2::dynamic_field::remove<0x1::ascii::String, u64>(&mut arg1.id, arg2);
        };
        0x2::dynamic_field::add<0x1::ascii::String, u64>(&mut arg1.id, arg2, arg3);
        let v0 = AddTokenDecimalEvent{
            token   : arg2,
            decimal : arg3,
        };
        0x2::event::emit<AddTokenDecimalEvent>(v0);
    }

    entry fun update_max_age(arg0: &AdminCap, arg1: &mut PriceFeedConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_age = arg2;
        let v0 = UpdateMaxAgeEvent{max_age: arg2};
        0x2::event::emit<UpdateMaxAgeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

