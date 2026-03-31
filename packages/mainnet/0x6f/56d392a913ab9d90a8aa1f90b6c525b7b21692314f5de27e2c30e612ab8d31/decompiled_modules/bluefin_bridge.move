module 0x6f56d392a913ab9d90a8aa1f90b6c525b7b21692314f5de27e2c30e612ab8d31::bluefin_bridge {
    struct BridgeState<T0: store> has key {
        id: 0x2::object::UID,
        position_cap: 0x1::option::Option<T0>,
    }

    struct DepositReceipt<phantom T0> {
        dummy_field: bool,
    }

    struct WithdrawReceipt<phantom T0> {
        dummy_field: bool,
    }

    public fun begin_harvest<T0, T1, T2: store>(arg0: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg1: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::harvest::HarvestConfig, arg2: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::StrategyRegistry, arg3: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::EnclaveRegistry, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) : 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::harvest::HarvestPromise<T0> {
        let v0 = 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::verify_and_decode_withdraw(arg3, arg4, arg5);
        assert!(0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_strategy_id(&v0) >> 4 == 5, 100);
        assert!(0x2::clock::timestamp_ms(arg7) - 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_timestamp_ms(&v0) <= 60000, 101);
        let v1 = 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_expected_harvest_usdc(&v0);
        0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::harvest::issue_harvest_promise_for_spoke<T0, T1>(arg0, arg1, arg2, 5, v1 - v1 * arg6 / 10000, arg7)
    }

    public fun create_bridge_state<T0: store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState<T0>{
            id           : 0x2::object::new(arg0),
            position_cap : 0x1::option::none<T0>(),
        };
        0x2::transfer::share_object<BridgeState<T0>>(v0);
    }

    public fun extract_for_deposit<T0: store>(arg0: &mut BridgeState<T0>) : (T0, DepositReceipt<T0>) {
        let v0 = DepositReceipt<T0>{dummy_field: false};
        (0x1::option::extract<T0>(&mut arg0.position_cap), v0)
    }

    public fun extract_for_withdraw<T0, T1, T2: store>(arg0: &mut BridgeState<T2>, arg1: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::StrategyRegistry, arg2: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg3: &0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::EnclaveRegistry, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) : (T2, WithdrawReceipt<T2>, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0>) {
        let v0 = 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::verify_and_decode_withdraw(arg3, arg4, arg5);
        assert!(0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_strategy_id(&v0) >> 4 == 5, 100);
        assert!(0x2::clock::timestamp_ms(arg7) - 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_timestamp_ms(&v0) <= 60000, 101);
        let v1 = 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::enclave_verifier::get_withdraw_expected_usdc(&v0);
        let v2 = WithdrawReceipt<T2>{dummy_field: false};
        (0x1::option::extract<T2>(&mut arg0.position_cap), v2, 0x68dd9b9b6d99faa3f016825122a4bc81d51bbdef59b74795a013645511fa110c::strategy::issue_yield_promise_for_spoke<T0, T1>(arg1, arg2, v1 - v1 * arg6 / 10000))
    }

    public fun fill_position<T0: store>(arg0: &mut BridgeState<T0>, arg1: T0) {
        assert!(0x1::option::is_none<T0>(&arg0.position_cap), 400);
        0x1::option::fill<T0>(&mut arg0.position_cap, arg1);
    }

    public fun return_from_deposit<T0: store>(arg0: &mut BridgeState<T0>, arg1: T0, arg2: DepositReceipt<T0>) {
        let DepositReceipt {  } = arg2;
        0x1::option::fill<T0>(&mut arg0.position_cap, arg1);
    }

    public fun return_from_withdraw<T0: store>(arg0: &mut BridgeState<T0>, arg1: T0, arg2: WithdrawReceipt<T0>) {
        let WithdrawReceipt {  } = arg2;
        0x1::option::fill<T0>(&mut arg0.position_cap, arg1);
    }

    // decompiled from Move bytecode v6
}

