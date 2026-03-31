module 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::strategy {
    struct YieldReceipt<phantom T0> {
        strategy_id: u8,
        asset_amount: u64,
    }

    struct ProtocolInfo has copy, drop, store {
        strategy_id: u8,
        name: 0x1::string::String,
        has_rewards: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        protocols: 0x2::vec_map::VecMap<u8, ProtocolInfo>,
        protocol_access_cap: 0x1::option::Option<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap>,
    }

    struct ProtocolRegisteredEvent has copy, drop {
        strategy_id: u8,
        name: 0x1::string::String,
    }

    public fun borrow_for_reroute<T0>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>) : (0x2::balance::Balance<T0>, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::BorrowReceipt<T0>) {
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::borrow_all_for_strategy<T0>(arg1, borrow_protocol_access_cap(arg0))
    }

    public(friend) fun borrow_protocol_access_cap(arg0: &StrategyRegistry) : &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap {
        0x1::option::borrow<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap>(&arg0.protocol_access_cap)
    }

    public fun count_available(arg0: &StrategyRegistry) : u64 {
        0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyRegistry{
            id                  : 0x2::object::new(arg0),
            protocols           : 0x2::vec_map::empty<u8, ProtocolInfo>(),
            protocol_access_cap : 0x1::option::none<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap>(),
        };
        0x2::transfer::share_object<StrategyRegistry>(v0);
    }

    public fun create_verified_yield_receipt<T0>(arg0: &0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::EnclaveRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) : YieldReceipt<T0> {
        let v0 = 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::verify_and_decode_yield_receipt(arg0, arg1, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) - 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_yield_timestamp_ms(&v0) <= 60000, 406);
        YieldReceipt<T0>{
            strategy_id  : 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_yield_strategy_id(&v0),
            asset_amount : 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_yield_asset_amount(&v0),
        }
    }

    public fun create_yield_receipt<T0>(arg0: u8, arg1: u64) : YieldReceipt<T0> {
        YieldReceipt<T0>{
            strategy_id  : arg0,
            asset_amount : arg1,
        }
    }

    public fun decode_strategy(arg0: u8) : (u8, u8) {
        (arg0 >> 4, arg0 & 15)
    }

    public fun encode_strategy(arg0: u8, arg1: u8) : u8 {
        arg0 << 4 | arg1
    }

    public fun finish_reroute_usdc<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::BorrowReceipt<T0>, arg3: 0x2::balance::Balance<T1>, arg4: YieldReceipt<T1>) {
        let YieldReceipt {
            strategy_id  : v0,
            asset_amount : v1,
        } = arg4;
        let (_, v3) = decode_strategy(v0);
        assert!(v3 == 1, 405);
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::commit_strategy<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, v0, v1);
    }

    public fun finish_reroute_usdsui<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::BorrowReceipt<T0>, arg3: 0x2::balance::Balance<T1>, arg4: YieldReceipt<T1>) {
        let YieldReceipt {
            strategy_id  : v0,
            asset_amount : v1,
        } = arg4;
        let (_, v3) = decode_strategy(v0);
        assert!(v3 == 2, 405);
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::commit_strategy<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, v0, v1);
    }

    public fun finish_withdraw<T0>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>) {
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::repay_withdraw<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3);
    }

    public fun get_protocol_info(arg0: &StrategyRegistry, arg1: u8) : ProtocolInfo {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        *0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun has_rewards(arg0: &StrategyRegistry, arg1: u8) : bool {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1).has_rewards
    }

    public fun is_available(arg0: &StrategyRegistry, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun issue_yield_promise_for_spoke<T0, T1>(arg0: &StrategyRegistry, arg1: &0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: u64) : 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0> {
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::issue_yield_promise<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2)
    }

    public fun list_available(arg0: &StrategyRegistry) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolInfo>(&arg0.protocols, v1);
            0x1::vector::push_back<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun name(arg0: &ProtocolInfo) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun register_protocol(arg0: &mut StrategyRegistry, arg1: u8, arg2: 0x1::string::String, arg3: bool) {
        assert!(arg1 != 0, 402);
        assert!(!0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 400);
        let v0 = ProtocolInfo{
            strategy_id : arg1,
            name        : arg2,
            has_rewards : arg3,
        };
        0x2::vec_map::insert<u8, ProtocolInfo>(&mut arg0.protocols, arg1, v0);
        let v1 = ProtocolRegisteredEvent{
            strategy_id : arg1,
            name        : arg2,
        };
        0x2::event::emit<ProtocolRegisteredEvent>(v1);
    }

    public fun repay_promise_usdc<T0>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::promise_type<T0>(&arg2) == 0x1::type_name::with_defining_ids<T0>(), 999);
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::commit_unwind<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::promise_expected<T0>(&arg2));
    }

    public fun repay_promise_usdsui<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::EnclaveRegistry, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        assert!(0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::promise_type<T0>(&arg2) == 0x1::type_name::with_defining_ids<T1>(), 999);
        let v0 = 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::verify_and_decode_yield_receipt(arg4, arg5, arg6);
        assert!(0x2::clock::timestamp_ms(arg7) - 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_yield_timestamp_ms(&v0) <= 60000, 406);
        0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::commit_unwind<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_yield_asset_amount(&v0));
    }

    public(friend) fun set_protocol_access_cap(arg0: &mut StrategyRegistry, arg1: 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap) {
        0x1::option::fill<0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::ProtocolAccessCap>(&mut arg0.protocol_access_cap, arg1);
    }

    public fun stable_usdc() : u8 {
        1
    }

    public fun stable_usdsui() : u8 {
        2
    }

    public(friend) fun update_has_rewards(arg0: &mut StrategyRegistry, arg1: u8, arg2: bool) {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        0x2::vec_map::get_mut<u8, ProtocolInfo>(&mut arg0.protocols, &arg1).has_rewards = arg2;
    }

    public fun withdraw_yield_for_spoke<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>) : (0x2::balance::Balance<T1>, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0>) {
        let v0 = borrow_protocol_access_cap(arg0);
        (0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::take_yield_balance<T0, T1>(arg1, v0), 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::issue_yield_promise<T0, T1>(arg1, v0, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::last_deployed_amount<T0>(arg1)))
    }

    public fun withdraw_yield_for_spoke_verified<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::Vault<T0>, arg2: &0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::EnclaveRegistry, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::YieldPromise<T0>) {
        let v0 = 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::verify_and_decode_withdraw(arg2, arg3, arg4);
        assert!(0x2::clock::timestamp_ms(arg6) - 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_withdraw_timestamp_ms(&v0) <= 60000, 101);
        let v1 = 0x5d87bdef26839bcb866b1e706f6e82932d37be60de9721e0c0d8f6fb585b42a6::enclave_verifier::get_withdraw_expected_usdc(&v0);
        let v2 = borrow_protocol_access_cap(arg0);
        (0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::take_yield_balance<T0, T1>(arg1, v2), 0x7d504e549a9919f26870fbbc55884796becae439e5673fabc262f9bad9694d36::vault::issue_yield_promise<T0, T1>(arg1, v2, v1 - v1 * arg5 / 10000))
    }

    // decompiled from Move bytecode v6
}

