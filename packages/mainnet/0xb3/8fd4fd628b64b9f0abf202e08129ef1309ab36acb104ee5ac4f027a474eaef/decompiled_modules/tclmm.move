module 0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::tclmm {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::cmnsp() + 1
        } else {
            0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg7), arg4, (arg5 as u128), true, v0, arg2, arg3, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::coin::value<T1>(&v5)
        } else {
            0x2::coin::value<T0>(&v6)
        };
        assert!(v7 >= arg6, 0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::e_amount_out_too_low());
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        let (v11, v12) = if (arg4) {
            (v10, 0)
        } else {
            (0, v10)
        };
        let (v13, v14) = if (arg4) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg1, v11, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg1, v12, arg7))
        };
        let v15 = v14;
        let v16 = v13;
        let (v17, v18) = if (arg4) {
            (0x2::coin::split<T0>(&mut v16, v11, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0x2::coin::split<T1>(&mut v15, v12, arg7))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v17, v18, v4, arg3);
        0x2::coin::join<T0>(&mut v16, v6);
        0x2::coin::join<T1>(&mut v15, v5);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v16, arg7);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v15, arg7);
        let v19 = AS{
            ai : v10,
            ao : v7,
        };
        0x2::event::emit<AS>(v19);
    }

    // decompiled from Move bytecode v6
}

