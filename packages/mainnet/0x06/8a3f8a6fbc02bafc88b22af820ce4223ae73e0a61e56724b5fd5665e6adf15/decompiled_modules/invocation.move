module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::invocation {
    struct ReserveKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct Invocation has key {
        id: 0x2::object::UID,
        execution_id: address,
        vertex_key: vector<u8>,
        tool_id: 0x2::object::ID,
        cashier_id: 0x2::object::ID,
        beneficiary: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind,
        policy: 0x1::type_name::TypeName,
        sources: vector<0x2::object::ID>,
        amount: u64,
        refund_to: 0x1::option::Option<address>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    fun destroy_empty(arg0: Invocation) {
        let Invocation {
            id           : v0,
            execution_id : _,
            vertex_key   : _,
            tool_id      : _,
            cashier_id   : _,
            beneficiary  : _,
            policy       : _,
            sources      : _,
            amount       : _,
            refund_to    : v9,
            funds        : v10,
        } = arg0;
        0x1::option::destroy_none<address>(v9);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        0x2::object::delete(v0);
    }

    public fun id(arg0: &Invocation) : 0x2::object::ID {
        0x2::object::id<Invocation>(arg0)
    }

    public fun receive(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<Invocation>) : Invocation {
        let v0 = 0x2::transfer::receive<Invocation>(arg0, arg1);
        let v1 = 0x2::object::uid_to_inner(arg0);
        assert!(v0.execution_id == 0x2::object::id_to_address(&v1), 13906834968912330753);
        v0
    }

    public fun amount(arg0: &Invocation) : u64 {
        arg0.amount
    }

    public fun beneficiary(arg0: &Invocation) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::PaymentSourceKind {
        arg0.beneficiary
    }

    public fun cashier(arg0: &Invocation) : 0x2::object::ID {
        arg0.cashier_id
    }

    public fun claim_refund<T0: drop, T1: store>(arg0: Invocation, arg1: T0) : T1 {
        let v0 = if (arg0.policy == 0x1::type_name::with_defining_ids<T0>()) {
            if (0x1::option::is_some<address>(&arg0.refund_to)) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906835492898340865);
        let v1 = ReserveKey<T0>{dummy_field: false};
        let Invocation {
            id           : v2,
            execution_id : _,
            vertex_key   : _,
            tool_id      : _,
            cashier_id   : _,
            beneficiary  : _,
            policy       : _,
            sources      : _,
            amount       : _,
            refund_to    : v11,
            funds        : v12,
        } = arg0;
        0x1::option::destroy_some<address>(v11);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        0x2::object::delete(v2);
        0x2::dynamic_field::remove<ReserveKey<T0>, T1>(&mut arg0.id, v1)
    }

    public fun collect<T0: drop>(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: T0, arg3: vector<0x2::transfer::Receiving<Invocation>>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg1);
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::transfer::Receiving<Invocation>>(&arg3)) {
            let Invocation {
                id           : v2,
                execution_id : _,
                vertex_key   : _,
                tool_id      : _,
                cashier_id   : _,
                beneficiary  : _,
                policy       : _,
                sources      : _,
                amount       : _,
                refund_to    : v11,
                funds        : v12,
            } = receive_completed<T0>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<Invocation>>(&mut arg3));
            0x1::option::destroy_none<address>(v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v12);
            0x2::object::delete(v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<Invocation>>(arg3);
        v0
    }

    public fun collect_with_reserve<T0: drop, T1: store>(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::OverToolCashier>, arg2: T0, arg3: vector<0x2::transfer::Receiving<Invocation>>) : (0x2::balance::Balance<0x2::sui::SUI>, vector<T1>) {
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::assert_owner(arg0, arg1);
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x1::vector::empty<T1>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::transfer::Receiving<Invocation>>(&arg3)) {
            let v3 = receive_completed<T0>(arg0, 0x1::vector::pop_back<0x2::transfer::Receiving<Invocation>>(&mut arg3));
            assert!(0x1::option::is_some<address>(&v3.refund_to), 13906835351164420097);
            let v4 = ReserveKey<T0>{dummy_field: false};
            let Invocation {
                id           : v5,
                execution_id : _,
                vertex_key   : _,
                tool_id      : _,
                cashier_id   : _,
                beneficiary  : _,
                policy       : _,
                sources      : _,
                amount       : _,
                refund_to    : v14,
                funds        : v15,
            } = v3;
            0x1::option::destroy_some<address>(v14);
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v15);
            0x1::vector::push_back<T1>(&mut v1, 0x2::dynamic_field::remove<ReserveKey<T0>, T1>(&mut v3.id, v4));
            0x2::object::delete(v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<Invocation>>(arg3);
        (v0, v1)
    }

    public fun execution_id(arg0: &Invocation) : address {
        arg0.execution_id
    }

    public fun new_invocation<T0: drop>(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest, arg2: T0, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Invocation {
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::has_policy<T0>(arg0), 13906834423451877383);
        let (v0, v1, v2, v3, v4, _, v6, v7, _) = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::into_invocation_request(arg1);
        let v9 = if (v2 == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0)) {
            if (v3 == 0x1::ascii::into_bytes(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool_fqn(arg0))) {
                v4 == 0x2::object::id<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier>(arg0)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 13906834492171091971);
        assert!(arg4 <= v7, 13906834500761157637);
        Invocation{
            id           : 0x2::object::new(arg5),
            execution_id : v0,
            vertex_key   : v1,
            tool_id      : v2,
            cashier_id   : v4,
            beneficiary  : v6,
            policy       : 0x1::type_name::with_defining_ids<T0>(),
            sources      : arg3,
            amount       : arg4,
            refund_to    : 0x1::option::none<address>(),
            funds        : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun new_invocation_with_reserve<T0: drop, T1: store>(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationRequest, arg2: T0, arg3: T1, arg4: address, arg5: vector<0x2::object::ID>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Invocation {
        let v0 = new_invocation<T0>(arg0, arg1, arg2, arg5, arg6, arg7);
        v0.refund_to = 0x1::option::some<address>(arg4);
        let v1 = ReserveKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ReserveKey<T0>, T1>(&mut v0.id, v1, arg3);
        v0
    }

    public fun place(arg0: Invocation, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationLockReceipt) {
        let (v0, v1, v2) = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::into_invocation_lock_receipt(arg1);
        let v3 = if (arg0.vertex_key == v0) {
            if (0x2::object::id<Invocation>(&arg0) == v1) {
                arg0.amount == v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13906834930257625089);
        0x2::transfer::transfer<Invocation>(arg0, arg0.execution_id);
    }

    public fun policy(arg0: &Invocation) : 0x1::type_name::TypeName {
        arg0.policy
    }

    fun receive_completed<T0: drop>(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier, arg1: 0x2::transfer::Receiving<Invocation>) : Invocation {
        let v0 = 0x2::transfer::receive<Invocation>(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::uid_mut(arg0), arg1);
        let v1 = if (v0.tool_id == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::tool(arg0)) {
            if (v0.cashier_id == 0x2::object::id<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_cashier::ToolCashier>(arg0)) {
                if (v0.policy == 0x1::type_name::with_defining_ids<T0>()) {
                    0x2::balance::value<0x2::sui::SUI>(&v0.funds) == v0.amount
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906835711941672961);
        v0
    }

    public fun receive_refund(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<Invocation>) : Invocation {
        let v0 = 0x2::transfer::receive<Invocation>(arg0, arg1);
        let v1 = if (0x1::option::is_some<address>(&v0.refund_to)) {
            let v2 = 0x2::object::uid_to_inner(arg0);
            *0x1::option::borrow<address>(&v0.refund_to) == 0x2::object::id_to_address(&v2)
        } else {
            false
        };
        assert!(v1, 13906835011862003713);
        v0
    }

    public fun refund_address(arg0: &Invocation) : address {
        assert!(0x1::option::is_some<address>(&arg0.refund_to), 13906834809998540801);
        *0x1::option::borrow<address>(&arg0.refund_to)
    }

    public fun resolve(arg0: Invocation, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::InvocationSettlementReceipt) {
        let (v0, v1) = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::payment::into_invocation_settlement_receipt(arg2);
        assert!(0x2::object::id<Invocation>(&arg0) == v0, 13906835089171415041);
        if (v1) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) == 0, 13906835102056316929);
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            if (0x1::option::is_some<address>(&arg0.refund_to)) {
                0x2::transfer::transfer<Invocation>(arg0, *0x1::option::borrow<address>(&arg0.refund_to));
            } else {
                destroy_empty(arg0);
            };
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) == arg0.amount, 13906835140711022593);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, arg1);
            let v2 = arg0.cashier_id;
            0x2::transfer::transfer<Invocation>(arg0, 0x2::object::id_to_address(&v2));
        };
    }

    public fun sources(arg0: &Invocation) : vector<0x2::object::ID> {
        arg0.sources
    }

    public fun tool(arg0: &Invocation) : 0x2::object::ID {
        arg0.tool_id
    }

    public fun vertex_key(arg0: &Invocation) : vector<u8> {
        arg0.vertex_key
    }

    // decompiled from Move bytecode v7
}

