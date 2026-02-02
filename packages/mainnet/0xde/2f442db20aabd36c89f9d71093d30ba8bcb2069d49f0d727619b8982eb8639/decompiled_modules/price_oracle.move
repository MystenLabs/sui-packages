module 0x3e8ff08910c7f7d9d5cd37c9791a16cbfe33c9a248ecceb549d2f68d04d718a4::price_oracle {
    struct TokenPriceConfig has copy, drop, store {
        price: u64,
        decimals: u8,
        last_update: u64,
    }

    struct GlobalConfigMap has key {
        id: 0x2::object::UID,
        price_configs: 0x2::table::Table<0x1::string::String, TokenPriceConfig>,
        authorized_list: vector<address>,
    }

    struct PriceUpdated has copy, drop {
        coin_type: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        decimals: u8,
        operator: address,
        timestamp: u64,
    }

    struct BatchPriceUpdated has copy, drop {
        coin_types: vector<0x1::string::String>,
        prices: vector<u64>,
        decimals: vector<u8>,
        operator: address,
        timestamp: u64,
    }

    struct AuthorizedAddressAdded has copy, drop {
        authorized_address: address,
        operator: address,
        timestamp: u64,
    }

    struct AuthorizedAddressRemoved has copy, drop {
        authorized_address: address,
        operator: address,
        timestamp: u64,
    }

    public(friend) fun add_authorized_address(arg0: &mut GlobalConfigMap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_permission(arg0, arg3);
        assert!(!0x1::vector::contains<address>(&arg0.authorized_list, &arg1), 204);
        0x1::vector::push_back<address>(&mut arg0.authorized_list, arg1);
        let v0 = AuthorizedAddressAdded{
            authorized_address : arg1,
            operator           : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AuthorizedAddressAdded>(v0);
    }

    public entry fun batch_set_prices(arg0: &mut GlobalConfigMap, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_permission(arg0, arg5);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 200);
        assert!(v0 == 0x1::vector::length<u8>(&arg3), 201);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg1, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u8>(&arg3, v2);
            assert!(v4 > 0, 200);
            assert!(v5 <= 18, 201);
            let v6 = TokenPriceConfig{
                price       : v4,
                decimals    : v5,
                last_update : v1,
            };
            if (0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, v3)) {
                *0x2::table::borrow_mut<0x1::string::String, TokenPriceConfig>(&mut arg0.price_configs, v3) = v6;
            } else {
                0x2::table::add<0x1::string::String, TokenPriceConfig>(&mut arg0.price_configs, v3, v6);
            };
            v2 = v2 + 1;
        };
        let v7 = BatchPriceUpdated{
            coin_types : arg1,
            prices     : arg2,
            decimals   : arg3,
            operator   : 0x2::tx_context::sender(arg5),
            timestamp  : v1,
        };
        0x2::event::emit<BatchPriceUpdated>(v7);
    }

    fun check_permission(arg0: &GlobalConfigMap, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg0, 0x2::tx_context::sender(arg1)), 203);
    }

    public fun get_authorized_addresses(arg0: &GlobalConfigMap) : vector<address> {
        arg0.authorized_list
    }

    public fun get_token_config(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : (u64, u8, u64) {
        assert!(0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1), 202);
        let v0 = 0x2::table::borrow<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1);
        (v0.price, v0.decimals, v0.last_update)
    }

    public fun get_token_price(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1), 202);
        0x2::table::borrow<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1).price
    }

    public fun has_token_config(arg0: &GlobalConfigMap, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1)
    }

    public(friend) fun init_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::string::String, TokenPriceConfig>(arg0);
        let v1 = TokenPriceConfig{
            price       : 500000,
            decimals    : 9,
            last_update : 0,
        };
        0x2::table::add<0x1::string::String, TokenPriceConfig>(&mut v0, 0x1::string::utf8(b"PI"), v1);
        let v2 = TokenPriceConfig{
            price       : 1000000,
            decimals    : 6,
            last_update : 0,
        };
        0x2::table::add<0x1::string::String, TokenPriceConfig>(&mut v0, 0x1::string::utf8(b"USDC"), v2);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::tx_context::sender(arg0));
        let v4 = GlobalConfigMap{
            id              : 0x2::object::new(arg0),
            price_configs   : v0,
            authorized_list : v3,
        };
        0x2::transfer::share_object<GlobalConfigMap>(v4);
    }

    public fun is_authorized(arg0: &GlobalConfigMap, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_list, &arg1)
    }

    fun pow10(arg0: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun remove_authorized_address(arg0: &mut GlobalConfigMap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_permission(arg0, arg3);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.authorized_list, &arg1);
        assert!(v0, 205);
        0x1::vector::remove<address>(&mut arg0.authorized_list, v1);
        let v2 = AuthorizedAddressRemoved{
            authorized_address : arg1,
            operator           : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AuthorizedAddressRemoved>(v2);
    }

    public entry fun set_token_price(arg0: &mut GlobalConfigMap, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_permission(arg0, arg5);
        assert!(arg2 > 0, 200);
        assert!(arg3 <= 18, 201);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1)) {
            0x2::table::borrow<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1).price
        } else {
            0
        };
        let v2 = TokenPriceConfig{
            price       : arg2,
            decimals    : arg3,
            last_update : v0,
        };
        if (0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, TokenPriceConfig>(&mut arg0.price_configs, arg1) = v2;
        } else {
            0x2::table::add<0x1::string::String, TokenPriceConfig>(&mut arg0.price_configs, arg1, v2);
        };
        let v3 = PriceUpdated{
            coin_type : arg1,
            old_price : v1,
            new_price : arg2,
            decimals  : arg3,
            operator  : 0x2::tx_context::sender(arg5),
            timestamp : v0,
        };
        0x2::event::emit<PriceUpdated>(v3);
    }

    public fun token_to_token(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : u64 {
        usdc_to_token(arg0, arg2, token_to_usdc(arg0, arg1, arg3))
    }

    public fun token_to_usdc(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: u64) : u64 {
        assert!(arg2 > 0, 206);
        assert!(0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1), 202);
        let v0 = 0x2::table::borrow<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1);
        let v1 = (arg2 as u128) * (v0.price as u128) / (pow10(v0.decimals) as u128);
        assert!(v1 <= 18446744073709551615, 207);
        (v1 as u64)
    }

    public fun usdc_to_token(arg0: &GlobalConfigMap, arg1: 0x1::string::String, arg2: u64) : u64 {
        assert!(arg2 > 0, 206);
        assert!(0x2::table::contains<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1), 202);
        let v0 = 0x2::table::borrow<0x1::string::String, TokenPriceConfig>(&arg0.price_configs, arg1);
        let v1 = (arg2 as u128) * (pow10(v0.decimals) as u128) / (v0.price as u128);
        assert!(v1 <= 18446744073709551615, 207);
        (v1 as u64)
    }

    // decompiled from Move bytecode v6
}

