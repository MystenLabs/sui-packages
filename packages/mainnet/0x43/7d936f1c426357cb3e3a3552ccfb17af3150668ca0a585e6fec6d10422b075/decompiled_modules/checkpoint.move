module 0x437d936f1c426357cb3e3a3552ccfb17af3150668ca0a585e6fec6d10422b075::checkpoint {
    struct Receipt<phantom T0, phantom T1> {
        coinInAmount: u64,
        coinOutMin: u64,
        coinInFeeRate: u64,
        coinOutFeeRate: u64,
        feeReceiver: address,
    }

    struct Settled<phantom T0, phantom T1> has copy, drop {
        coinInAmount: u64,
        coinOutMin: u64,
        coinInFeeRate: u64,
        coinOutFeeRate: u64,
        feeReceiver: address,
        exactCoinOutAmount: u64,
    }

    public fun settle<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: Receipt<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let Receipt {
            coinInAmount   : v0,
            coinOutMin     : v1,
            coinInFeeRate  : v2,
            coinOutFeeRate : v3,
            feeReceiver    : v4,
        } = arg1;
        let v5 = 0x2::coin::value<T1>(&arg0);
        assert!(v5 >= v1, 1);
        assert!(v3 <= 100, 0);
        let v6 = Settled<T0, T1>{
            coinInAmount       : v0,
            coinOutMin         : v1,
            coinInFeeRate      : v2,
            coinOutFeeRate     : v3,
            feeReceiver        : v4,
            exactCoinOutAmount : v5,
        };
        0x2::event::emit<Settled<T0, T1>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0, v5 * v3 / 10000, arg2), v4);
        arg0
    }

    public fun start<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0, T1>) {
        assert!(arg2 <= 100, 0);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = Receipt<T0, T1>{
            coinInAmount   : v0,
            coinOutMin     : arg1,
            coinInFeeRate  : arg2,
            coinOutFeeRate : arg3,
            feeReceiver    : arg4,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v0 * arg2 / 10000, arg5), arg4);
        (arg0, v1)
    }

    // decompiled from Move bytecode v6
}

