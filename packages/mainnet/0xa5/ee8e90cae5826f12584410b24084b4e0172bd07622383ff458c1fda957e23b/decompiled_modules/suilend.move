module 0xa5ee8e90cae5826f12584410b24084b4e0172bd07622383ff458c1fda957e23b::suilend {
    struct MarketData has copy, drop, store {
        pools: vector<PoolData>,
    }

    struct PoolData has copy, drop, store {
        lending_market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        array_index: u64,
        borrow_apr: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        deposit_apr: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        cumulative_borrow_rate: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        total_supply: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        isolated: bool,
        borrow_limit: u64,
        deposit_limit: u64,
    }

    fun calculate_aprs<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::calculate_utilization_rate<T0>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_apr(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg0), v0);
        (v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_supply_apr(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg0), v0, v1))
    }

    fun create_yield_info<T0>(arg0: 0x2::object::ID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>) : PoolData {
        let (v0, v1) = calculate_aprs<T0>(arg1);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg1);
        PoolData{
            lending_market_id      : arg0,
            coin_type              : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(arg1),
            array_index            : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(arg1),
            borrow_apr             : v0,
            deposit_apr            : v1,
            available_amount       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(arg1),
            ctoken_supply          : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(arg1),
            borrowed_amount        : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::borrowed_amount<T0>(arg1),
            cumulative_borrow_rate : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::cumulative_borrow_rate<T0>(arg1),
            total_supply           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T0>(arg1),
            isolated               : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::isolated(v2),
            borrow_limit           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::borrow_limit(v2),
            deposit_limit          : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::deposit_limit(v2),
        }
    }

    public fun market_data<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v1 = 0x1::vector::empty<PoolData>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
            0x1::vector::push_back<PoolData>(&mut v1, create_yield_info<T0>(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0), 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v2)));
            v2 = v2 + 1;
        };
        let v3 = MarketData{pools: v1};
        0x2::event::emit<MarketData>(v3);
    }

    // decompiled from Move bytecode v6
}

