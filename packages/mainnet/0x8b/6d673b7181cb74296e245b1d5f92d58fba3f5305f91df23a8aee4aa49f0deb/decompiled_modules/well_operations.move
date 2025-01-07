module 0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::well_operations {
    public entry fun claim<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::StakedBKT<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::claim<T0>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_well_mut<T0>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun force_unstake<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BktTreasury, arg3: 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::StakedBKT<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::force_unstake<T0>(arg1, 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_well_mut<T0>(arg0), arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(v0, v2, arg4);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(v1, v2, arg4);
    }

    public entry fun stake<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::StakedBKT<T0>>(0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::stake<T0>(arg1, 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_well_mut<T0>(arg0), 0x2::coin::into_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake<T0>(arg0: &mut 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::StakedBKT<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::well::unstake<T0>(arg1, 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::buck::borrow_well_mut<T0>(arg0), arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::bkt::BKT>(v0, v2, arg3);
        0x8b6d673b7181cb74296e245b1d5f92d58fba3f5305f91df23a8aee4aa49f0deb::utils::transfer_non_zero_balance<T0>(v1, v2, arg3);
    }

    // decompiled from Move bytecode v6
}

