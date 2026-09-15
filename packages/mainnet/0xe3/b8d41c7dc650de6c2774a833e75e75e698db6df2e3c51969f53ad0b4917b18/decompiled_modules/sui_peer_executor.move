module 0x59bb8e6152a2fafdabbd0f477c0bb387d10f6ea69a9b8d1386f817663baa20e6::sui_peer_executor {
    struct OriginRecord has copy, drop, store {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
    }

    struct PeerCustodyDeposited has copy, drop {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        principal_micros: u64,
    }

    struct DestEngineSuilendExecuted has copy, drop {
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
        account: address,
        amount_micros: u64,
        extra: vector<u8>,
    }

    struct PeerCustodyExitBound has copy, drop {
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        position_owner: address,
        payout_destination: address,
    }

    struct HubInstructionLedger has key {
        id: 0x2::object::UID,
        instructions: 0x2::table::Table<vector<u8>, HubInstruction>,
    }

    struct HubInstruction has store {
        kind: u8,
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        amount_micros: u64,
        expires_at_ms: u64,
        status: u8,
        recorded_at_ms: u64,
        filled_at_ms: 0x1::option::Option<u64>,
    }

    struct HubDepositRecorded has copy, drop {
        instruction_id: vector<u8>,
        origin_owner: address,
        amount_micros: u64,
        expires_at_ms: u64,
    }

    struct HubWithdrawRequestRecorded has copy, drop {
        instruction_id: vector<u8>,
        origin_owner: address,
        amount_micros: u64,
        expires_at_ms: u64,
    }

    struct HubDepositFilled has copy, drop {
        instruction_id: vector<u8>,
        origin_owner: address,
        amount_micros: u64,
        filled_at_ms: u64,
    }

    struct HubWithdrawFilled has copy, drop {
        instruction_id: vector<u8>,
        origin_owner: address,
        filled_at_ms: u64,
    }

    struct HubInstructionExpired has copy, drop {
        instruction_id: vector<u8>,
        recorded_at_ms: u64,
        outcome: u8,
    }

    fun assert_origin_binding(arg0: &0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::Position, arg1: &OriginRecord) {
        assert!(0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::owner(arg0) == arg1.origin_owner, 5);
        assert!(0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::payout_destination(arg0) == arg1.origin_owner, 6);
    }

    public fun confirm_hub_withdraw_filled(arg0: &mut HubInstructionLedger, arg1: vector<u8>, arg2: &0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::Position, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, HubInstruction>(&arg0.instructions, arg1), 7);
        let v0 = 0x2::table::borrow<vector<u8>, HubInstruction>(&arg0.instructions, arg1);
        assert!(v0.kind == 2, 14);
        assert!(v0.status == 0, 9);
        let v1 = new_origin_record(v0.origin_chain, v0.origin_owner, v0.origin_asset);
        assert_origin_binding(arg2, &v1);
        assert!(0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::closed(arg2), 13);
        let v2 = v0.origin_owner;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::table::borrow_mut<vector<u8>, HubInstruction>(&mut arg0.instructions, arg1);
        v4.status = 1;
        v4.filled_at_ms = 0x1::option::some<u64>(v3);
        let v5 = HubWithdrawFilled{
            instruction_id : arg1,
            origin_owner   : v2,
            filled_at_ms   : v3,
        };
        0x2::event::emit<HubWithdrawFilled>(v5);
    }

    public fun create_hub_instruction_ledger(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HubInstructionLedger{
            id           : 0x2::object::new(arg0),
            instructions : 0x2::table::new<vector<u8>, HubInstruction>(arg0),
        };
        0x2::transfer::share_object<HubInstructionLedger>(v0);
    }

    public fun execute_vault_request_suilend(arg0: 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::AuthenticatedVaultRequest, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::consume_vault_request_proof(arg0);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) == v4, 12);
        receive_and_deposit_suilend(arg2, arg3, arg4, arg5, arg1, new_origin_record(origin_chain_for_eid(v0), v3, b"usdc"), arg6, arg7);
        let v6 = DestEngineSuilendExecuted{
            src_eid         : v0,
            layerzero_nonce : v1,
            guid            : v2,
            account         : v3,
            amount_micros   : v4,
            extra           : v5,
        };
        0x2::event::emit<DestEngineSuilendExecuted>(v6);
    }

    public fun exit_to_origin(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg1: &mut 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::Position, arg2: OriginRecord, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.origin_owner != @0x0, 1);
        assert_origin_binding(arg1, &arg2);
        let v0 = PeerCustodyExitBound{
            origin_chain       : arg2.origin_chain,
            origin_owner       : arg2.origin_owner,
            origin_asset       : arg2.origin_asset,
            position_owner     : 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::owner(arg1),
            payout_destination : 0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::payout_destination(arg1),
        };
        0x2::event::emit<PeerCustodyExitBound>(v0);
        0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::withdraw_all_usdc(arg0, arg1, arg3, arg4);
    }

    public fun expire_hub_instruction(arg0: &mut HubInstructionLedger, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, HubInstruction>(&arg0.instructions, arg1), 7);
        let v0 = 0x2::table::borrow<vector<u8>, HubInstruction>(&arg0.instructions, arg1);
        assert!(v0.status == 0, 9);
        assert!(0x2::clock::timestamp_ms(arg2) > v0.expires_at_ms, 11);
        0x2::table::borrow_mut<vector<u8>, HubInstruction>(&mut arg0.instructions, arg1).status = 2;
        let v1 = HubInstructionExpired{
            instruction_id : arg1,
            recorded_at_ms : v0.recorded_at_ms,
            outcome        : 2,
        };
        0x2::event::emit<HubInstructionExpired>(v1);
    }

    public fun fill_hub_deposit(arg0: &mut HubInstructionLedger, arg1: vector<u8>, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, HubInstruction>(&arg0.instructions, arg1), 7);
        let v0 = 0x2::table::borrow<vector<u8>, HubInstruction>(&arg0.instructions, arg1);
        assert!(v0.kind == 1, 14);
        assert!(v0.status == 0, 9);
        assert!(0x2::clock::timestamp_ms(arg7) <= v0.expires_at_ms, 10);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == v0.amount_micros, 12);
        let v1 = v0.amount_micros;
        receive_and_deposit_suilend(arg3, arg4, arg5, arg6, arg2, new_origin_record(v0.origin_chain, v0.origin_owner, v0.origin_asset), arg7, arg8);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x2::table::borrow_mut<vector<u8>, HubInstruction>(&mut arg0.instructions, arg1);
        v3.status = 1;
        v3.filled_at_ms = 0x1::option::some<u64>(v2);
        let v4 = HubDepositFilled{
            instruction_id : arg1,
            origin_owner   : v0.origin_owner,
            amount_micros  : v1,
            filled_at_ms   : v2,
        };
        0x2::event::emit<HubDepositFilled>(v4);
    }

    public fun hub_instruction_exists(arg0: &HubInstructionLedger, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, HubInstruction>(&arg0.instructions, arg1)
    }

    public fun hub_instruction_kind(arg0: &HubInstructionLedger, arg1: vector<u8>) : u8 {
        0x2::table::borrow<vector<u8>, HubInstruction>(&arg0.instructions, arg1).kind
    }

    public fun hub_instruction_status(arg0: &HubInstructionLedger, arg1: vector<u8>) : u8 {
        0x2::table::borrow<vector<u8>, HubInstruction>(&arg0.instructions, arg1).status
    }

    public fun hub_kind_deposit() : u8 {
        1
    }

    public fun hub_kind_withdraw_request() : u8 {
        2
    }

    public fun hub_status_failed() : u8 {
        2
    }

    public fun hub_status_filled() : u8 {
        1
    }

    public fun hub_status_pending() : u8 {
        0
    }

    public fun new_origin_record(arg0: vector<u8>, arg1: address, arg2: vector<u8>) : OriginRecord {
        assert!(arg1 != @0x0, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 3);
        OriginRecord{
            origin_chain : arg0,
            origin_owner : arg1,
            origin_asset : arg2,
        }
    }

    public fun origin_asset(arg0: &OriginRecord) : vector<u8> {
        arg0.origin_asset
    }

    public fun origin_chain(arg0: &OriginRecord) : vector<u8> {
        arg0.origin_chain
    }

    fun origin_chain_for_eid(arg0: u32) : vector<u8> {
        if (arg0 == 30101) {
            b"ethereum"
        } else if (arg0 == 30184) {
            b"base"
        } else {
            b"evm"
        }
    }

    public fun origin_owner(arg0: &OriginRecord) : address {
        arg0.origin_owner
    }

    public fun receive_and_deposit_suilend(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: OriginRecord, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.origin_owner != @0x0, 1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        assert!(v0 > 0, 4);
        let v1 = PeerCustodyDeposited{
            origin_chain     : arg5.origin_chain,
            origin_owner     : arg5.origin_owner,
            origin_asset     : arg5.origin_asset,
            principal_micros : v0,
        };
        0x2::event::emit<PeerCustodyDeposited>(v1);
        0xe674c1aecbe0c444827b1df7688439803e377eecaf34fcc409c32f9ef8c94a66::suilend_usdc_forwarder::deposit_usdc_for_owner(arg0, arg1, arg2, arg3, arg4, arg5.origin_owner, arg6, arg7);
    }

    public fun record_hub_deposit(arg0: 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::AuthenticatedHubDeposit, arg1: &mut HubInstructionLedger, arg2: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4, v5) = 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::consume_deposit_proof(arg0);
        record_hub_instruction(arg1, 1, v0, v1, v2, v3, v4, v5, arg2);
        let v6 = HubDepositRecorded{
            instruction_id : v0,
            origin_owner   : v2,
            amount_micros  : v4,
            expires_at_ms  : v5,
        };
        0x2::event::emit<HubDepositRecorded>(v6);
    }

    fun record_hub_instruction(arg0: &mut HubInstructionLedger, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 15);
        assert!(!0x2::table::contains<vector<u8>, HubInstruction>(&arg0.instructions, arg2), 8);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 <= arg7, 10);
        let v1 = HubInstruction{
            kind           : arg1,
            origin_chain   : arg3,
            origin_owner   : arg4,
            origin_asset   : arg5,
            amount_micros  : arg6,
            expires_at_ms  : arg7,
            status         : 0,
            recorded_at_ms : v0,
            filled_at_ms   : 0x1::option::none<u64>(),
        };
        0x2::table::add<vector<u8>, HubInstruction>(&mut arg0.instructions, arg2, v1);
    }

    public fun record_hub_withdraw_request(arg0: 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::AuthenticatedHubWithdrawRequest, arg1: &mut HubInstructionLedger, arg2: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4, v5) = 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp::consume_withdraw_proof(arg0);
        record_hub_instruction(arg1, 2, v0, v1, v2, v3, v4, v5, arg2);
        let v6 = HubWithdrawRequestRecorded{
            instruction_id : v0,
            origin_owner   : v2,
            amount_micros  : v4,
            expires_at_ms  : v5,
        };
        0x2::event::emit<HubWithdrawRequestRecorded>(v6);
    }

    // decompiled from Move bytecode v7
}

