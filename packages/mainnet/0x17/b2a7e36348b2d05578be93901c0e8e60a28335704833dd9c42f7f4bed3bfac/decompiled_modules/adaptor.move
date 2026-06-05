module 0x17b2a7e36348b2d05578be93901c0e8e60a28335704833dd9c42f7f4bed3bfac::adaptor {
    struct TypusAdaptor has drop {
        dummy_field: bool,
    }

    struct TypusDepositBegan has copy, drop {
        amount_in: u64,
        min_share_out: u64,
    }

    struct TypusDepositFinished has copy, drop {
        amount_in: u64,
        share_out: u64,
    }

    struct TypusRedeemBegan has copy, drop {
        share_in: u64,
        min_amount_out: u64,
    }

    struct TypusRedeemFinished has copy, drop {
        share_in: u64,
        amount_out: u64,
    }

    public fun begin_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<TypusAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = TypusAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<TypusAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<TypusAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = TypusDepositBegan{
            amount_in     : arg1,
            min_share_out : arg2,
        };
        0x2::event::emit<TypusDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<TypusAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = TypusAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<TypusAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<TypusAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = TypusRedeemBegan{
            share_in       : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<TypusRedeemBegan>(v3);
        (v1, v2)
    }

    public fun finish_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<TypusAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<TypusAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = TypusAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<TypusAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<TypusAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = TypusDepositFinished{
            amount_in : v0,
            share_out : v1,
        };
        0x2::event::emit<TypusDepositFinished>(v3);
    }

    public fun finish_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<TypusAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<TypusAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = TypusAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<TypusAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<TypusAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = TypusRedeemFinished{
            share_in   : v0,
            amount_out : v1,
        };
        0x2::event::emit<TypusRedeemFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

