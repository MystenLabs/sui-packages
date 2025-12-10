module 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::nest {
    public fun harvest_duck(arg0: &0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::Init, arg1: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::StakedDuck, arg2: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::Nest, arg3: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::HarvestStats, arg4: &0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::NestMintCap, arg5: &mut 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::shttoken::SharedTreasury, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x3deee338e15085edee02a05abf04f52de4fbda532c323243ec158ab37db2cae1::utils::get_init_data(arg0);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg8);
        assert!(0x2::vec_set::contains<address>(&v2, &v3), 2);
        let (_, _, v6, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::get_harvest_stats(arg3);
        0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::harvest_duck(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (_, _, v11, _, _) = 0x61e6afef2cafd54a7f9824e5301a02224bd2cf9ab9c52ce4e780d2ae6f09e413::nest::get_harvest_stats(arg3);
        assert!(v6 != v11, 1);
    }

    // decompiled from Move bytecode v6
}

