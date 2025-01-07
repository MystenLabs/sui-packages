module 0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::bucket_operations {
    public entry fun borrow<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun redeem<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x336be2a5fbdb2cce40356139c85fdda55d8fd35301ac204fb900a656ac7eaa5::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::redeem<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(arg3), arg4), 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun repay<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: 0x2::coin::Coin<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::top_up<T0>(arg0, 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::repay<T0>(arg0, 0x2::coin::into_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(arg1), arg3), 0x2::tx_context::sender(arg3), arg2);
    }

    public entry fun top_up<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::top_up<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
    }

    public entry fun repay_and_withdraw<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: 0x2::coin::Coin<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::repay<T0>(arg0, 0x2::coin::into_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BUCK>(arg1), arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

