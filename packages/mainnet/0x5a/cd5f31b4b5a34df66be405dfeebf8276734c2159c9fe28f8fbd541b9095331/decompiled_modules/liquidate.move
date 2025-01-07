module 0x5acd5f31b4b5a34df66be405dfeebf8276734c2159c9fe28f8fbd541b9095331::liquidate {
    public entry fun liquidate<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &mut 0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::tx_context::TxContext) {
        0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::bucket_oracle::update_price_from_switchboard<T0>(arg1, arg2, arg3);
        let v0 = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bucket::has_liquidatable_bottle<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        assert!(v0, 0);
        let v1 = 0x2::balance::zero<T0>();
        while (v0) {
            let v2 = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_bucket<T0>(arg0);
            let v3 = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bucket::get_lowest_cr_debtor<T0>(v2);
            if (0x1::option::is_none<address>(&v3)) {
                break
            };
            let v4 = if (0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bucket::is_in_recovery_mode<T0>(v2, arg1, arg2)) {
                0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::liquidate_under_recovery_mode<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v3))
            } else {
                0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::liquidate_under_normal_mode<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v3))
            };
            0x2::balance::join<T0>(&mut v1, v4);
            v0 = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bucket::has_liquidatable_bottle<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_bucket<T0>(arg0), arg1, arg2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4), @0x8d17d7480363059539dd21db094c50ae164c33928c517122734e2bd46951d431);
    }

    // decompiled from Move bytecode v6
}

