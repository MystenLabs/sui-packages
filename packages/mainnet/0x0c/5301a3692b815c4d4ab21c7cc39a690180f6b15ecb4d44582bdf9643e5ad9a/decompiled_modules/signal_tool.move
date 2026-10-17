module 0xc5301a3692b815c4d4ab21c7cc39a690180f6b15ecb4d44582bdf9643e5ad9a::signal_tool {
    struct SIGNAL_TOOL has drop {
        dummy_field: bool,
    }

    struct SignalHub has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        bindings: 0x2::table::Table<0x2::object::ID, Binding>,
        recorded: u64,
    }

    struct Binding has drop, store {
        agent_id: 0x2::object::ID,
        last_nonce: u64,
    }

    struct HubAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SignalRecorded has copy, drop {
        hub: 0x2::object::ID,
        seq: u64,
        mandate: 0x2::object::ID,
        owner: address,
        agent: 0x2::object::ID,
        side: u64,
        coin_type: 0x1::ascii::String,
        sui_mist: u64,
        fraction_bps: u64,
        nonce: u64,
        epoch_ms: u64,
    }

    struct SignalRejected has copy, drop {
        hub: 0x2::object::ID,
        mandate: 0x2::object::ID,
        agent: 0x2::object::ID,
        reason: 0x1::ascii::String,
    }

    struct AgentBound has copy, drop {
        hub: 0x2::object::ID,
        mandate: 0x2::object::ID,
        owner: address,
        agent: 0x2::object::ID,
    }

    struct AgentUnbound has copy, drop {
        hub: 0x2::object::ID,
        mandate: 0x2::object::ID,
        owner: address,
    }

    public fun bind_agent(arg0: &mut SignalHub, arg1: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 3);
        let v0 = 0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::owner(arg1);
        assert!(0x2::tx_context::sender(arg3) == v0, 0);
        let v1 = 0x2::object::id<0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate>(arg1);
        if (0x2::table::contains<0x2::object::ID, Binding>(&arg0.bindings, v1)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, Binding>(&mut arg0.bindings, v1);
            if (v2.agent_id != arg2) {
                v2.agent_id = arg2;
                v2.last_nonce = 0;
            };
        } else {
            let v3 = Binding{
                agent_id   : arg2,
                last_nonce : 0,
            };
            0x2::table::add<0x2::object::ID, Binding>(&mut arg0.bindings, v1, v3);
        };
        let v4 = AgentBound{
            hub     : 0x2::object::id<SignalHub>(arg0),
            mandate : v1,
            owner   : v0,
            agent   : arg2,
        };
        0x2::event::emit<AgentBound>(v4);
    }

    public fun bound_agent(arg0: &SignalHub, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, Binding>(&arg0.bindings, arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, Binding>(&arg0.bindings, arg1).agent_id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun check(arg0: &SignalHub, arg1: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: &vector<u8>, arg6: u64, arg7: u64, arg8: u64) : vector<u8> {
        if (arg0.paused) {
            return b"hub_paused"
        };
        if (!0x2::table::contains<0x2::object::ID, Binding>(&arg0.bindings, arg2)) {
            return b"agent_not_bound"
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Binding>(&arg0.bindings, arg2);
        if (v0.agent_id != arg3) {
            return b"agent_not_bound"
        };
        if (!0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::allows_signals(arg1)) {
            return b"signals_off"
        };
        if (0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::is_paused(arg1)) {
            return b"mandate_paused"
        };
        if (!valid_coin_type(arg5)) {
            return b"bad_coin_type"
        };
        if (arg4 == 0) {
            if (arg7 != 0) {
                return b"bad_amount"
            };
        } else if (arg4 == 1) {
            let v1 = if (arg6 != 0) {
                true
            } else if (arg7 == 0) {
                true
            } else {
                arg7 > 10000
            };
            if (v1) {
                return b"bad_amount"
            };
        } else {
            return b"bad_side"
        };
        if (arg8 <= v0.last_nonce) {
            return b"stale_nonce"
        };
        b""
    }

    fun create_hub_and_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_hub(arg0);
        0x2::transfer::share_object<SignalHub>(v0);
        let v1 = HubAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<HubAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun decide(arg0: &mut SignalHub, arg1: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) : (vector<u8>, u64) {
        let v0 = 0x2::object::id<0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate>(arg1);
        let v1 = check(arg0, arg1, v0, arg2, arg3, &arg4, arg5, arg6, arg7);
        if (!0x1::vector::is_empty<u8>(&v1)) {
            let v2 = SignalRejected{
                hub     : 0x2::object::id<SignalHub>(arg0),
                mandate : v0,
                agent   : arg2,
                reason  : 0x1::ascii::string(v1),
            };
            0x2::event::emit<SignalRejected>(v2);
            return (v1, 0)
        };
        0x2::table::borrow_mut<0x2::object::ID, Binding>(&mut arg0.bindings, v0).last_nonce = arg7;
        arg0.recorded = arg0.recorded + 1;
        let v3 = arg0.recorded;
        let v4 = SignalRecorded{
            hub          : 0x2::object::id<SignalHub>(arg0),
            seq          : v3,
            mandate      : v0,
            owner        : 0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::owner(arg1),
            agent        : arg2,
            side         : arg3,
            coin_type    : 0x1::ascii::string(arg4),
            sui_mist     : arg5,
            fraction_bps : arg6,
            nonce        : arg7,
            epoch_ms     : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<SignalRecorded>(v4);
        (b"", v3)
    }

    public fun execute(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg3: &mut SignalHub, arg4: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 3);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::input_commitment(&arg2);
        assert!(v0 == input_commitment(arg3, arg4, arg5, &arg6, arg7, arg8, arg9), 2);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::consume_verified_for_worksheet_as_recipient(arg0, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::proof(&arg1), &arg3.id, v0), 1);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::satisfy(&mut arg1, &arg3.id);
        let (v1, v2) = decide(arg3, arg4, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::by<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>(&arg0), arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        let v4 = if (0x1::vector::is_empty<u8>(&v3)) {
            0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"recorded"), b"seq", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(v2)))), b"side", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg5)))), b"sui_mist", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg7)))), b"fraction_bps", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg8)))), b"nonce", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg9))))
        } else {
            let v5 = b"\"";
            0x1::vector::append<u8>(&mut v5, v3);
            0x1::vector::append<u8>(&mut v5, b"\"");
            0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::with_named_payload(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::new(b"rejected"), b"reason", 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(v5))
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::finalize_and_share(arg2, arg1, v4, arg10);
    }

    fun init(arg0: SIGNAL_TOOL, arg1: &mut 0x2::tx_context::TxContext) {
        create_hub_and_cap(arg1);
    }

    fun input_commitment(arg0: &SignalHub, arg1: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<SignalHub>(arg0));
        let v1 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::object_value(0x2::object::id<0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate>(arg1));
        let v2 = 0x1::vector::empty<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(arg3)) {
            0x1::vector::push_back<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue>(&mut v2, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u8::to_string(*0x1::vector::borrow<u8>(arg3, v3)))));
            v3 = v3 + 1;
        };
        let v4 = num(arg2);
        let v5 = num(arg4);
        let v6 = num(arg5);
        let v7 = num(arg6);
        let v8 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v0));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v1));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v4));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_many(&v2));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v5));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v6));
        0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortCommitment>(v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_commitment_one(&v7));
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_hash(vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6"], v8)
    }

    public fun is_paused(arg0: &SignalHub) : bool {
        arg0.paused
    }

    fun is_sui(arg0: &vector<u8>) : bool {
        *arg0 == b"0x2::sui::SUI" || *arg0 == b"0x0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"
    }

    public fun last_nonce(arg0: &SignalHub, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, Binding>(&arg0.bindings, arg1)) {
            0x2::table::borrow<0x2::object::ID, Binding>(&arg0.bindings, arg1).last_nonce
        } else {
            0
        }
    }

    public fun migrate(arg0: &HubAdminCap, arg1: &mut SignalHub) {
        assert!(arg1.version < 1, 4);
        arg1.version = 1;
    }

    fun new_hub(arg0: &mut 0x2::tx_context::TxContext) : SignalHub {
        SignalHub{
            id       : 0x2::object::new(arg0),
            version  : 1,
            paused   : false,
            bindings : 0x2::table::new<0x2::object::ID, Binding>(arg0),
            recorded : 0,
        }
    }

    fun num(arg0: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusValue {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(0x1::string::into_bytes(0x1::u64::to_string(arg0)))
    }

    public fun recorded(arg0: &SignalHub) : u64 {
        arg0.recorded
    }

    public fun set_paused(arg0: &HubAdminCap, arg1: &mut SignalHub, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun tool_witness_id(arg0: &SignalHub) : 0x2::object::ID {
        0x2::object::id<SignalHub>(arg0)
    }

    public fun unbind_agent(arg0: &mut SignalHub, arg1: &0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::owner(arg1);
        assert!(0x2::tx_context::sender(arg2) == v0, 0);
        let v1 = 0x2::object::id<0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate::Mandate>(arg1);
        if (0x2::table::contains<0x2::object::ID, Binding>(&arg0.bindings, v1)) {
            0x2::table::remove<0x2::object::ID, Binding>(&mut arg0.bindings, v1);
        };
        let v2 = AgentUnbound{
            hub     : 0x2::object::id<SignalHub>(arg0),
            mandate : v1,
            owner   : v0,
        };
        0x2::event::emit<AgentUnbound>(v2);
    }

    fun valid_coin_type(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < 8 || v0 > 256) {
            return false
        };
        if (*0x1::vector::borrow<u8>(arg0, 0) != 48 || *0x1::vector::borrow<u8>(arg0, 1) != 120) {
            return false
        };
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v1);
            let v4 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 == 95) {
                true
            } else {
                v3 == 58
            };
            if (!v4) {
                return false
            };
            if (v3 == 58) {
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        if (v2 != 4) {
            return false
        };
        !is_sui(arg0)
    }

    public fun version(arg0: &SignalHub) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

