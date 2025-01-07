module 0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::tank_operations {
    public entry fun claim<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BktTreasury, arg2: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::claim<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_tank_mut<T0>(arg0), arg1, arg2, arg3);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(v1, v0, arg3);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(v2, v0, arg3);
    }

    public entry fun deposit<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: 0x2::coin::Coin<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::deposit<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_tank_mut<T0>(arg0), 0x2::coin::into_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BktTreasury, arg4: vector<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::balance::zero<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>();
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::zero<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>();
        let v4 = 0x1::vector::length<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>(&arg4);
        while (v4 > 0) {
            let (v5, v6, v7) = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::tank_withdraw<T0>(arg0, arg1, arg2, arg3, 0x1::vector::pop_back<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>(&mut arg4), arg6);
            0x2::balance::join<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(&mut v1, v5);
            0x2::balance::join<T0>(&mut v2, v6);
            0x2::balance::join<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(&mut v3, v7);
            v4 = v4 - 1;
        };
        0x1::vector::destroy_empty<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>(arg4);
        let v8 = 0x2::balance::value<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(&v1) - arg5;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::ContributorToken<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank::deposit<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK, T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_tank_mut<T0>(arg0), 0x2::balance::split<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(&mut v1, v8), arg6), v0);
        };
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(v1, v0, arg6);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(v2, v0, arg6);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(v3, v0, arg6);
    }

    // decompiled from Move bytecode v6
}

