module 0xfd9ccac3fafa6f7ebe43eef76fb3262ba86f143d9aa068b93b9cbc1473305198::f {
    struct LL<phantom T0> {
        receipt: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        repay_amount: u64,
    }

    public fun bb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = LL<T0>{
            receipt      : v1,
            repay_amount : arg1,
        };
        (0x2::coin::into_balance<T0>(v0), v2)
    }

    public fun bq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = LL<T1>{
            receipt      : v1,
            repay_amount : arg1,
        };
        (0x2::coin::into_balance<T1>(v0), v2)
    }

    public fun rb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v1), arg3), v0);
        arg1
    }

    public fun rq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            receipt      : v0,
            repay_amount : v1,
        } = arg2;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v1), arg3), v0);
        arg1
    }

    // decompiled from Move bytecode v7
}

