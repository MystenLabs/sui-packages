module 0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::op {
    struct Tokens has key {
        id: 0x2::object::UID,
        update_price_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        token_infos: 0x2::table::Table<0x1::type_name::TypeName, TokenInfo>,
    }

    struct TokenInfo has drop, store {
        feed_id: vector<u8>,
        info_id: 0x2::object::ID,
        age: u64,
        decimal: u8,
    }

    struct Price has copy, drop, store {
        price: u64,
        decimal: u8,
        last_update_time: u64,
    }

    public fun new(arg0: u64, arg1: u8) : Price {
        Price{
            price            : arg0,
            decimal          : arg1,
            last_update_time : 0,
        }
    }

    public fun get_price<T0>(arg0: &Tokens, arg1: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0), 3010);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, v0);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == v1.last_update_time, 3011);
        v1
    }

    public entry fun add_into_fee(arg0: &mut Tokens, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.update_price_fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
    }

    public fun add_token<T0>(arg0: &mut Tokens, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x2::coin::CoinMetadata<T0>, arg4: vector<u8>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg6));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, v0), 3001);
        let v1 = TokenInfo{
            feed_id : arg4,
            info_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, arg4),
            age     : arg5,
            decimal : 0x2::coin::get_decimals<T0>(arg3),
        };
        0x2::table::add<0x1::type_name::TypeName, TokenInfo>(&mut arg0.token_infos, v0, v1);
    }

    public fun contain(arg0: &Tokens, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, arg1)
    }

    public fun get_price_by_type(arg0: &Tokens, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : Price {
        assert!(0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, arg1), 3012);
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == v0.last_update_time, 3013);
        v0
    }

    public fun get_prices(arg0: &Price, arg1: &Price) : (u64, u64) {
        let v0 = arg0.price;
        let v1 = arg1.price;
        let v2 = arg0.decimal;
        let v3 = arg1.decimal;
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v0, 0x1::u64::pow(10, 10 + v3 - v2), v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v1, 0x1::u64::pow(10, 10 + v2 - v3), v0))
    }

    public fun get_sqrt_price_latest<T0, T1>(arg0: &Tokens, arg1: &0x2::clock::Clock) : u128 {
        let v0 = get_price<T0>(arg0, arg1);
        let v1 = get_price<T1>(arg0, arg1);
        let (v2, _) = get_prices(&v0, &v1);
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::ag::price_to_sqrt_price(v2, 10)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Tokens{
            id               : 0x2::object::new(arg0),
            update_price_fee : 0x2::balance::zero<0x2::sui::SUI>(),
            prices           : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            token_infos      : 0x2::table::new<0x1::type_name::TypeName, TokenInfo>(arg0),
        };
        0x2::transfer::share_object<Tokens>(v0);
    }

    public fun oracle_info<T0>(arg0: &Tokens) : &TokenInfo {
        0x2::table::borrow<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, 0x1::type_name::get<T0>())
    }

    public fun price_decimal(arg0: &Price) : u8 {
        arg0.decimal
    }

    public fun price_factor() : u8 {
        10
    }

    fun price_from_token_info(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &TokenInfo, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1.age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(arg1.feed_id == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 3014);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v5 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
        };
        assert!(v5 != 0, 3015);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            let v7 = (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8);
            if (v7 < 10) {
                v5 * 0x1::u64::pow(10, 10 - v7)
            } else {
                v5 / 0x1::u64::pow(10, v7 - 10)
            }
        } else {
            v5 * 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8) + 10)
        }
    }

    public fun price_value(arg0: &Price) : u64 {
        arg0.price
    }

    public fun remove_token<T0>(arg0: &mut Tokens, arg1: &0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::Settings, arg2: &0x2::tx_context::TxContext) {
        0xa4a4d7e069884836eaaa74cd5ba1d86b8782f6ec67eaadf13c31337977b2ab83::cfg::valid_admin(arg1, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, v0), 3002);
        0x2::table::remove<0x1::type_name::TypeName, TokenInfo>(&mut arg0.token_infos, v0);
    }

    public(friend) fun split_fee(arg0: &mut Tokens, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.update_price_fee) >= arg1, 3000);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.update_price_fee, arg1)
    }

    fun sync_use_type<T0>(arg0: &mut Tokens, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : Price {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, v0), 3008);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, v0);
        assert!(v1.info_id == 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1), 3009);
        let v2 = Price{
            price            : price_from_token_info(arg1, v1, arg2),
            decimal          : v1.decimal,
            last_update_time : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0, v2);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, Price>(&mut arg0.prices, v0) = v2;
        };
        v2
    }

    public fun sync_with_oracle<T0>(arg0: &mut Tokens, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>, arg3: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::hot_potato_vector::HotPotatoVector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo> {
        let v0 = split_fee(arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_base_update_fee(arg1));
        if (0x2::table::contains<0x1::type_name::TypeName, TokenInfo>(&arg0.token_infos, 0x1::type_name::get<T0>())) {
            sync_use_type<T0>(arg0, arg3, arg4);
        };
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::update_single_price_feed(arg1, arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg4)
    }

    // decompiled from Move bytecode v6
}

