module 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::db {
    struct EE has copy, drop {
        ec: u64,
        ph: u64,
    }

    struct SSE<phantom T0, phantom T1> has copy, drop {
        d: u64,
        tit: u64,
        tot: u64,
        l: u64,
    }

    public fun bee<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg2: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<bool>, arg6: vector<u64>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ut::check_deadline(arg3, arg4);
        if (v0 != 0) {
            let v1 = EE{
                ec : v0,
                ph : 1,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T0>(arg1);
        let v3 = 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::balance_of<T1>(arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0x1::vector::length<bool>(&arg5);
        while (v9 < v10) {
            let v11 = *0x1::vector::borrow<bool>(&arg5, v9);
            let v12 = *0x1::vector::borrow<u64>(&arg7, v9);
            let (v13, v14) = vs<T0, T1>(arg0, arg3, v2, v3, v11, *0x1::vector::borrow<u64>(&arg6, v9), v12);
            if (v13 != 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good()) {
                let v15 = EE{
                    ec : v13,
                    ph : 2,
                };
                0x2::event::emit<EE>(v15);
                break
            };
            let (v16, v17, v18, v19, v20) = do<T0, T1>(arg1, arg2, arg0, v11, v14, v12, arg3, arg8);
            if (v16 != 0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good()) {
                let v21 = EE{
                    ec : v16,
                    ph : 3,
                };
                0x2::event::emit<EE>(v21);
                v9 = v9 + 1;
                continue
            };
            let v22 = v2 + v19;
            v2 = v22 - v17;
            let v23 = v3 + v20;
            v3 = v23 - v18;
            v4 = v4 + v17;
            v5 = v5 + v18;
            v6 = v6 + v19;
            v7 = v7 + v20;
            v8 = v8 + v12;
            v9 = v9 + 1;
        };
        let v24 = if (v4 > 0) {
            true
        } else if (v5 > 0) {
            true
        } else if (v6 > 0) {
            true
        } else {
            v7 > 0
        };
        if (v24) {
            let v25 = if (v10 > 0 && *0x1::vector::borrow<bool>(&arg5, 0)) {
                1
            } else {
                0
            };
            let v26 = SSE<T0, T1>{
                d   : v25,
                tit : v4 + v5,
                tot : v6 + v7,
                l   : v8,
            };
            0x2::event::emit<SSE<T0, T1>>(v26);
        };
    }

    fun do<T0, T1>(arg0: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T0>, arg1: &mut 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::Vault<T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        if (arg3) {
            let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T0>(arg0, arg4, arg7), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg5, arg6, arg7);
            let v8 = v6;
            let v9 = v5;
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v9);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v8);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good(), arg4 - 0x2::coin::value<T0>(&v9), 0, 0, 0x2::coin::value<T1>(&v8))
        } else {
            let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, 0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::withdraw_coin<T1>(arg1, arg4, arg7), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), arg5, arg6, arg7);
            let v13 = v11;
            let v14 = v10;
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T0>(arg0, v14);
            0x78633b3c519af1f210a3c02533c5a6595c20d39e2a0ad6b2a5652e029a737a88::treasury::deposit_coin<T1>(arg1, v13);
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v12);
            (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good(), 0, arg4 - 0x2::coin::value<T1>(&v13), 0x2::coin::value<T0>(&v14), 0)
        }
    }

    fun vs<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) : (u64, u64) {
        let (v0, v1) = if (arg4) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg5, arg1);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg5, arg1);
            (v5, v6)
        };
        let v8 = if (arg4) {
            v1
        } else {
            v0
        };
        if (v8 < arg6) {
            return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_slip(), 0)
        };
        if (arg4) {
            if (arg5 > arg2) {
                return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_inp(), 0)
            };
        } else if (arg5 > arg3) {
            return (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::e_inp(), 0)
        };
        (0x7b4ca34a0116a26eb547937decba364f556def1a0ce52d6f59823bade841bedf::ct::good(), arg5)
    }

    // decompiled from Move bytecode v6
}

