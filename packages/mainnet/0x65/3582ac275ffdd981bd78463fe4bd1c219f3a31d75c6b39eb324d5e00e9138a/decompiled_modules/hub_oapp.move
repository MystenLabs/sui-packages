module 0x653582ac275ffdd981bd78463fe4bd1c219f3a31d75c6b39eb324d5e00e9138a::hub_oapp {
    struct HUB_OAPP has drop {
        dummy_field: bool,
    }

    struct GovernanceCap has key {
        id: 0x2::object::UID,
        hub_id: 0x2::object::ID,
    }

    struct RemoteSequence has drop, store {
        eid: u32,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        next_nonce: u64,
    }

    struct OutboundIntent has drop, store {
        dst_eid: u32,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        command_hash: vector<u8>,
        expires_at_ms: u64,
        outcome_recorded: bool,
        outcome_received: bool,
        outcome: u8,
    }

    struct PendingAuthorizedHubSend {
        authorized: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::AuthorizedHubCommand,
        call: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt>,
    }

    struct IntentPreimageV1 has drop {
        domain: vector<u8>,
        dst_eid: u32,
        command_hash: vector<u8>,
    }

    struct HubOApp has key {
        id: 0x2::object::UID,
        oapp_object: address,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        admin_cap: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap,
        expected_endpoint: address,
        endpoint_object: 0x1::option::Option<address>,
        messaging_channel: 0x1::option::Option<address>,
        governance_cap: 0x1::option::Option<0x2::object::ID>,
        outbound_intents: 0x2::table::Table<vector<u8>, OutboundIntent>,
        consumed_guids: 0x2::table::Table<vector<u8>, bool>,
        return_sequences: vector<RemoteSequence>,
        hub_peer: 0x1::option::Option<HubPeerBinding>,
        consumed_hub_guids: 0x2::table::Table<vector<u8>, bool>,
    }

    struct HubPeerBinding has drop, store {
        eid: u32,
        peer: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    struct ExecutionOutcomeRecorded has copy, drop {
        src_eid: u32,
        source_peer: vector<u8>,
        layerzero_nonce: u64,
        guid: vector<u8>,
        intent_id: vector<u8>,
        command_hash: vector<u8>,
        outcome: u8,
    }

    struct HubCommandCommitted has copy, drop {
        dst_eid: u32,
        peer: vector<u8>,
        intent_id: vector<u8>,
        command_hash: vector<u8>,
        expires_at_ms: u64,
    }

    struct HubIntentPruned has copy, drop {
        intent_id: vector<u8>,
    }

    struct HubIntentExpired has copy, drop {
        dst_eid: u32,
        peer: vector<u8>,
        intent_id: vector<u8>,
        command_hash: vector<u8>,
        expires_at_ms: u64,
        recorded_at_ms: u64,
        outcome: u8,
    }

    struct ExecutionOutcomeWire has drop {
        domain: vector<u8>,
        version: u8,
        action: u8,
        intent_id: vector<u8>,
        command_hash: vector<u8>,
        outcome: u8,
    }

    struct AuthenticatedHubDeposit {
        instruction_id: vector<u8>,
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        amount_micros: u64,
        expires_at_ms: u64,
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
    }

    struct AuthenticatedHubWithdrawRequest {
        instruction_id: vector<u8>,
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        amount_micros: u64,
        expires_at_ms: u64,
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
    }

    struct HubPeerRegistered has copy, drop {
        hub_eid: u32,
        hub_peer: vector<u8>,
    }

    struct HubDepositReceived has copy, drop {
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
        instruction_id: vector<u8>,
        origin_owner: address,
        amount_micros: u64,
        expires_at_ms: u64,
    }

    struct HubWithdrawRequestReceived has copy, drop {
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
        instruction_id: vector<u8>,
        origin_owner: address,
        amount_micros: u64,
        expires_at_ms: u64,
    }

    struct HubCommandWire has drop {
        domain: vector<u8>,
        version: u8,
        action: u8,
        instruction_id: vector<u8>,
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        amount_micros: u64,
        expires_at_ms: u64,
    }

    struct DecodedHubCommand has drop {
        action: u8,
        instruction_id: vector<u8>,
        origin_chain: vector<u8>,
        origin_owner: address,
        origin_asset: vector<u8>,
        amount_micros: u64,
        expires_at_ms: u64,
        src_eid: u32,
        layerzero_nonce: u64,
        guid: vector<u8>,
    }

    public fun register_oapp(arg0: &mut HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &GovernanceCap, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_governance(arg0, arg2);
        assert!(!is_registered(arg0), 1);
        assert_endpoint(arg0, arg3);
        assert_oapp(arg0, arg1);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 27);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(arg0.oapp_object, arg4, arg5, arg6);
        arg0.endpoint_object = 0x1::option::some<address>(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg3));
        arg0.messaging_channel = 0x1::option::some<address>(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::register_oapp(arg3, &arg0.call_cap, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0), arg7));
    }

    public fun messaging_channel(arg0: &HubOApp) : 0x1::option::Option<address> {
        arg0.messaging_channel
    }

    fun apply_authenticated_outcome(arg0: &mut HubOApp, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u64) {
        assert!(is_supported_remote(arg1), 11);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.consumed_guids, arg4), 15);
        let (v0, v1, v2) = decode_execution_outcome(arg5);
        assert!(0x2::table::contains<vector<u8>, OutboundIntent>(&arg0.outbound_intents, v0), 22);
        let v3 = 0x2::table::borrow<vector<u8>, OutboundIntent>(&arg0.outbound_intents, v0);
        assert!(v3.dst_eid == arg1, 13);
        assert!(v3.peer == arg2, 30);
        assert!(v3.command_hash == v1, 24);
        assert!(!v3.outcome_received, 23);
        if (v3.outcome_recorded) {
            assert!(v3.outcome == 2 && arg6 > v3.expires_at_ms, 23);
        };
        consume_return_nonce(arg0, arg1, arg2, arg3);
        let v4 = 0x2::table::borrow_mut<vector<u8>, OutboundIntent>(&mut arg0.outbound_intents, v0);
        v4.outcome_recorded = true;
        v4.outcome_received = true;
        v4.outcome = v2;
        0x2::table::add<vector<u8>, bool>(&mut arg0.consumed_guids, arg4, true);
        let v5 = ExecutionOutcomeRecorded{
            src_eid         : arg1,
            source_peer     : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&arg2),
            layerzero_nonce : arg3,
            guid            : arg4,
            intent_id       : v0,
            command_hash    : v1,
            outcome         : v2,
        };
        0x2::event::emit<ExecutionOutcomeRecorded>(v5);
    }

    fun assert_endpoint(arg0: &HubOApp, arg1: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2) {
        assert!(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>(arg1) == arg0.expected_endpoint, 3);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::eid(arg1) == 30378, 4);
    }

    fun assert_governance(arg0: &HubOApp, arg1: &GovernanceCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.governance_cap), 7);
        assert!(arg1.hub_id == 0x2::object::id<HubOApp>(arg0), 8);
        assert!(0x2::object::id<GovernanceCap>(arg1) == *0x1::option::borrow<0x2::object::ID>(&arg0.governance_cap), 8);
    }

    fun assert_hub_message(arg0: u32, arg1: &vector<u8>) : u64 {
        assert!(is_supported_remote(arg0), 11);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::assert_managed_reallocate_v1_message(arg0, arg1)
    }

    fun assert_oapp(arg0: &HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) {
        assert!(0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1) == arg0.oapp_object, 5);
        assert!(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::oapp_cap_id(arg1) == 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), 5);
        assert!(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::admin_cap(arg1) == 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(&arg0.admin_cap), 5);
    }

    fun assert_ready(arg0: &HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel) {
        assert!(is_registered(arg0), 2);
        assert_endpoint(arg0, arg2);
        assert_oapp(arg0, arg1);
        assert!(0x2::object::id_address<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel>(arg3) == *0x1::option::borrow<address>(&arg0.messaging_channel), 6);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::get_oapp(arg3) == 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), 6);
    }

    fun authenticate_hub_command(arg0: &mut HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: u64) : DecodedHubCommand {
        assert!(is_registered(arg0), 2);
        assert_oapp(arg0, arg1);
        assert!(0x1::option::is_some<HubPeerBinding>(&arg0.hub_peer), 31);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.call_cap, arg2);
        assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::value(&v0)), 18);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::src_eid(&v0);
        let v2 = 0x1::option::borrow<HubPeerBinding>(&arg0.hub_peer);
        assert!(v1 == v2.eid, 32);
        assert!(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::sender(&v0) == v2.peer, 32);
        let v3 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::guid(&v0);
        let v4 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v3);
        assert!(0x1::vector::length<u8>(&v4) == 32, 35);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.consumed_hub_guids, v4), 33);
        0x2::table::add<vector<u8>, bool>(&mut arg0.consumed_hub_guids, v4, true);
        let (v5, v6, v7, v8, v9, v10, v11) = decode_hub_command(*0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(&v0));
        assert!(arg3 <= v11, 34);
        let (_, _, _, _, _, _, _, v19) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(v0);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v19);
        DecodedHubCommand{
            action          : v5,
            instruction_id  : v6,
            origin_chain    : v7,
            origin_owner    : v8,
            origin_asset    : v9,
            amount_micros   : v10,
            expires_at_ms   : v11,
            src_eid         : v1,
            layerzero_nonce : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::nonce(&v0),
            guid            : v4,
        }
    }

    public fun bind_canonical_day_hub_transport(arg0: &HubOApp, arg1: &GovernanceCap, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg3: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::HubState, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg5: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::AdminCap, arg6: &0x2::tx_context::TxContext) {
        assert!(is_registered(arg0), 2);
        assert_governance(arg0, arg1);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::bind_layerzero_oapp_call_cap(arg2, arg3, arg4, arg5, &arg0.call_cap, arg6);
    }

    public fun bootstrap_governance(arg0: &mut HubOApp, arg1: &0x2::package::UpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.governance_cap), 8);
        let v0 = if (arg2 != @0x0) {
            if (arg2 != @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491) {
                arg2 != 0x2::tx_context::sender(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        let v1 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v1) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<HUB_OAPP>(), 10);
        let v2 = GovernanceCap{
            id     : 0x2::object::new(arg3),
            hub_id : 0x2::object::id<HubOApp>(arg0),
        };
        arg0.governance_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<GovernanceCap>(&v2));
        0x2::transfer::transfer<GovernanceCap>(v2, arg2);
    }

    public fun configure_enforced_options(arg0: &HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &GovernanceCap, arg3: u32, arg4: u16, arg5: vector<u8>) {
        assert_governance(arg0, arg2);
        assert_oapp(arg0, arg1);
        assert!(is_supported_remote(arg3), 11);
        assert!(arg4 == 1, 28);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 28);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_enforced_options(arg1, &arg0.admin_cap, arg3, arg4, arg5);
    }

    public fun configure_peer(arg0: &HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &GovernanceCap, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg5: u32, arg6: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg7: &mut 0x2::tx_context::TxContext) {
        assert_governance(arg0, arg2);
        assert_ready(arg0, arg1, arg3, arg4);
        assert!(is_supported_remote(arg5), 11);
        assert!(!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&arg6), 12);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg1, &arg0.admin_cap, arg3, arg4, arg5, arg6, arg7);
    }

    public fun confirm_authorized_hub_command(arg0: &HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: PendingAuthorizedHubSend) : (0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt) {
        assert_oapp(arg0, arg1);
        let PendingAuthorizedHubSend {
            authorized : v0,
            call       : v1,
        } = arg2;
        let v2 = v1;
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::consume_after_completed_layerzero_call(v0, &v2);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::confirm_lz_send(arg1, &arg0.call_cap, v2)
    }

    public fun consume_deposit_proof(arg0: AuthenticatedHubDeposit) : (vector<u8>, vector<u8>, address, vector<u8>, u64, u64) {
        let AuthenticatedHubDeposit {
            instruction_id  : v0,
            origin_chain    : v1,
            origin_owner    : v2,
            origin_asset    : v3,
            amount_micros   : v4,
            expires_at_ms   : v5,
            src_eid         : _,
            layerzero_nonce : _,
            guid            : _,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun consume_return_nonce(arg0: &mut HubOApp, arg1: u32, arg2: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RemoteSequence>(&arg0.return_sequences)) {
            let v1 = 0x1::vector::borrow_mut<RemoteSequence>(&mut arg0.return_sequences, v0);
            if (v1.eid == arg1 && v1.peer == arg2) {
                assert!(arg3 == v1.next_nonce, 16);
                v1.next_nonce = v1.next_nonce + 1;
                return
            };
            v0 = v0 + 1;
        };
        assert!(arg3 == 1, 16);
        let v2 = RemoteSequence{
            eid        : arg1,
            peer       : arg2,
            next_nonce : 2,
        };
        0x1::vector::push_back<RemoteSequence>(&mut arg0.return_sequences, v2);
    }

    public fun consume_withdraw_proof(arg0: AuthenticatedHubWithdrawRequest) : (vector<u8>, vector<u8>, address, vector<u8>, u64, u64) {
        let AuthenticatedHubWithdrawRequest {
            instruction_id  : v0,
            origin_chain    : v1,
            origin_owner    : v2,
            origin_asset    : v3,
            amount_micros   : v4,
            expires_at_ms   : v5,
            src_eid         : _,
            layerzero_nonce : _,
            guid            : _,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun decode_execution_outcome(arg0: vector<u8>) : (vector<u8>, vector<u8>, u8) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_vec_u8(&mut v0) == b"DAY_OUTCOME", 13);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 13);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 14);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v3 = 0x2::bcs::peel_u8(&mut v0);
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v4), 13);
        assert!(0x1::vector::length<u8>(&v1) == 32, 13);
        assert!(0x1::vector::length<u8>(&v2) == 32, 13);
        assert!(v3 == 1 || v3 == 2, 25);
        (v1, v2, v3)
    }

    fun decode_hub_command(arg0: vector<u8>) : (u8, vector<u8>, vector<u8>, address, vector<u8>, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_vec_u8(&mut v0) == b"DAY_HUB_CMD", 35);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 35);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 == 1 || v1 == 2, 36);
        let v2 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v3 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v4 = 0x2::bcs::peel_address(&mut v0);
        let v5 = 0x2::bcs::peel_vec_u8(&mut v0);
        let v6 = 0x2::bcs::peel_u64(&mut v0);
        let v7 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v7), 35);
        assert!(0x1::vector::length<u8>(&v2) == 32, 35);
        assert!(!0x1::vector::is_empty<u8>(&v3), 35);
        assert!(v4 != @0x0, 39);
        assert!(!0x1::vector::is_empty<u8>(&v5), 35);
        assert!(v6 > 0, 38);
        (v1, v2, v3, v4, v5, v6, 0x2::bcs::peel_u64(&mut v0))
    }

    public fun deposit_proof_amount_micros(arg0: &AuthenticatedHubDeposit) : u64 {
        arg0.amount_micros
    }

    public fun deposit_proof_expires_at_ms(arg0: &AuthenticatedHubDeposit) : u64 {
        arg0.expires_at_ms
    }

    public fun deposit_proof_instruction_id(arg0: &AuthenticatedHubDeposit) : vector<u8> {
        arg0.instruction_id
    }

    public fun deposit_proof_origin_owner(arg0: &AuthenticatedHubDeposit) : address {
        arg0.origin_owner
    }

    public fun deposit_proof_src_eid(arg0: &AuthenticatedHubDeposit) : u32 {
        arg0.src_eid
    }

    public fun encode_execution_outcome(arg0: vector<u8>, arg1: vector<u8>, arg2: u8) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13);
        assert!(arg2 == 1 || arg2 == 2, 25);
        let v0 = ExecutionOutcomeWire{
            domain       : b"DAY_OUTCOME",
            version      : 1,
            action       : 1,
            intent_id    : arg0,
            command_hash : arg1,
            outcome      : arg2,
        };
        0x2::bcs::to_bytes<ExecutionOutcomeWire>(&v0)
    }

    fun encode_hub_command(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 35);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 35);
        assert!(arg3 != @0x0, 39);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 35);
        assert!(arg5 > 0, 38);
        let v0 = HubCommandWire{
            domain         : b"DAY_HUB_CMD",
            version        : 1,
            action         : arg0,
            instruction_id : arg1,
            origin_chain   : arg2,
            origin_owner   : arg3,
            origin_asset   : arg4,
            amount_micros  : arg5,
            expires_at_ms  : arg6,
        };
        0x2::bcs::to_bytes<HubCommandWire>(&v0)
    }

    public fun encode_hub_deposit(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64) : vector<u8> {
        encode_hub_command(1, arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun encode_hub_withdraw_request(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64) : vector<u8> {
        encode_hub_command(2, arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun endpoint_object(arg0: &HubOApp) : 0x1::option::Option<address> {
        arg0.endpoint_object
    }

    public fun endpoint_v2_object() : address {
        @0xd45b6890fa030bcb43347c0c69a9e5a1a288d1ca7b86b428014752b472f6bf91
    }

    public fun governance_cap_id(arg0: &HubOApp) : 0x1::option::Option<0x2::object::ID> {
        arg0.governance_cap
    }

    public fun hub_action_deposit() : u8 {
        1
    }

    public fun hub_action_withdraw_request() : u8 {
        2
    }

    public fun hub_guid_consumed(arg0: &HubOApp, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.consumed_hub_guids, arg1)
    }

    public fun hub_peer_address(arg0: &HubOApp) : 0x1::option::Option<vector<u8>> {
        if (0x1::option::is_some<HubPeerBinding>(&arg0.hub_peer)) {
            0x1::option::some<vector<u8>>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&0x1::option::borrow<HubPeerBinding>(&arg0.hub_peer).peer))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun hub_peer_eid(arg0: &HubOApp) : 0x1::option::Option<u32> {
        if (0x1::option::is_some<HubPeerBinding>(&arg0.hub_peer)) {
            0x1::option::some<u32>(0x1::option::borrow<HubPeerBinding>(&arg0.hub_peer).eid)
        } else {
            0x1::option::none<u32>()
        }
    }

    fun init(arg0: HUB_OAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<HUB_OAPP>(&arg0, arg1);
        let v3 = HubOApp{
            id                 : 0x2::object::new(arg1),
            oapp_object        : v2,
            call_cap           : v0,
            admin_cap          : v1,
            expected_endpoint  : @0xd45b6890fa030bcb43347c0c69a9e5a1a288d1ca7b86b428014752b472f6bf91,
            endpoint_object    : 0x1::option::none<address>(),
            messaging_channel  : 0x1::option::none<address>(),
            governance_cap     : 0x1::option::none<0x2::object::ID>(),
            outbound_intents   : 0x2::table::new<vector<u8>, OutboundIntent>(arg1),
            consumed_guids     : 0x2::table::new<vector<u8>, bool>(arg1),
            return_sequences   : 0x1::vector::empty<RemoteSequence>(),
            hub_peer           : 0x1::option::none<HubPeerBinding>(),
            consumed_hub_guids : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<HubOApp>(v3);
    }

    fun intent_id(arg0: u32, arg1: vector<u8>) : vector<u8> {
        let v0 = IntentPreimageV1{
            domain       : b"DAY_INTENT",
            dst_eid      : arg0,
            command_hash : arg1,
        };
        0x1::hash::sha2_256(0x2::bcs::to_bytes<IntentPreimageV1>(&v0))
    }

    public fun is_registered(arg0: &HubOApp) : bool {
        0x1::option::is_some<address>(&arg0.endpoint_object) && 0x1::option::is_some<address>(&arg0.messaging_channel)
    }

    public fun is_supported_remote(arg0: u32) : bool {
        if (arg0 == 30184) {
            true
        } else if (arg0 == 30110) {
            true
        } else if (arg0 == 30168) {
            true
        } else if (arg0 == 30101) {
            true
        } else if (arg0 == 30102) {
            true
        } else if (arg0 == 30109) {
            true
        } else if (arg0 == 30383) {
            true
        } else if (arg0 == 30416) {
            true
        } else {
            arg0 == 30367
        }
    }

    public fun lz_receive_execution_outcome(arg0: &mut HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::clock::Clock) {
        assert!(is_registered(arg0), 2);
        assert_oapp(arg0, arg1);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_receive(arg1, &arg0.call_cap, arg2);
        assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::value(&v0)), 18);
        let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::src_eid(&v0);
        assert!(is_supported_remote(v1), 11);
        let v2 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::guid(&v0);
        apply_authenticated_outcome(arg0, v1, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::sender(&v0), 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::nonce(&v0), 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v2), *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::message(&v0), 0x2::clock::timestamp_ms(arg3));
        let (_, _, _, _, _, _, _, v10) = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::destroy(v0);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v10);
    }

    public fun mark_expired_intent_failed(arg0: &mut HubOApp, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, OutboundIntent>(&arg0.outbound_intents, arg1), 22);
        let v0 = 0x2::table::borrow<vector<u8>, OutboundIntent>(&arg0.outbound_intents, arg1);
        assert!(!v0.outcome_recorded, 23);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 > v0.expires_at_ms, 29);
        let v2 = v0.expires_at_ms;
        let v3 = 0x2::table::borrow_mut<vector<u8>, OutboundIntent>(&mut arg0.outbound_intents, arg1);
        v3.outcome_recorded = true;
        v3.outcome = 2;
        let v4 = HubIntentExpired{
            dst_eid        : v0.dst_eid,
            peer           : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v0.peer),
            intent_id      : arg1,
            command_hash   : v0.command_hash,
            expires_at_ms  : v2,
            recorded_at_ms : v1,
            outcome        : 2,
        };
        0x2::event::emit<HubIntentExpired>(v4);
    }

    public fun oapp_object(arg0: &HubOApp) : address {
        arg0.oapp_object
    }

    public fun oapp_package_id(arg0: &HubOApp) : address {
        0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap)
    }

    public fun prune_expired_intent(arg0: &mut HubOApp, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, OutboundIntent>(&arg0.outbound_intents, arg1), 22);
        let v0 = 0x2::table::borrow<vector<u8>, OutboundIntent>(&arg0.outbound_intents, arg1);
        let v1 = v0.expires_at_ms;
        assert!(v0.outcome_received, 26);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 > v1 && v2 - v1 > 2592000000, 26);
        0x2::table::remove<vector<u8>, OutboundIntent>(&mut arg0.outbound_intents, arg1);
        let v3 = HubIntentPruned{intent_id: arg1};
        0x2::event::emit<HubIntentPruned>(v3);
    }

    fun reallocate_options(arg0: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg1: u32) : vector<u8> {
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::combine_options(arg0, arg1, 1, b"");
        assert!(!0x1::vector::is_empty<u8>(&v0), 28);
        v0
    }

    public fun receive_hub_deposit(arg0: &mut HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::clock::Clock) : AuthenticatedHubDeposit {
        let v0 = authenticate_hub_command(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        assert!(v0.action == 1, 36);
        let DecodedHubCommand {
            action          : _,
            instruction_id  : v2,
            origin_chain    : v3,
            origin_owner    : v4,
            origin_asset    : v5,
            amount_micros   : v6,
            expires_at_ms   : v7,
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
        } = v0;
        let v11 = HubDepositReceived{
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
            instruction_id  : v2,
            origin_owner    : v4,
            amount_micros   : v6,
            expires_at_ms   : v7,
        };
        0x2::event::emit<HubDepositReceived>(v11);
        AuthenticatedHubDeposit{
            instruction_id  : v2,
            origin_chain    : v3,
            origin_owner    : v4,
            origin_asset    : v5,
            amount_micros   : v6,
            expires_at_ms   : v7,
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
        }
    }

    public fun receive_hub_withdraw_request(arg0: &mut HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::lz_receive::LzReceiveParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>, arg3: &0x2::clock::Clock) : AuthenticatedHubWithdrawRequest {
        let v0 = authenticate_hub_command(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        assert!(v0.action == 2, 36);
        let DecodedHubCommand {
            action          : _,
            instruction_id  : v2,
            origin_chain    : v3,
            origin_owner    : v4,
            origin_asset    : v5,
            amount_micros   : v6,
            expires_at_ms   : v7,
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
        } = v0;
        let v11 = HubWithdrawRequestReceived{
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
            instruction_id  : v2,
            origin_owner    : v4,
            amount_micros   : v6,
            expires_at_ms   : v7,
        };
        0x2::event::emit<HubWithdrawRequestReceived>(v11);
        AuthenticatedHubWithdrawRequest{
            instruction_id  : v2,
            origin_chain    : v3,
            origin_owner    : v4,
            origin_asset    : v5,
            amount_micros   : v6,
            expires_at_ms   : v7,
            src_eid         : v8,
            layerzero_nonce : v9,
            guid            : v10,
        }
    }

    public fun register_hub_peer(arg0: &mut HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &GovernanceCap, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_governance(arg0, arg2);
        assert_ready(arg0, arg1, arg3, arg4);
        assert!(is_supported_remote(arg5), 11);
        assert!(0x1::vector::length<u8>(&arg6) == 20, 35);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes_left_padded(arg6);
        assert!(!0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::is_zero(&v0), 37);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::set_peer(arg1, &arg0.admin_cap, arg3, arg4, arg5, v0, arg7);
        let v1 = HubPeerBinding{
            eid  : arg5,
            peer : v0,
        };
        arg0.hub_peer = 0x1::option::some<HubPeerBinding>(v1);
        let v2 = HubPeerRegistered{
            hub_eid  : arg5,
            hub_peer : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v0),
        };
        0x2::event::emit<HubPeerRegistered>(v2);
    }

    public fun send_authorized_hub_command(arg0: &mut HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::AuthorizedHubCommand, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : PendingAuthorizedHubSend {
        let (v0, v1) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::hub_protocol::authorized_transport_message(&arg4);
        PendingAuthorizedHubSend{
            authorized : arg4,
            call       : send_hub_command(arg0, arg1, arg2, arg3, v0, v1, arg5, arg6, arg7),
        }
    }

    public(friend) fun send_hub_command(arg0: &mut HubOApp, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg3: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_channel::MessagingChannel, arg4: u32, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        assert_ready(arg0, arg1, arg2, arg3);
        let v0 = assert_hub_message(arg4, &arg5);
        assert!(0x2::clock::timestamp_ms(arg7) <= v0, 17);
        assert!(0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::has_peer(arg1, arg4), 11);
        let v1 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::get_peer(arg1, arg4);
        let v2 = 0x1::hash::sha2_256(arg5);
        let v3 = intent_id(arg4, v2);
        assert!(!0x2::table::contains<vector<u8>, OutboundIntent>(&arg0.outbound_intents, v3), 21);
        let v4 = OutboundIntent{
            dst_eid          : arg4,
            peer             : v1,
            command_hash     : v2,
            expires_at_ms    : v0,
            outcome_recorded : false,
            outcome_received : false,
            outcome          : 0,
        };
        0x2::table::add<vector<u8>, OutboundIntent>(&mut arg0.outbound_intents, v3, v4);
        let v5 = HubCommandCommitted{
            dst_eid       : arg4,
            peer          : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::to_bytes(&v1),
            intent_id     : v3,
            command_hash  : v2,
            expires_at_ms : v0,
        };
        0x2::event::emit<HubCommandCommitted>(v5);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send(arg1, &arg0.call_cap, arg4, arg5, reallocate_options(arg1, arg4), arg6, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x1::option::some<address>(0x2::tx_context::sender(arg8)), arg8)
    }

    public fun sui_eid() : u32 {
        30378
    }

    public fun update_oapp_info(arg0: &HubOApp, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: &GovernanceCap, arg3: &mut 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert_governance(arg0, arg2);
        assert!(is_registered(arg0), 2);
        assert_endpoint(arg0, arg3);
        assert_oapp(arg0, arg1);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 27);
        let v0 = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::create(arg0.oapp_object, arg4, arg5, arg6);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::set_oapp_info(arg3, &arg0.call_cap, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0.call_cap), 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp_info_v1::encode(&v0));
    }

    public fun withdraw_proof_amount_micros(arg0: &AuthenticatedHubWithdrawRequest) : u64 {
        arg0.amount_micros
    }

    public fun withdraw_proof_expires_at_ms(arg0: &AuthenticatedHubWithdrawRequest) : u64 {
        arg0.expires_at_ms
    }

    public fun withdraw_proof_instruction_id(arg0: &AuthenticatedHubWithdrawRequest) : vector<u8> {
        arg0.instruction_id
    }

    public fun withdraw_proof_origin_owner(arg0: &AuthenticatedHubWithdrawRequest) : address {
        arg0.origin_owner
    }

    public fun withdraw_proof_src_eid(arg0: &AuthenticatedHubWithdrawRequest) : u32 {
        arg0.src_eid
    }

    // decompiled from Move bytecode v7
}

