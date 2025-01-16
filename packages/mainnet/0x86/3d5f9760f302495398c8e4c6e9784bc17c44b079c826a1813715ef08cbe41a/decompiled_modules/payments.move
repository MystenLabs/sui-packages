module 0x863d5f9760f302495398c8e4c6e9784bc17c44b079c826a1813715ef08cbe41a::payments {
    struct PaymentsApp has drop {
        dummy_field: bool,
    }

    struct PaymentsConfig has drop, store {
        currencies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinTypeData>,
        base_currency: 0x1::type_name::TypeName,
        max_age: u64,
    }

    struct CoinTypeData has copy, drop, store {
        decimals: u8,
        discount_percentage: u8,
        price_feed_id: vector<u8>,
        type_name: 0x1::type_name::TypeName,
    }

    fun apply_discount_if_eligible(arg0: &CoinTypeData, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent) {
        if (arg0.discount_percentage == 0) {
            return
        };
        let v0 = PaymentsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::apply_percentage_discount<PaymentsApp>(arg2, arg1, v0, 0x1::string::utf8(b"payment_discount"), arg0.discount_percentage, true);
    }

    public fun calculate_price<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : u64 {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0);
        let v1 = get_config_for_type<T0>(arg0);
        assert!(v0.base_currency != 0x1::type_name::get<T0>(), 9223372655330459655);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg3, arg2, v0.max_age);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v3);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v4) == v1.price_feed_id, 9223372711165165577);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        calculate_target_currency_amount(arg1, v1.decimals, 0x2::vec_map::get<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v0.base_currency).decimals, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8))
    }

    public fun calculate_price_after_discount<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent) : u64 {
        let v0 = get_config_for_type<T0>(arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::calculate_total_after_discount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg1), v0.discount_percentage)
    }

    public(friend) fun calculate_target_currency_amount(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u8) : u64 {
        assert!(arg3 > 0, 9223373024697909259);
        (0x1::u128::divide_and_round_up(0x1::u128::divide_and_round_up((arg0 as u128) * 0x1::u128::pow(10, 10 + arg1 + arg4 - arg2), (arg3 as u128)), 0x1::u128::pow(10, 10)) as u64)
    }

    fun get_config_for_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : CoinTypeData {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1), 9223373196496207877);
        *0x2::vec_map::get<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1)
    }

    public fun handle_base_payment<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: 0x2::coin::Coin<T0>) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::Receipt {
        assert!(0x1::type_name::get<T0>() == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0).base_currency, 9223372371862487045);
        let v0 = get_config_for_type<T0>(arg0);
        let v1 = &mut arg1;
        apply_discount_if_eligible(&v0, arg0, v1);
        assert!(0x2::coin::value<T0>(&arg2) == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::base_amount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(&arg1)), 9223372401927127043);
        let v2 = PaymentsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::finalize_payment<PaymentsApp, T0>(arg1, arg0, v2, arg2)
    }

    public fun handle_payment<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::Receipt {
        let v0 = get_config_for_type<T0>(arg0);
        let v1 = &mut arg1;
        apply_discount_if_eligible(&v0, arg0, v1);
        let v2 = calculate_price<T0>(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::base_amount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(&arg1)), arg3, arg4);
        assert!(0x2::coin::value<T0>(&arg2) == v2, 9223372547956015107);
        assert!(arg5 >= v2, 9223372552251637773);
        let v3 = PaymentsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::finalize_payment<PaymentsApp, T0>(arg1, arg0, v3, arg2)
    }

    public fun new_coin_type_data<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: u8, arg2: vector<u8>) : CoinTypeData {
        CoinTypeData{
            decimals            : 0x2::coin::get_decimals<T0>(arg0),
            discount_percentage : arg1,
            price_feed_id       : arg2,
            type_name           : 0x1::type_name::get<T0>(),
        }
    }

    public fun new_payments_config(arg0: vector<CoinTypeData>, arg1: 0x1::type_name::TypeName, arg2: u64) : PaymentsConfig {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, CoinTypeData>();
        0x1::vector::reverse<CoinTypeData>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<CoinTypeData>(&arg0)) {
            let v2 = 0x1::vector::pop_back<CoinTypeData>(&mut arg0);
            0x2::vec_map::insert<0x1::type_name::TypeName, CoinTypeData>(&mut v0, v2.type_name, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<CoinTypeData>(arg0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinTypeData>(&v0, &arg1), 9223372955977777153);
        PaymentsConfig{
            currencies    : v0,
            base_currency : arg1,
            max_age       : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

