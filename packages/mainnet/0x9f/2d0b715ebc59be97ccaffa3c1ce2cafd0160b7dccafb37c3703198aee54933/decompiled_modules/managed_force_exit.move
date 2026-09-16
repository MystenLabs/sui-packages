module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_force_exit {
    public(friend) fun attest_adapter_return<T0: drop, T1>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg2: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::ConsentedForceExitTicket<T1>, arg3: &T0, arg4: 0x1::option::Option<0x2::coin::Coin<T1>>) : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::ForceExitAdapterReceipt<T0, T1> {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::attest_force_exit_adapter_return<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun fund_consented_force_exit<T0, T1>(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg1: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout::FrozenExitPot<T1>, arg2: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg3: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::ForceExitAdapterReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout::reserve_and_fund_consented_force_exit_pot<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun prepare_consented_force_exit<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::LeaderPolicy, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::ExitModeLatch, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::OpportunityAccounting, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::Position, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::ConsentedForceExitTicket<T0>, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout::FrozenExitPot<T0>) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout::prepare_consented_force_exit_pot<T0>(arg4, arg6, arg7);
        let (v1, v2) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_closeout::force_exit_pot_binding<T0>(&v0);
        (0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::managed_position::authorize_consented_force_exit<T0>(arg4, arg5, 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy::authorize_entered_exit_mode(arg0, arg1, arg2, arg3), v1, v2, 0x2::clock::timestamp_ms(arg6)), v0)
    }

    // decompiled from Move bytecode v7
}

