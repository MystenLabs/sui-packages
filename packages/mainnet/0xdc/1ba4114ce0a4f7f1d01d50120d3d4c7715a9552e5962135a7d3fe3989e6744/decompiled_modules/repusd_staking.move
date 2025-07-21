module 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_staking {
    entry fun claim_rewards<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::claim_rewards<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun supply_rewards<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::supply_rewards<T0, T1>(arg0, arg1, arg2);
    }

    entry fun unstake<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::unstake<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    entry fun update_flow_rate<T0, T1>(arg0: &0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::AdminCap, arg1: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::update_flow_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun deploy_fountain<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::AdminCap>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::create_fountain<T0, T1>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun get_apr_info() : (u64, u64, u64, u64) {
        (0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::get_apr_for_lock_period(0), 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::get_apr_for_lock_period(2592000000), 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::get_apr_for_lock_period(7776000000), 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::get_apr_for_lock_period(15552000000))
    }

    entry fun pause_fountain<T0, T1>(arg0: &0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::AdminCap, arg1: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>) {
        0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::set_paused<T0, T1>(arg0, arg1, true);
    }

    entry fun stake_180_days<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::stake<T0, T1>(arg0, arg1, 15552000000, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun stake_30_days<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::stake<T0, T1>(arg0, arg1, 2592000000, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun stake_90_days<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::stake<T0, T1>(arg0, arg1, 7776000000, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun stake_no_lock<T0, T1>(arg0: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::StakePosition<T0, T1>>(0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::stake<T0, T1>(arg0, arg1, 0, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun unpause_fountain<T0, T1>(arg0: &0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::AdminCap, arg1: &mut 0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::RepUSDFountain<T0, T1>) {
        0xdc1ba4114ce0a4f7f1d01d50120d3d4c7715a9552e5962135a7d3fe3989e6744::repusd_fountain::set_paused<T0, T1>(arg0, arg1, false);
    }

    // decompiled from Move bytecode v6
}

