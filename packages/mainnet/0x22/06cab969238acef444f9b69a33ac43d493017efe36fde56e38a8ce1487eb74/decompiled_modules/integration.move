module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::integration {
    public fun complete_workflow_after_validation(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::release_payment(arg2, arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_system_treasury_address(), arg3, arg4);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector::complete_job(arg1);
    }

    public fun create_bin_with_escrow(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: address, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) {
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::create_bin(arg0, arg1, arg2, arg6);
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::create_escrow(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(&v0), arg3, arg4, arg5, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_default_collector_reward(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_default_validator_reward(), arg6);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::link_escrow(&mut v0, 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&v1), arg6);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

