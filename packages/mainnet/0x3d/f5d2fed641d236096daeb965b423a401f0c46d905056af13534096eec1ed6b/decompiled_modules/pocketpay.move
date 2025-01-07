module 0x3df5d2fed641d236096daeb965b423a401f0c46d905056af13534096eec1ed6b::pocketpay {
    struct Details has store, key {
        id: 0x2::object::UID,
        amount: u64,
        merchant_name: 0x1::string::String,
        order_id: u64,
    }

    struct DetailsEvent has copy, drop {
        amount: u64,
        merchant_name: 0x1::string::String,
        order_id: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun send_tx<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg5, arg6, arg7);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 4);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        assert!(v3 > 0, 1);
        let v4 = (arg3 as u128) * (0x2::math::pow(10, ((3 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2)) as u8)) as u128) / (v3 as u128);
        assert!(v4 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg0), (v4 as u64), arg8), arg1);
        let v5 = Details{
            id            : 0x2::object::new(arg8),
            amount        : (v4 as u64),
            merchant_name : arg2,
            order_id      : arg4,
        };
        let v6 = DetailsEvent{
            amount        : (v4 as u64),
            merchant_name : arg2,
            order_id      : arg4,
        };
        0x2::event::emit<DetailsEvent>(v6);
        0x2::transfer::transfer<Details>(v5, 0x2::tx_context::sender(arg8));
    }

    public entry fun send_tx1<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg5, arg6, arg7);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 4);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        assert!(v3 > 0, 1);
        let v4 = (arg3 as u128) * (0x2::math::pow(10, ((9 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2)) as u8)) as u128) / (v3 as u128);
        assert!(v4 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg0), (v4 as u64), arg8), arg1);
        let v5 = Details{
            id            : 0x2::object::new(arg8),
            amount        : (v4 as u64),
            merchant_name : arg2,
            order_id      : arg4,
        };
        let v6 = DetailsEvent{
            amount        : (v4 as u64),
            merchant_name : arg2,
            order_id      : arg4,
        };
        0x2::event::emit<DetailsEvent>(v6);
        0x2::transfer::transfer<Details>(v5, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

