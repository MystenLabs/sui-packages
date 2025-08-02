module 0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::mclmm {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: bool, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::cmnsp() + 1
        } else {
            0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg4, true, arg5, v0, arg2, arg3, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= arg6, 0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::ct::e_amount_out_too_low());
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v10 = if (arg4) {
            v8
        } else {
            v9
        };
        let (v11, v12) = if (arg4) {
            (0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg1, v8, arg7), 0x2::coin::zero<T1>(arg7))
        } else {
            (0x2::coin::zero<T0>(arg7), 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg1, v9, arg7))
        };
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v14, v8, arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v9, arg7)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v15, v16, arg3, arg7);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::from_balance<T0>(v6, arg7));
        0x2::coin::join<T1>(&mut v13, 0x2::coin::from_balance<T1>(v5, arg7));
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v14, arg7);
        0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v13, arg7);
        let v17 = AS{
            ai : v10,
            ao : v7,
        };
        0x2::event::emit<AS>(v17);
    }

    // decompiled from Move bytecode v6
}

