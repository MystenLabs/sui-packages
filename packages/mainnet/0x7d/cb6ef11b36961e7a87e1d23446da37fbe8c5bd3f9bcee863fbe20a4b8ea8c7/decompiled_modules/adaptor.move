module 0x7dcb6ef11b36961e7a87e1d23446da37fbe8c5bd3f9bcee863fbe20a4b8ea8c7::adaptor {
    struct AftermathAdaptor has drop {
        dummy_field: bool,
    }

    struct AftermathVaultDepositBegan has copy, drop {
        amount_in: u64,
        min_lp_out: u64,
    }

    struct AftermathVaultDepositFinished has copy, drop {
        amount_in: u64,
        lp_out: u64,
    }

    struct AftermathVaultRedeemBegan has copy, drop {
        lp_in: u64,
        min_amount_out: u64,
    }

    struct AftermathVaultRedeemFinished has copy, drop {
        lp_in: u64,
        amount_out: u64,
    }

    public fun begin_vault_deposit<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<AftermathAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = AftermathAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<AftermathAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<AftermathAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = AftermathVaultDepositBegan{
            amount_in  : arg1,
            min_lp_out : arg2,
        };
        0x2::event::emit<AftermathVaultDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_vault_redeem<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<AftermathAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = AftermathAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<AftermathAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<AftermathAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = AftermathVaultRedeemBegan{
            lp_in          : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<AftermathVaultRedeemBegan>(v3);
        (v1, v2)
    }

    public fun finish_vault_deposit<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<AftermathAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::wallet_swap_witness_amount_in<AftermathAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = AftermathAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<AftermathAdaptor, T0, T1>(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<AftermathAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = AftermathVaultDepositFinished{
            amount_in : v0,
            lp_out    : v1,
        };
        0x2::event::emit<AftermathVaultDepositFinished>(v3);
    }

    public fun finish_vault_redeem<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<AftermathAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::wallet_swap_witness_amount_in<AftermathAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = AftermathAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<AftermathAdaptor, T0, T1>(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<AftermathAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = AftermathVaultRedeemFinished{
            lp_in      : v0,
            amount_out : v1,
        };
        0x2::event::emit<AftermathVaultRedeemFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

