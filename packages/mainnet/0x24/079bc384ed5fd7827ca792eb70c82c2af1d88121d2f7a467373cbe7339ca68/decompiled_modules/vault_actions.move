module 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault_actions {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::app::AdminCap, arg1: &mut 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::new_vault<T0, T1>(arg0, arg1);
        0x2::transfer::public_share_object<0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::Vault<T0, T1>>(v0);
        0x2::transfer::public_transfer<0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::Vault<T0, T1>, arg1: 0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x24079bc384ed5fd7827ca792eb70c82c2af1d88121d2f7a467373cbe7339ca68::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

