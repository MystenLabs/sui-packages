module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::settlement {
    struct PaymentSettled has copy, drop {
        work_object_id: 0x2::object::ID,
        agent: address,
        amount: u64,
    }

    public fun pay_agent_and_record(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::AgentRegistration, arg2: &mut 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::WorkObject, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg3, 1);
        let v0 = 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::agent_address(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg3, arg4), v0);
        0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::record_consumption(arg2, v0);
        0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::agent_registry::bump_reputation(arg1, 1);
        let v1 = PaymentSettled{
            work_object_id : 0x2::object::id<0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::work_object::WorkObject>(arg2),
            agent          : v0,
            amount         : arg3,
        };
        0x2::event::emit<PaymentSettled>(v1);
    }

    // decompiled from Move bytecode v7
}

