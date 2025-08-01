module 0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::cclmm {
    public fun exs<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::cmnsp()
        } else {
            0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::cmxsp()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg0, arg4, true, arg5, v0, arg2);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= arg6, 0x96a172bf44f8040a52c7fd97a4bf503c6f3edb931b08360b452689ddb7a511a1::ct::e_amount_out_too_low());
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        let (v9, v10) = if (arg4) {
            (v8, 0)
        } else {
            (0, v8)
        };
        let (v11, v12) = if (arg4) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg1, v8, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg1, v8, arg7))
        };
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v14, v9, arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v10, arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg0, v15, v16, v4);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::from_balance<T0>(v6, arg7));
        0x2::coin::join<T1>(&mut v13, 0x2::coin::from_balance<T1>(v5, arg7));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v14, arg7);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v13, arg7);
    }

    // decompiled from Move bytecode v6
}

