module 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::price {
    public fun get_price(arg0: &0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::price_feed::PriceFeed>(v0, arg1), 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::price_feed::last_updated(v1), 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xa5e7af50df270daf0917be0c6919bcbeb322b6cb43b04aae5a1e9d4113024502::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x8fdad2870785b808cdb6ffa881eff64cf905f292069c830132e83f533c79e7f0::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

