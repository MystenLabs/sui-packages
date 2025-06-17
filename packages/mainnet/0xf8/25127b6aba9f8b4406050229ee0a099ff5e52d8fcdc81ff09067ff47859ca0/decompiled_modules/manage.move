module 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::manage {
    public fun add_new_reward_type<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: &0x2::clock::Clock) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::add_new_reward_type<T0>(arg1, arg2);
    }

    public fun add_reward<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: 0x2::balance::Balance<T0>) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::add_reward<T0>(arg1, arg2);
    }

    public fun claim_penalty_amount<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::claim_penalty_amount<T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_owner_cap(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap>(0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::create_owner_cap(arg2), arg1);
    }

    public fun create_reward_manager<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::create_reward_manager<T0>(arg1, arg2);
    }

    public fun create_vault<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::create_vault<T0>(arg1);
    }

    public fun delete_owner_cap(arg0: 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::delete_owner_cap(arg0);
    }

    public fun distribute_reward<T0, T1>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::distribute_reward<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun pause_vault<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::disable_vault<T0>(arg1);
    }

    public fun set_reward_rate<T0, T1>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager, arg2: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::set_reward_rate<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun unpause_vault<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::enable_vault<T0>(arg1);
    }

    public fun upgrade_reward_manager(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::RewardManager) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::reward::upgrade_reward_manager(arg1);
    }

    public fun upgrade_vault<T0>(arg0: &0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::OwnerCap, arg1: &mut 0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf825127b6aba9f8b4406050229ee0a099ff5e52d8fcdc81ff09067ff47859ca0::vault::upgrade_vault<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

