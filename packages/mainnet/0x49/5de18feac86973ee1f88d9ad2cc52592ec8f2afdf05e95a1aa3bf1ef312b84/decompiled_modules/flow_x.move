module 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::flow_x {
    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T1>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg0, v0, arg4);
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T1>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T1>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T0, T1>(arg0, v0, arg4);
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T1>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>, arg1: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T1, T0>(arg1, arg3, arg4);
        let v2 = v1;
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T0, T1>(arg0, v0, arg4);
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T1, T0>(0x2::coin::value<T0>(&v3), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T1, T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T1, T0>(arg1, v2, arg2, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

