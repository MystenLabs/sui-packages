module 0xcdef41061c0fe6be798ddebbf442c461cccaf1407e305933715cbc4d345233aa::suilend {
    struct SuilendYieldInfo has copy, drop, store {
        lending_market_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        array_index: u64,
        borrow_apr: u64,
        deposit_apr: u64,
        available_amount: u64,
        ctoken_supply: u64,
        borrowed_amount: u64,
    }

    fun calculate_aprs<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>) : (u64, u64) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::calculate_utilization_rate<T0>(arg0);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_apr(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg0), v0);
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::calculate_supply_apr(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::config<T0>(arg0), v0, v1)))
    }

    fun create_yield_info<T0>(arg0: 0x2::object::ID, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>) : SuilendYieldInfo {
        let (v0, v1) = calculate_aprs<T0>(arg1);
        SuilendYieldInfo{
            lending_market_id : arg0,
            coin_type         : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(arg1),
            array_index       : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(arg1),
            borrow_apr        : v0,
            deposit_apr       : v1,
            available_amount  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(arg1),
            ctoken_supply     : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T0>(arg1),
            borrowed_amount   : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::borrowed_amount<T0>(arg1)),
        }
    }

    public fun get_yields<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : vector<SuilendYieldInfo> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg0);
        let v1 = 0x1::vector::empty<SuilendYieldInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0)) {
            0x1::vector::push_back<SuilendYieldInfo>(&mut v1, create_yield_info<T0>(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg0), 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

