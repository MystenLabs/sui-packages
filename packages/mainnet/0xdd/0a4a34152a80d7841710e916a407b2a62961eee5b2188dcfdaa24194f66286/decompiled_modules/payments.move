module 0xdd0a4a34152a80d7841710e916a407b2a62961eee5b2188dcfdaa24194f66286::payments {
    struct PaymentsApp has drop {
        dummy_field: bool,
    }

    struct PaymentsConfig has drop, store {
        currencies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, CoinTypeData>,
        base_currency: 0x1::type_name::TypeName,
        max_age: u64,
        burn_bps: u64,
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
        assert!(v0.base_currency != 0x1::type_name::get<T0>(), 13906834797114032135);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg3, arg2, v0.max_age);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v3);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v4) == v1.price_feed_id, 13906834848653770761);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        calculate_target_currency_amount(arg1, v1.decimals, 0x2::vec_map::get<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v0.base_currency).decimals, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v6), (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8))
    }

    public fun calculate_price_after_discount<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent) : u64 {
        let v0 = get_config_for_type<T0>(arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::calculate_total_after_discount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg1), v0.discount_percentage)
    }

    public(friend) fun calculate_target_currency_amount(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u8) : u64 {
        assert!(arg3 > 0, 13906835149301612555);
        (0x1::u128::divide_and_round_up(0x1::u128::divide_and_round_up((arg0 as u128) * 0x1::u128::pow(10, 10 + arg1 + arg4 - arg2), (arg3 as u128)), 0x1::u128::pow(10, 10)) as u64)
    }

    fun deposit_into_bbb_vault<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::BBBVault, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, (((0x2::coin::value<T0>(arg2) as u128) * (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0).burn_bps as u128) / 10000) as u64), arg3));
    }

    fun get_config_for_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : CoinTypeData {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1), 13906835316804943877);
        *0x2::vec_map::get<0x1::type_name::TypeName, CoinTypeData>(&v0.currencies, &v1)
    }

    public fun handle_base_payment<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::BBBVault, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::Receipt {
        assert!(0x1::type_name::get<T0>() == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<PaymentsConfig>(arg0).base_currency, 13906834505056124933);
        let v0 = get_config_for_type<T0>(arg0);
        let v1 = &mut arg2;
        apply_discount_if_eligible(&v0, arg0, v1);
        assert!(0x2::coin::value<T0>(&arg3) == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::base_amount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(&arg2)), 13906834526530830339);
        let v2 = &mut arg3;
        deposit_into_bbb_vault<T0>(arg0, arg1, v2, arg4);
        let v3 = PaymentsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::finalize_payment<PaymentsApp, T0>(arg2, arg0, v3, arg3)
    }

    public fun handle_payment<T0>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::BBBVault, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::Receipt {
        let v0 = get_config_for_type<T0>(arg0);
        let v1 = &mut arg2;
        apply_discount_if_eligible(&v0, arg0, v1);
        let v2 = calculate_price<T0>(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::base_amount(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(&arg2)), arg4, arg5);
        assert!(0x2::coin::value<T0>(&arg3) == v2, 13906834689739587587);
        assert!(arg6 >= v2, 13906834694035210253);
        let v3 = &mut arg3;
        deposit_into_bbb_vault<T0>(arg0, arg1, v3, arg7);
        let v4 = PaymentsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::finalize_payment<PaymentsApp, T0>(arg2, arg0, v4, arg3)
    }

    public fun new_coin_type_data<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: u8, arg2: vector<u8>) : CoinTypeData {
        CoinTypeData{
            decimals            : 0x2::coin::get_decimals<T0>(arg0),
            discount_percentage : arg1,
            price_feed_id       : arg2,
            type_name           : 0x1::type_name::get<T0>(),
        }
    }

    public fun new_payments_config(arg0: vector<CoinTypeData>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) : PaymentsConfig {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, CoinTypeData>();
        0x1::vector::reverse<CoinTypeData>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<CoinTypeData>(&arg0)) {
            let v2 = 0x1::vector::pop_back<CoinTypeData>(&mut arg0);
            0x2::vec_map::insert<0x1::type_name::TypeName, CoinTypeData>(&mut v0, v2.type_name, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<CoinTypeData>(arg0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, CoinTypeData>(&v0, &arg1), 13906835076286513153);
        PaymentsConfig{
            currencies    : v0,
            base_currency : arg1,
            max_age       : arg2,
            burn_bps      : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

