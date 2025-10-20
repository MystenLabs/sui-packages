module 0x7bf5274804a6008ebfbd9bfe766defb7fd5aa5fe6777419c2b6531ec99120b55::exchange {
    struct FileCommitment has copy, drop, store {
        hash: vector<u8>,
        size: u64,
        mime_type: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        thumbnail_hash: 0x1::option::Option<vector<u8>>,
        metadata_digest: 0x1::option::Option<vector<u8>>,
    }

    struct AssetCommitment has copy, drop, store {
        asset_type: u8,
        amount: u64,
        coin_type: 0x1::option::Option<0x1::string::String>,
        object_id: 0x1::option::Option<0x2::object::ID>,
        file_commitment: 0x1::option::Option<FileCommitment>,
        description: 0x1::string::String,
    }

    struct Participant has copy, drop, store {
        address: address,
        commitment: AssetCommitment,
        deposited: bool,
        anti_griefing_fee_paid: u64,
    }

    struct AgentAttestation has copy, drop, store {
        agent_address: address,
        chamber_id: 0x2::object::ID,
        participant_address: address,
        attestation_hash: vector<u8>,
        signature: vector<u8>,
        timestamp: u64,
        verified_properties: vector<0x1::string::String>,
    }

    struct ExchangeChamber has store, key {
        id: 0x2::object::UID,
        creator: address,
        phase: u8,
        participants: vector<Participant>,
        timeout_ms: u64,
        created_at: u64,
        phase_updated_at: u64,
        anti_griefing_fee: u64,
        attestations: vector<AgentAttestation>,
        dispute_reason: 0x1::option::Option<0x1::string::String>,
        finalized_at: 0x1::option::Option<u64>,
    }

    struct AttestorRegistry has store, key {
        id: 0x2::object::UID,
        admin: address,
        authorized_agents: vector<address>,
        min_attestations_required: u64,
    }

    struct ChamberCap has store, key {
        id: 0x2::object::UID,
        chamber_id: 0x2::object::ID,
        participant_address: address,
    }

    struct OfferCreatedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        creator: address,
        commitment: AssetCommitment,
        timeout_ms: u64,
        anti_griefing_fee: u64,
        timestamp: u64,
    }

    struct OfferJoinedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        joiner: address,
        commitment: AssetCommitment,
        timestamp: u64,
    }

    struct DepositsCommittedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        participant: address,
        asset_type: u8,
        amount: u64,
        walrus_blob_id: 0x1::option::Option<0x1::string::String>,
        commitment_hash: 0x1::option::Option<vector<u8>>,
        timestamp: u64,
    }

    struct VerificationStartedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AttestationProvidedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        agent: address,
        participant: address,
        attestation_hash: vector<u8>,
        verified_properties: vector<0x1::string::String>,
        timestamp: u64,
    }

    struct ExchangeFinalizedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        participant_a: address,
        participant_b: address,
        timestamp: u64,
    }

    struct ExchangeDisputedEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        disputer: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct TimeoutRefundEvent has copy, drop {
        chamber_id: 0x2::object::ID,
        participant: address,
        refunded_amount: u64,
        timestamp: u64,
    }

    entry fun add_authorized_agent(arg0: &mut AttestorRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        if (!0x1::vector::contains<address>(&arg0.authorized_agents, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_agents, arg1);
        };
    }

    fun address_to_string(arg0: address) : 0x1::string::String {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0) && v2 < 8) {
            0x1::string::append(&mut v1, byte_to_hex(*0x1::vector::borrow<u8>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    fun byte_to_hex(arg0: u8) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((arg0 / 16) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((arg0 % 16) as u64)));
        0x1::string::utf8(v1)
    }

    fun check_all_deposited(arg0: &vector<Participant>) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Participant>(arg0)) {
            if (!0x1::vector::borrow<Participant>(arg0, v1).deposited) {
                v0 = false;
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    entry fun commit_file(arg0: &mut ExchangeChamber, arg1: &ChamberCap, arg2: vector<u8>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg0.phase == 1, 1);
        assert!(arg1.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg1.participant_address == v0, 2);
        let v2 = if (0x1::vector::is_empty<u8>(&arg6)) {
            0x1::option::none<vector<u8>>()
        } else {
            0x1::option::some<vector<u8>>(arg6)
        };
        let v3 = if (0x1::vector::is_empty<u8>(&arg7)) {
            0x1::option::none<vector<u8>>()
        } else {
            0x1::option::some<vector<u8>>(arg7)
        };
        let v4 = FileCommitment{
            hash            : arg2,
            size            : arg3,
            mime_type       : arg4,
            walrus_blob_id  : arg5,
            thumbnail_hash  : v2,
            metadata_digest : v3,
        };
        let v5 = &mut arg0.participants;
        let v6 = 0;
        let v7 = false;
        while (v6 < 0x1::vector::length<Participant>(v5)) {
            let v8 = 0x1::vector::borrow_mut<Participant>(v5, v6);
            if (v8.address == v0) {
                assert!(!v8.deposited, 6);
                assert!(v8.commitment.asset_type == 3, 7);
                v8.deposited = true;
                v7 = true;
                break
            };
            v6 = v6 + 1;
        };
        assert!(v7, 2);
        0x2::dynamic_field::add<0x1::string::String, FileCommitment>(&mut arg0.id, get_participant_file_key(v0), v4);
        if (check_all_deposited(v5)) {
            arg0.phase = 2;
            arg0.phase_updated_at = v1;
        };
        let v9 = DepositsCommittedEvent{
            chamber_id      : 0x2::object::uid_to_inner(&arg0.id),
            participant     : v0,
            asset_type      : 3,
            amount          : 0,
            walrus_blob_id  : 0x1::option::some<0x1::string::String>(arg5),
            commitment_hash : 0x1::option::some<vector<u8>>(arg2),
            timestamp       : v1,
        };
        0x2::event::emit<DepositsCommittedEvent>(v9);
    }

    entry fun create_attestor_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttestorRegistry{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            authorized_agents         : 0x1::vector::empty<address>(),
            min_attestations_required : 1,
        };
        0x2::transfer::share_object<AttestorRegistry>(v0);
    }

    public fun create_offer(arg0: AssetCommitment, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= 1000000000, 8);
        let v5 = Participant{
            address                : v0,
            commitment             : arg0,
            deposited              : false,
            anti_griefing_fee_paid : v4,
        };
        let v6 = ExchangeChamber{
            id                : v1,
            creator           : v0,
            phase             : 0,
            participants      : 0x1::vector::singleton<Participant>(v5),
            timeout_ms        : arg1,
            created_at        : v3,
            phase_updated_at  : v3,
            anti_griefing_fee : v4,
            attestations      : 0x1::vector::empty<AgentAttestation>(),
            dispute_reason    : 0x1::option::none<0x1::string::String>(),
            finalized_at      : 0x1::option::none<u64>(),
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v6.id, b"anti_griefing_fees", 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v7 = ChamberCap{
            id                  : 0x2::object::new(arg4),
            chamber_id          : v2,
            participant_address : v0,
        };
        let v8 = OfferCreatedEvent{
            chamber_id        : v2,
            creator           : v0,
            commitment        : arg0,
            timeout_ms        : arg1,
            anti_griefing_fee : v4,
            timestamp         : v3,
        };
        0x2::event::emit<OfferCreatedEvent>(v8);
        0x2::transfer::share_object<ExchangeChamber>(v6);
        0x2::transfer::transfer<ChamberCap>(v7, v0);
    }

    public fun deposit_coin<T0>(arg0: &mut ExchangeChamber, arg1: &ChamberCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(arg0.phase == 1, 1);
        assert!(arg1.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg1.participant_address == v0, 2);
        let v4 = &mut arg0.participants;
        let v5 = 0;
        let v6 = false;
        while (v5 < 0x1::vector::length<Participant>(v4)) {
            let v7 = 0x1::vector::borrow_mut<Participant>(v4, v5);
            if (v7.address == v0) {
                assert!(!v7.deposited, 6);
                assert!(v7.commitment.asset_type == 1, 7);
                assert!(v7.commitment.amount == v2, 4);
                if (0x1::option::is_some<0x1::string::String>(&v7.commitment.coin_type)) {
                    assert!(0x1::string::bytes(0x1::option::borrow<0x1::string::String>(&v7.commitment.coin_type)) == 0x1::string::bytes(&v3), 7);
                };
                v7.deposited = true;
                v6 = true;
                break
            };
            v5 = v5 + 1;
        };
        assert!(v6, 2);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, get_participant_coin_key<T0>(v0), arg2);
        if (check_all_deposited(v4)) {
            arg0.phase = 2;
            arg0.phase_updated_at = v1;
        };
        let v8 = DepositsCommittedEvent{
            chamber_id      : 0x2::object::uid_to_inner(&arg0.id),
            participant     : v0,
            asset_type      : 1,
            amount          : v2,
            walrus_blob_id  : 0x1::option::none<0x1::string::String>(),
            commitment_hash : 0x1::option::none<vector<u8>>(),
            timestamp       : v1,
        };
        0x2::event::emit<DepositsCommittedEvent>(v8);
    }

    entry fun deposit_sui(arg0: &mut ExchangeChamber, arg1: &ChamberCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(arg0.phase == 1, 1);
        assert!(arg1.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg1.participant_address == v0, 2);
        let v3 = &mut arg0.participants;
        let v4 = 0;
        let v5 = false;
        AssetCommitment{asset_type: 0, amount: 0, coin_type: 0x1::option::none<0x1::string::String>(), object_id: 0x1::option::none<0x2::object::ID>(), file_commitment: 0x1::option::none<FileCommitment>(), description: 0x1::string::utf8(b"")};
        while (v4 < 0x1::vector::length<Participant>(v3)) {
            let v6 = 0x1::vector::borrow_mut<Participant>(v3, v4);
            if (v6.address == v0) {
                assert!(!v6.deposited, 6);
                assert!(v6.commitment.asset_type == 0, 7);
                assert!(v6.commitment.amount == v2, 4);
                v6.deposited = true;
                v5 = true;
                break
            };
            v4 = v4 + 1;
        };
        assert!(v5, 2);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, get_participant_sui_key(v0), arg2);
        if (check_all_deposited(v3)) {
            arg0.phase = 2;
            arg0.phase_updated_at = v1;
        };
        let v7 = DepositsCommittedEvent{
            chamber_id      : 0x2::object::uid_to_inner(&arg0.id),
            participant     : v0,
            asset_type      : 0,
            amount          : v2,
            walrus_blob_id  : 0x1::option::none<0x1::string::String>(),
            commitment_hash : 0x1::option::none<vector<u8>>(),
            timestamp       : v1,
        };
        0x2::event::emit<DepositsCommittedEvent>(v7);
    }

    entry fun dispute(arg0: &mut ExchangeChamber, arg1: &ChamberCap, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg1.participant_address == v0, 2);
        assert!(arg0.phase == 3 || arg0.phase == 2, 1);
        arg0.phase = 5;
        arg0.phase_updated_at = v1;
        arg0.dispute_reason = 0x1::option::some<0x1::string::String>(arg2);
        let v2 = ExchangeDisputedEvent{
            chamber_id : 0x2::object::uid_to_inner(&arg0.id),
            disputer   : v0,
            reason     : arg2,
            timestamp  : v1,
        };
        0x2::event::emit<ExchangeDisputedEvent>(v2);
    }

    fun execute_asset_transfer(arg0: &mut ExchangeChamber, arg1: address, arg2: address, arg3: &AssetCommitment, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3.asset_type == 0) {
            let v0 = get_participant_sui_key(arg1);
            if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0), arg2);
            };
        };
    }

    entry fun finalize(arg0: &mut ExchangeChamber, arg1: &AttestorRegistry, arg2: &ChamberCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.phase == 3, 1);
        assert!(arg2.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg2.participant_address == 0x2::tx_context::sender(arg4), 2);
        assert!(has_sufficient_attestations(arg0, arg1), 10);
        arg0.phase = 4;
        arg0.phase_updated_at = v0;
        arg0.finalized_at = 0x1::option::some<u64>(v0);
        let v1 = 0x1::vector::borrow<Participant>(&arg0.participants, 0).address;
        let v2 = 0x1::vector::borrow<Participant>(&arg0.participants, 1).address;
        let v3 = 0x1::vector::borrow<Participant>(&arg0.participants, 0).commitment;
        let v4 = 0x1::vector::borrow<Participant>(&arg0.participants, 1).commitment;
        execute_asset_transfer(arg0, v1, v2, &v3, arg4);
        execute_asset_transfer(arg0, v2, v1, &v4, arg4);
        let v5 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, b"anti_griefing_fees");
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5) / 2;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v5, v6, arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v5, v6, arg4), v2);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        let v7 = ExchangeFinalizedEvent{
            chamber_id    : 0x2::object::uid_to_inner(&arg0.id),
            participant_a : v1,
            participant_b : v2,
            timestamp     : v0,
        };
        0x2::event::emit<ExchangeFinalizedEvent>(v7);
    }

    public fun get_all_attestations(arg0: &ExchangeChamber) : vector<AgentAttestation> {
        arg0.attestations
    }

    public fun get_attestation(arg0: &ExchangeChamber, arg1: u64) : 0x1::option::Option<AgentAttestation> {
        if (arg1 < 0x1::vector::length<AgentAttestation>(&arg0.attestations)) {
            0x1::option::some<AgentAttestation>(*0x1::vector::borrow<AgentAttestation>(&arg0.attestations, arg1))
        } else {
            0x1::option::none<AgentAttestation>()
        }
    }

    public fun get_attestation_count(arg0: &ExchangeChamber) : u64 {
        0x1::vector::length<AgentAttestation>(&arg0.attestations)
    }

    public fun get_chamber_info(arg0: &ExchangeChamber) : (u8, u64, u64, u64) {
        (arg0.phase, arg0.timeout_ms, arg0.created_at, arg0.phase_updated_at)
    }

    public fun get_file_commitment(arg0: &ExchangeChamber, arg1: address) : 0x1::option::Option<FileCommitment> {
        let v0 = get_participant_file_key(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x1::option::some<FileCommitment>(*0x2::dynamic_field::borrow<0x1::string::String, FileCommitment>(&arg0.id, v0))
        } else {
            0x1::option::none<FileCommitment>()
        }
    }

    public fun get_participant_attestations(arg0: &ExchangeChamber, arg1: address) : vector<AgentAttestation> {
        let v0 = 0x1::vector::empty<AgentAttestation>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<AgentAttestation>(&arg0.attestations)) {
            let v2 = 0x1::vector::borrow<AgentAttestation>(&arg0.attestations, v1);
            if (v2.participant_address == arg1) {
                0x1::vector::push_back<AgentAttestation>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_participant_coin_key<T0>(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"coin_");
        0x1::string::append(&mut v0, address_to_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"_"));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    public fun get_participant_count(arg0: &ExchangeChamber) : u64 {
        0x1::vector::length<Participant>(&arg0.participants)
    }

    fun get_participant_file_key(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"file_");
        0x1::string::append(&mut v0, address_to_string(arg0));
        v0
    }

    fun get_participant_sui_key(arg0: address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"sui_");
        0x1::string::append(&mut v0, address_to_string(arg0));
        v0
    }

    public fun get_phase(arg0: &ExchangeChamber) : u8 {
        arg0.phase
    }

    public fun get_sui_deposit_amount(arg0: &ExchangeChamber, arg1: address) : u64 {
        let v0 = get_participant_sui_key(arg1);
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x2::coin::value<0x2::sui::SUI>(0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_verification_summary(arg0: &ExchangeChamber, arg1: &AttestorRegistry) : (u64, u64, bool) {
        (0x1::vector::length<AgentAttestation>(&arg0.attestations), arg1.min_attestations_required, has_sufficient_attestations(arg0, arg1))
    }

    public fun has_agent_attestation(arg0: &ExchangeChamber, arg1: address, arg2: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AgentAttestation>(&arg0.attestations)) {
            let v1 = 0x1::vector::borrow<AgentAttestation>(&arg0.attestations, v0);
            if (v1.agent_address == arg1 && v1.participant_address == arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun has_sufficient_attestations(arg0: &ExchangeChamber, arg1: &AttestorRegistry) : bool {
        let v0 = &arg0.participants;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Participant>(v0)) {
            let v2 = get_participant_attestations(arg0, 0x1::vector::borrow<Participant>(v0, v1).address);
            if (0x1::vector::length<AgentAttestation>(&v2) < arg1.min_attestations_required) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun has_sui_deposit(arg0: &ExchangeChamber, arg1: address) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, get_participant_sui_key(arg1))
    }

    public fun is_authorized_agent(arg0: &AttestorRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_agents, &arg1)
    }

    public fun is_ready_for_finalization(arg0: &ExchangeChamber) : bool {
        if (arg0.phase == 3) {
            if (0x1::vector::length<Participant>(&arg0.participants) == 2) {
                let v1 = true;
                let v2 = 0;
                while (v2 < 0x1::vector::length<Participant>(&arg0.participants)) {
                    if (!0x1::vector::borrow<Participant>(&arg0.participants, v2).deposited) {
                        v1 = false;
                        break
                    };
                    v2 = v2 + 1;
                };
                v1
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun join_offer(arg0: &mut ExchangeChamber, arg1: AssetCommitment, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.phase == 0, 1);
        assert!(0x1::vector::length<Participant>(&arg0.participants) == 1, 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= arg0.anti_griefing_fee, 8);
        let v3 = Participant{
            address                : v0,
            commitment             : arg1,
            deposited              : false,
            anti_griefing_fee_paid : v2,
        };
        0x1::vector::push_back<Participant>(&mut arg0.participants, v3);
        arg0.phase = 1;
        arg0.phase_updated_at = v1;
        0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, b"anti_griefing_fees"), 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v4 = ChamberCap{
            id                  : 0x2::object::new(arg4),
            chamber_id          : 0x2::object::uid_to_inner(&arg0.id),
            participant_address : v0,
        };
        let v5 = OfferJoinedEvent{
            chamber_id : 0x2::object::uid_to_inner(&arg0.id),
            joiner     : v0,
            commitment : arg1,
            timestamp  : v1,
        };
        0x2::event::emit<OfferJoinedEvent>(v5);
        0x2::transfer::transfer<ChamberCap>(v4, v0);
    }

    fun refund_participant_assets_by_data(arg0: &mut ExchangeChamber, arg1: address, arg2: &AssetCommitment, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (arg2.asset_type == 0) {
            let v1 = get_participant_sui_key(arg1);
            if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1);
                v0 = 0x2::coin::value<0x2::sui::SUI>(&v2);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg1);
            };
        } else if (arg2.asset_type == 3) {
            let v3 = get_participant_file_key(arg1);
            if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3)) {
                0x2::dynamic_field::remove<0x1::string::String, FileCommitment>(&mut arg0.id, v3);
            };
        };
        v0
    }

    entry fun register_njex_agent(arg0: &mut AttestorRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        if (!0x1::vector::contains<address>(&arg0.authorized_agents, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_agents, arg1);
        };
    }

    entry fun remove_authorized_agent(arg0: &mut AttestorRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.authorized_agents, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.authorized_agents, v1);
        };
    }

    entry fun start_verification(arg0: &mut ExchangeChamber, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.phase == 2, 1);
        arg0.phase = 3;
        arg0.phase_updated_at = v0;
        let v1 = VerificationStartedEvent{
            chamber_id : 0x2::object::uid_to_inner(&arg0.id),
            timestamp  : v0,
        };
        0x2::event::emit<VerificationStartedEvent>(v1);
    }

    entry fun submit_agent_attestation(arg0: &mut ExchangeChamber, arg1: &AttestorRegistry, arg2: address, arg3: vector<0x1::string::String>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg0.phase == 3, 1);
        assert!(is_authorized_agent(arg1, v0), 9);
        let v3 = &arg0.participants;
        let v4 = false;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Participant>(v3)) {
            if (0x1::vector::borrow<Participant>(v3, v5).address == arg2) {
                v4 = true;
                break
            };
            v5 = v5 + 1;
        };
        assert!(v4, 2);
        let v6 = 0x2::hash::keccak256(&arg4);
        let v7 = AgentAttestation{
            agent_address       : v0,
            chamber_id          : v2,
            participant_address : arg2,
            attestation_hash    : v6,
            signature           : arg5,
            timestamp           : v1,
            verified_properties : arg3,
        };
        0x1::vector::push_back<AgentAttestation>(&mut arg0.attestations, v7);
        let v8 = AttestationProvidedEvent{
            chamber_id          : v2,
            agent               : v0,
            participant         : arg2,
            attestation_hash    : v6,
            verified_properties : arg3,
            timestamp           : v1,
        };
        0x2::event::emit<AttestationProvidedEvent>(v8);
    }

    entry fun submit_qa_response(arg0: &mut ExchangeChamber, arg1: &AttestorRegistry, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg0.phase == 3, 1);
        assert!(is_authorized_agent(arg1, v0), 9);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"qa_response"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"confidence_"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, u8_to_string(arg5));
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, arg3);
        0x1::vector::append<u8>(&mut v3, arg4);
        let v4 = 0x2::hash::keccak256(&v3);
        let v5 = AgentAttestation{
            agent_address       : v0,
            chamber_id          : 0x2::object::uid_to_inner(&arg0.id),
            participant_address : arg2,
            attestation_hash    : v4,
            signature           : arg6,
            timestamp           : v1,
            verified_properties : v2,
        };
        0x1::vector::push_back<AgentAttestation>(&mut arg0.attestations, v5);
        let v6 = AttestationProvidedEvent{
            chamber_id          : 0x2::object::uid_to_inner(&arg0.id),
            agent               : v0,
            participant         : arg2,
            attestation_hash    : v4,
            verified_properties : v2,
            timestamp           : v1,
        };
        0x2::event::emit<AttestationProvidedEvent>(v6);
    }

    entry fun timeout_refund(arg0: &mut ExchangeChamber, arg1: &ChamberCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.created_at + arg0.timeout_ms, 5);
        assert!(arg1.chamber_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg1.participant_address == v0, 2);
        assert!(arg0.phase != 4, 1);
        arg0.phase = 6;
        arg0.phase_updated_at = v1;
        let v2 = 0x1::vector::length<Participant>(&arg0.participants);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v2) {
            let v5 = 0x1::vector::borrow<Participant>(&arg0.participants, v3).address;
            let v6 = 0x1::vector::borrow<Participant>(&arg0.participants, v3).commitment;
            if (0x1::vector::borrow<Participant>(&arg0.participants, v3).deposited) {
                let v7 = refund_participant_assets_by_data(arg0, v5, &v6, arg3);
                v4 = v4 + v7;
            };
            v3 = v3 + 1;
        };
        let v8 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, b"anti_griefing_fees");
        if (0x2::balance::value<0x2::sui::SUI>(&v8) > 0 && v2 >= 2) {
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&v8);
            if (v9 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v8, v9, arg3), 0x1::vector::borrow<Participant>(&arg0.participants, 1).address);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v8, 0x1::vector::borrow<Participant>(&arg0.participants, 0).anti_griefing_fee_paid, arg3), 0x1::vector::borrow<Participant>(&arg0.participants, 0).address);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        let v10 = TimeoutRefundEvent{
            chamber_id      : 0x2::object::uid_to_inner(&arg0.id),
            participant     : v0,
            refunded_amount : v4,
            timestamp       : v1,
        };
        0x2::event::emit<TimeoutRefundEvent>(v10);
    }

    fun u8_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 48 + arg0 % 10);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun verify_agent_attestation(arg0: &AttestorRegistry, arg1: address, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) : bool {
        if (!is_authorized_agent(arg0, arg1)) {
            return false
        };
        let v0 = 0x2::hash::keccak256(arg2);
        0x2::ecdsa_k1::secp256k1_verify(arg3, arg4, &v0, 1)
    }

    // decompiled from Move bytecode v6
}

