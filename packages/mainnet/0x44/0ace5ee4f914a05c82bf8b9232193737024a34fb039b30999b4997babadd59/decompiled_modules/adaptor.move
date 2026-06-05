module 0x440ace5ee4f914a05c82bf8b9232193737024a34fb039b30999b4997babadd59::adaptor {
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

    public fun begin_vault_deposit<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = BluefinAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<BluefinAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<BluefinAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = BluefinVaultDepositBegan{
            amount_in     : arg1,
            min_share_out : arg2,
        };
        0x2::event::emit<BluefinVaultDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_vault_redeem<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = BluefinAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<BluefinAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<BluefinAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = BluefinVaultRedeemBegan{
            share_in       : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<BluefinVaultRedeemBegan>(v3);
        (v1, v2)
    }

    public fun finish_vault_deposit<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::wallet_swap_witness_amount_in<BluefinAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = BluefinAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<BluefinAdaptor, T0, T1>(arg0, arg1, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<BluefinAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = BluefinVaultDepositFinished{
            amount_in : v0,
            share_out : v1,
        };
        0x2::event::emit<BluefinVaultDepositFinished>(v3);
    }

    public fun finish_vault_redeem<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<BluefinAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::wallet_swap_witness_amount_in<BluefinAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = BluefinAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<BluefinAdaptor, T0, T1>(arg0, arg1, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<BluefinAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = BluefinVaultRedeemFinished{
            share_in   : v0,
            amount_out : v1,
        };
        0x2::event::emit<BluefinVaultRedeemFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

