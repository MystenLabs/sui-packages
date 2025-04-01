module 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::reserve {
    struct Reserve has store, key {
        id: 0x2::object::UID,
        array_index: u64,
        coin_type: 0x1::type_name::TypeName,
        mint_decimals: u8,
        available_amount: u64,
        price_identifier: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal,
        smoothed_price: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        pause: bool,
    }

    struct Balances<phantom T0> has store {
        available_amount: 0x2::balance::Balance<T0>,
    }

    struct BalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReserveAssetDataEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        available_amount: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal,
        price: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal,
        smoothed_price: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal,
        price_last_update_timestamp_s: u64,
        pause: bool,
    }

    public fun price_identifier(arg0: &Reserve) : &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier {
        &arg0.price_identifier
    }

    public fun array_index(arg0: &Reserve) : u64 {
        arg0.array_index
    }

    public fun assert_pause(arg0: &Reserve) {
        assert!(!pause_status(arg0), 4);
    }

    public fun assert_price_is_fresh(arg0: &Reserve, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 - arg0.price_last_update_timestamp_s <= 0, 0);
    }

    public fun available_amount(arg0: &Reserve) : u64 {
        arg0.available_amount
    }

    public(friend) fun back_token<T0>(arg0: &mut Reserve, arg1: u64, arg2: bool) : 0x2::balance::Balance<T0> {
        assert!(coin_type(arg0) == 0x1::type_name::get<T0>(), 3);
        if (arg2) {
            arg0.available_amount = arg0.available_amount - arg1;
            log_reserve_data(arg0);
        };
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::split<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v0).available_amount, arg1)
    }

    public fun balances<T0>(arg0: &Reserve) : &Balances<T0> {
        let v0 = BalanceKey{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceKey, Balances<T0>>(&arg0.id, v0)
    }

    public fun balances_available_amount<T0>(arg0: &Balances<T0>) : &0x2::balance::Balance<T0> {
        &arg0.available_amount
    }

    public(friend) fun change_price_feed(arg0: &mut Reserve, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let (_, _, v2) = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::oracles::get_pyth_price_and_identifier(arg1, arg2);
        arg0.price_identifier = v2;
    }

    public fun coin_type(arg0: &Reserve) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun create_reserve<T0>(arg0: u64, arg1: u8, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Reserve {
        let (v0, v1, v2) = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::oracles::get_pyth_price_and_identifier(arg2, arg3);
        let v3 = v0;
        let v4 = Reserve{
            id                            : 0x2::object::new(arg4),
            array_index                   : arg0,
            coin_type                     : 0x1::type_name::get<T0>(),
            mint_decimals                 : arg1,
            available_amount              : 0,
            price_identifier              : v2,
            price                         : 0x1::option::extract<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal>(&mut v3),
            smoothed_price                : v1,
            price_last_update_timestamp_s : 0x2::clock::timestamp_ms(arg3) / 1000,
            pause                         : false,
        };
        let v5 = BalanceKey{dummy_field: false};
        let v6 = Balances<T0>{available_amount: 0x2::balance::zero<T0>()};
        0x2::dynamic_field::add<BalanceKey, Balances<T0>>(&mut v4.id, v5, v6);
        v4
    }

    fun log_reserve_data(arg0: &Reserve) {
        let v0 = ReserveAssetDataEvent{
            coin_type                     : arg0.coin_type,
            reserve_id                    : 0x2::object::uid_to_address(&arg0.id),
            available_amount              : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(arg0.available_amount),
            price                         : arg0.price,
            smoothed_price                : arg0.smoothed_price,
            price_last_update_timestamp_s : arg0.price_last_update_timestamp_s,
            pause                         : arg0.pause,
        };
        0x2::event::emit<ReserveAssetDataEvent>(v0);
    }

    public fun pause_status(arg0: &Reserve) : bool {
        arg0.pause
    }

    public fun price(arg0: &Reserve) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        arg0.price
    }

    public fun price_lower_bound(arg0: &Reserve) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::min(arg0.price, arg0.smoothed_price)
    }

    public fun price_upper_bound(arg0: &Reserve) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::max(arg0.price, arg0.smoothed_price)
    }

    public(friend) fun receive_token<T0>(arg0: &mut Reserve, arg1: 0x2::balance::Balance<T0>, arg2: bool) {
        assert!(coin_type(arg0) == 0x1::type_name::get<T0>(), 3);
        if (arg2) {
            arg0.available_amount = arg0.available_amount + 0x2::balance::value<T0>(&arg1);
            log_reserve_data(arg0);
        };
        let v0 = BalanceKey{dummy_field: false};
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<BalanceKey, Balances<T0>>(&mut arg0.id, v0).available_amount, arg1);
    }

    public(friend) fun set_pause_status(arg0: &mut Reserve, arg1: bool) {
        arg0.pause = arg1;
        log_reserve_data(arg0);
    }

    public fun token_amount_to_usd(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(price(arg0), arg1), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public fun token_amount_to_usd_lower_bound(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(price_lower_bound(arg0), arg1), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public fun token_amount_to_usd_upper_bound(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(price_upper_bound(arg0), arg1), 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)))
    }

    public(friend) fun update_price(arg0: &mut Reserve, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let (v0, v1, v2) = 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::oracles::get_pyth_price_and_identifier(arg2, arg1);
        let v3 = v0;
        assert!(v2 == arg0.price_identifier, 1);
        assert!(0x1::option::is_some<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal>(&v3), 2);
        arg0.price = 0x1::option::extract<0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal>(&mut v3);
        arg0.smoothed_price = v1;
        arg0.price_last_update_timestamp_s = 0x2::clock::timestamp_ms(arg1) / 1000;
    }

    public fun usd_to_token_amount(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)), arg1), price(arg0))
    }

    public fun usd_to_token_amount_lower_bound(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)), arg1), price_upper_bound(arg0))
    }

    public fun usd_to_token_amount_upper_bound(arg0: &Reserve, arg1: 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal) : 0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::Decimal {
        0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::div(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::mul(0xc32e4b566685716898b3ff6776f5568c93c78c0ee2d5be60b60048410d653f2f::decimal::from(0x1::u64::pow(10, arg0.mint_decimals)), arg1), price_lower_bound(arg0))
    }

    // decompiled from Move bytecode v6
}

