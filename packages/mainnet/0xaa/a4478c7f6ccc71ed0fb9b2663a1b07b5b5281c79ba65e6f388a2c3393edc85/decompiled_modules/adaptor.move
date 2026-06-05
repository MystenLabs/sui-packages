module 0xaaa4478c7f6ccc71ed0fb9b2663a1b07b5b5281c79ba65e6f388a2c3393edc85::adaptor {
    struct BluefinAdaptor has drop {
        dummy_field: bool,
    }

    struct BluefinVaultDepositBegan has copy, drop {
        amount_in: u64,
        min_share_out: u64,
    }

    struct BluefinVaultDepositFinished has copy, drop {
        amount_in: u64,
        share_out: u64,
    }

    struct BluefinVaultRedeemBegan has copy, drop {
        share_in: u64,
        min_amount_out: u64,
    }

    struct BluefinVaultRedeemFinished has copy, drop {
        share_in: u64,
        amount_out: u64,
    }

    public fun begin_vault_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = BluefinAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<BluefinAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<BluefinAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = BluefinVaultDepositBegan{
            amount_in     : arg1,
            min_share_out : arg2,
        };
        0x2::event::emit<BluefinVaultDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_vault_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = BluefinAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<BluefinAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<BluefinAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = BluefinVaultRedeemBegan{
            share_in       : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<BluefinVaultRedeemBegan>(v3);
        (v1, v2)
    }

    public fun finish_vault_deposit<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<BluefinAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = BluefinAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<BluefinAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<BluefinAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = BluefinVaultDepositFinished{
            amount_in : v0,
            share_out : v1,
        };
        0x2::event::emit<BluefinVaultDepositFinished>(v3);
    }

    public fun finish_vault_redeem<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<BluefinAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = BluefinAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<BluefinAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<BluefinAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = BluefinVaultRedeemFinished{
            share_in   : v0,
            amount_out : v1,
        };
        0x2::event::emit<BluefinVaultRedeemFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

