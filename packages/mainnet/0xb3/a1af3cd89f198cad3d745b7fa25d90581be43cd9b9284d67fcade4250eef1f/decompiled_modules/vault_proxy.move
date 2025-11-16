module 0xb3a1af3cd89f198cad3d745b7fa25d90581be43cd9b9284d67fcade4250eef1f::vault_proxy {
    public entry fun deposit_new_receipt<T0>(arg0: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::user_entry::deposit_with_auto_transfer<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::receipt::Receipt>(), arg5, arg6)
    }

    public entry fun deposit_with_receipt<T0>(arg0: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::reward_manager::RewardManager<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u256, arg5: 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::receipt::Receipt, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::user_entry::deposit_with_auto_transfer<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::receipt::Receipt>(arg5), arg6, arg7)
    }

    public entry fun request_withdraw_auto_transfer<T0>(arg0: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: u256, arg2: u64, arg3: &mut 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::receipt::Receipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::user_entry::withdraw_with_auto_transfer<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

