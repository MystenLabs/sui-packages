module 0x12d318b80db7d9073ef1dbb050d0faba39da921fe38ecfd5cceda389ccb508f7::alphafi_bridge {
    struct BridgeState<T0: store> has key {
        id: 0x2::object::UID,
        position_cap: 0x1::option::Option<T0>,
    }

    public fun begin_harvest<T0, T1, T2: store>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::harvest::HarvestConfig, arg2: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy::StrategyRegistry, arg3: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::EnclaveRegistry, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) : 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::harvest::HarvestPromise<T0> {
        let v0 = 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::verify_and_decode_withdraw(arg3, arg4, arg5);
        assert!(0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_strategy_id(&v0) == 4, 100);
        assert!(0x2::clock::timestamp_ms(arg7) - 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_timestamp_ms(&v0) <= 60000, 101);
        let v1 = 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_expected_harvest_usdc(&v0);
        0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::harvest::issue_harvest_promise_for_spoke<T0, T1>(arg0, arg1, arg2, 4, v1 - v1 * arg6 / 10000, arg7)
    }

    public fun begin_withdraw<T0, T1, T2: store>(arg0: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap, arg2: &0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::EnclaveRegistry, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock) : 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0> {
        let v0 = 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::verify_and_decode_withdraw(arg2, arg3, arg4);
        assert!(0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_strategy_id(&v0) == 4, 100);
        assert!(0x2::clock::timestamp_ms(arg6) - 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_timestamp_ms(&v0) <= 60000, 101);
        let v1 = 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::enclave_verifier::get_withdraw_expected_usdc(&v0);
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::issue_yield_promise<T0, T1>(arg0, arg1, v1 - v1 * arg5 / 10000)
    }

    public fun borrow_position<T0: store>(arg0: &mut BridgeState<T0>) : &mut T0 {
        0x1::option::borrow_mut<T0>(&mut arg0.position_cap)
    }

    public fun create_bridge_state<T0: store>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState<T0>{
            id           : 0x2::object::new(arg0),
            position_cap : 0x1::option::none<T0>(),
        };
        0x2::transfer::share_object<BridgeState<T0>>(v0);
    }

    public fun end_withdraw<T0, T1, T2: store>(arg0: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg1: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>) {
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::commit_unwind<T0>(arg0, arg1, arg2, arg3, 0);
    }

    public fun fill_position<T0: store>(arg0: &mut BridgeState<T0>, arg1: T0) {
        if (0x1::option::is_some<T0>(&arg0.position_cap)) {
            abort 400
        };
        0x1::option::fill<T0>(&mut arg0.position_cap, arg1);
    }

    // decompiled from Move bytecode v6
}

