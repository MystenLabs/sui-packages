module 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::manage {
    public fun add_new_reward_type<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::RewardManager, arg2: &0x2::clock::Clock) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::add_new_reward_type<T0>(arg1, arg2);
    }

    public fun add_reward<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::RewardManager, arg2: 0x2::balance::Balance<T0>) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::add_reward<T0>(arg1, arg2);
    }

    public fun claim_penalty_amount<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::claim_penalty_amount<T0>(arg0, arg1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_owner_cap(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap>(0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::create_owner_cap(arg2), arg1);
    }

    public fun create_reward_manager<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::create_reward_manager<T0>(arg1, arg2);
    }

    public fun create_vault<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::create_vault<T0>(arg1);
    }

    public fun delete_owner_cap(arg0: 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::delete_owner_cap(arg0);
    }

    public fun distribute_reward<T0, T1>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::RewardManager, arg2: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg3: u256, arg4: &0x2::clock::Clock) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::distribute_reward<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun pause_vault<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::disable_vault<T0>(arg1);
    }

    public fun set_display<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::set_display<T0>(arg1, arg2);
    }

    public fun set_reward_rate<T0, T1>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::RewardManager, arg2: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg3: u256, arg4: &0x2::clock::Clock) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::set_reward_rate<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun unpause_vault<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::enable_vault<T0>(arg1);
    }

    public fun upgrade_reward_manager(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::RewardManager) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::reward::upgrade_reward_manager(arg1);
    }

    public fun upgrade_vault<T0>(arg0: &0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::OwnerCap, arg1: &mut 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::VeTokenVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault::upgrade_vault<T0>(arg1);
    }

    // decompiled from Move bytecode v6
}

