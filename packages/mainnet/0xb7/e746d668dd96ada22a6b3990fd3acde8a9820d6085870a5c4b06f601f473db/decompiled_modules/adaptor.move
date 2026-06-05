module 0xb7e746d668dd96ada22a6b3990fd3acde8a9820d6085870a5c4b06f601f473db::adaptor {
    struct CurrentAdaptor has drop {
        dummy_field: bool,
    }

    struct CurrentDepositBegan has copy, drop {
        amount_in: u64,
        min_share_out: u64,
    }

    struct CurrentDepositFinished has copy, drop {
        amount_in: u64,
        share_out: u64,
    }

    struct CurrentRedeemBegan has copy, drop {
        share_in: u64,
        min_amount_out: u64,
    }

    struct CurrentRedeemFinished has copy, drop {
        share_in: u64,
        amount_out: u64,
    }

    public fun begin_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<CurrentAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = CurrentAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<CurrentAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<CurrentAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = CurrentDepositBegan{
            amount_in     : arg1,
            min_share_out : arg2,
        };
        0x2::event::emit<CurrentDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<CurrentAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = CurrentAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<CurrentAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<CurrentAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = CurrentRedeemBegan{
            share_in       : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<CurrentRedeemBegan>(v3);
        (v1, v2)
    }

    public fun finish_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<CurrentAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<CurrentAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = CurrentAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<CurrentAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<CurrentAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = CurrentDepositFinished{
            amount_in : v0,
            share_out : v1,
        };
        0x2::event::emit<CurrentDepositFinished>(v3);
    }

    public fun finish_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<CurrentAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<CurrentAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = CurrentAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<CurrentAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<CurrentAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = CurrentRedeemFinished{
            share_in   : v0,
            amount_out : v1,
        };
        0x2::event::emit<CurrentRedeemFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

