module 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_staking {
    entry fun claim_penalty<T0, T1>(arg0: &0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::AdminCap, arg1: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::claim_penalty<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun force_unstake<T0, T1>(arg0: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::force_unstake<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    entry fun stake<T0, T1>(arg0: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::StakeProof<T0, T1>>(0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    entry fun supply_rewards<T0, T1>(arg0: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::supply_rewards<T0, T1>(arg0, arg1, arg2);
    }

    entry fun unstake<T0, T1>(arg0: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg1: 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::unstake<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    entry fun update_flow_rate<T0, T1>(arg0: &0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::AdminCap, arg1: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::update_flow_rate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun update_max_penalty_rate<T0, T1>(arg0: &0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::AdminCap, arg1: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg2: u64) {
        0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::update_max_penalty_rate<T0, T1>(arg0, arg1, arg2);
    }

    entry fun claim_rewards<T0, T1>(arg0: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg1: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::StakeProof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::claim<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun create_penalty_vault<T0, T1>(arg0: &0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::AdminCap, arg1: &mut 0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::RepUSDFountain<T0, T1>, arg2: u64) {
        0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::new_penalty_vault<T0, T1>(arg0, arg1, arg2);
    }

    entry fun deploy_fountain<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::AdminCap>(0xb8fc53c8d0f7c85796787075e7fc269035db81d01df8f5a4596d0e7489e33620::repusd_fountain::create_fountain<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

