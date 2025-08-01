module 0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::tclmm {
    public fun exs<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::cmnsp() + 1
        } else {
            0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg7), arg4, (arg5 as u128), true, v0, arg2, arg3, arg7);
        let v4 = v2;
        let v5 = v1;
        let v6 = if (arg4) {
            0x2::coin::value<T1>(&v4)
        } else {
            0x2::coin::value<T0>(&v5)
        };
        assert!(v6 >= arg6, 0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::e_amount_out_too_low());
        let (v7, v8) = if (arg4) {
            (0, 0)
        } else {
            (0, 0)
        };
        let (v9, v10) = if (arg4) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg1, v7, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg1, v8, arg7))
        };
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = if (arg4) {
            (0x2::coin::split<T0>(&mut v12, v7, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0x2::coin::split<T1>(&mut v11, v8, arg7))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v13, v14, v3, arg3);
        0x2::coin::join<T0>(&mut v12, v5);
        0x2::coin::join<T1>(&mut v11, v4);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v12, arg7);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v11, arg7);
    }

    // decompiled from Move bytecode v6
}

