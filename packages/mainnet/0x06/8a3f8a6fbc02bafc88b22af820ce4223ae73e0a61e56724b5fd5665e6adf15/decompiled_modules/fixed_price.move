module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::fixed_price {
    struct Policy has drop {
        dummy_field: bool,
    }

    public fun collect(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: vector<0x2::transfer::Receiving<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::collect<Policy>(arg0, arg1, v0, arg2)
    }

    public fun get_invocation(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::Invocation {
        let v0 = Policy{dummy_field: false};
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_request_payment_id(&arg1));
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation::new_invocation<Policy>(arg0, arg1, v0, v1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::invocation_request_price_snapshot(&arg1), arg2)
    }

    public(friend) fun install(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>) {
        let v0 = Policy{dummy_field: false};
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::add_policy<Policy>(arg0, arg1, v0);
    }

    // decompiled from Move bytecode v7
}

