module 0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::adaptor_oracle {
    public fun update_price<T0>(arg0: &mut 0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::pyth_oracle::Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::adaptor_pyth::update_price<T0>(arg0, arg1, arg3, arg4);
        0xb58f355d03ce22d89d6f8ef94808a7ecbc8c5464c3cf2e03797ff93c8edfba9e::adaptor_switchboard::update_price<T0>(arg0, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

