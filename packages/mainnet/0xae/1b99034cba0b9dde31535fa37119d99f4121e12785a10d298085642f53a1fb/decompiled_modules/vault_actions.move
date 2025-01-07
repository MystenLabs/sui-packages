module 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault_actions {
    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::app::AdminCap, arg1: &mut 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::new_vault<T0, T1>(arg0, arg1);
        0x2::transfer::public_share_object<0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::Vault<T0, T1>>(v0);
        0x2::transfer::public_transfer<0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::Vault<T0, T1>, arg1: 0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::VaultLpToken<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xae1b99034cba0b9dde31535fa37119d99f4121e12785a10d298085642f53a1fb::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

