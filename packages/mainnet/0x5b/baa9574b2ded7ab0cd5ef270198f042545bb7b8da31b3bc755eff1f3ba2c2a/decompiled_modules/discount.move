module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::discount {
    struct MintDiscountBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
        percentage: 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal,
        exp_ts_seconds: u64,
    }

    public(friend) fun assert_expiration<T0>(arg0: &MintDiscountBadge<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.exp_ts_seconds > 0x2::clock::timestamp_ms(arg1) / 1000, 600);
    }

    public fun mint_discount<T0>(arg0: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::index::Index<T0>, arg1: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MintDiscountBadge<T0> {
        assert!(arg3 > 0 && arg3 <= 10000, 601);
        MintDiscountBadge<T0>{
            id             : 0x2::object::new(arg4),
            percentage     : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_percentage(arg3),
            exp_ts_seconds : arg2,
        }
    }

    public(friend) fun percentage<T0>(arg0: &MintDiscountBadge<T0>) : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::Decimal {
        arg0.percentage
    }

    // decompiled from Move bytecode v6
}

