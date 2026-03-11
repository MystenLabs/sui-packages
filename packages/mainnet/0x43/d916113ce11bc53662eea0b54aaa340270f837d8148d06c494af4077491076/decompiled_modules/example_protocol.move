module 0x43d916113ce11bc53662eea0b54aaa340270f837d8148d06c494af4077491076::example_protocol {
    struct ProtocolAction has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_value: u64,
    }

    struct ProtocolActionExecuted has copy, drop {
        action_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_value: u64,
    }

    public fun agent_id(arg0: &ProtocolAction) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun deposit_value(arg0: &ProtocolAction) : u64 {
        arg0.deposit_value
    }

    public fun execute_delegated_action<T0>(arg0: 0x43d916113ce11bc53662eea0b54aaa340270f837d8148d06c494af4077491076::delegation::DelegationReceipt, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ProtocolAction {
        let (v0, v1, v2) = 0x43d916113ce11bc53662eea0b54aaa340270f837d8148d06c494af4077491076::delegation::consume_receipt(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        let v3 = 0x2::object::new(arg3);
        let v4 = ProtocolActionExecuted{
            action_id     : 0x2::object::uid_to_inner(&v3),
            policy_id     : v0,
            agent_id      : v1,
            deposit_value : v2,
        };
        0x2::event::emit<ProtocolActionExecuted>(v4);
        ProtocolAction{
            id            : v3,
            policy_id     : v0,
            agent_id      : v1,
            deposit_value : v2,
        }
    }

    public fun execute_escalated_action<T0>(arg0: 0x43d916113ce11bc53662eea0b54aaa340270f837d8148d06c494af4077491076::escalation::EscalationReceipt, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ProtocolAction {
        let (_, v1, v2, v3) = 0x43d916113ce11bc53662eea0b54aaa340270f837d8148d06c494af4077491076::escalation::consume_escalation_receipt(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        let v4 = 0x2::object::new(arg3);
        let v5 = ProtocolActionExecuted{
            action_id     : 0x2::object::uid_to_inner(&v4),
            policy_id     : v1,
            agent_id      : v2,
            deposit_value : v3,
        };
        0x2::event::emit<ProtocolActionExecuted>(v5);
        ProtocolAction{
            id            : v4,
            policy_id     : v1,
            agent_id      : v2,
            deposit_value : v3,
        }
    }

    public fun policy_id(arg0: &ProtocolAction) : 0x2::object::ID {
        arg0.policy_id
    }

    // decompiled from Move bytecode v6
}

