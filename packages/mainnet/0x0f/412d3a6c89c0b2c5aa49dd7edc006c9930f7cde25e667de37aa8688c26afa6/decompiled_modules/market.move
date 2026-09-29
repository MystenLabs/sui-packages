module 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::market {
    struct SettlementCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HouseSettlementKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HouseSettlement has copy, drop, store {
        consumed: u64,
        paid: u64,
    }

    struct ReservePositionSettled has copy, drop {
        market_id: 0x2::object::ID,
        holder: address,
        stake_consumed: u64,
        amount: u64,
        house_subsidy: u64,
    }

    struct Position has store {
        contributions: vector<u64>,
        shares: vector<u64>,
        total: u64,
        claimed: bool,
    }

    struct CatalogSweptKey has copy, drop, store {
        holder: address,
        nonce: u64,
    }

    struct PredictionMarket has key {
        id: 0x2::object::UID,
        contract_schema_version: u16,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        participant_set_digest: vector<u8>,
        outcome_schema_version: u16,
        outcomes: vector<vector<u8>>,
        pools: vector<u64>,
        total_pool: u64,
        positions: 0x2::table::Table<address, Position>,
        status: u8,
        winning_outcome: 0x1::option::Option<u16>,
        product_manifest_digest: vector<u8>,
        protocol_id: vector<u8>,
        protocol_version: u16,
        expected_record_schema_version: u16,
        verification_policy_version: u16,
        claimed_total: u64,
        close_deadline_ms: u64,
        claim_window_ms: u64,
        resolved_at_ms: 0x1::option::Option<u64>,
        catalog_swept: 0x2::table::Table<CatalogSweptKey, bool>,
        liquidity: u64,
        module_version: u64,
        paused: bool,
    }

    struct AttestedProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AttestedMarketKey has copy, drop, store {
        execution_id: vector<u8>,
    }

    struct AttestedProfile has store {
        binding_digest: vector<u8>,
    }

    struct AttestedGatePermit has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketBinding has drop, store {
        tunnel_id: 0x2::object::ID,
        product_manifest_digest: vector<u8>,
        protocol_id: vector<u8>,
        protocol_version: u16,
        expected_record_schema_version: u16,
        verification_policy_version: u16,
        execution_id: vector<u8>,
        participant_set_digest: vector<u8>,
        outcome_schema_version: u16,
    }

    struct MarketAuthorityCap has key {
        id: 0x2::object::UID,
    }

    struct OutcomeAttestation has copy, drop {
        execution_id: vector<u8>,
        outcome_schema_version: u16,
        participant_set_digest: vector<u8>,
        disposition: u8,
        winning_participant_id: vector<u8>,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        execution_id: vector<u8>,
        participant_set_digest: vector<u8>,
        outcome_schema_version: u16,
        outcome_count: u64,
        close_deadline_ms: u64,
        claim_window_ms: u64,
    }

    struct MarketCreatedContractSchemaVersion has copy, drop {
        market_id: 0x2::object::ID,
        market_contract_schema_version: u16,
    }

    struct MarketParticipantOutcomes has copy, drop {
        market_id: 0x2::object::ID,
        outcomes: vector<vector<u8>>,
    }

    struct MarketTunnelBinding has copy, drop {
        market_id: 0x2::object::ID,
        tunnel_id: 0x2::object::ID,
    }

    struct MarketCatalogLiquidity has copy, drop {
        market_id: 0x2::object::ID,
        liquidity: u64,
    }

    struct PositionTaken has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        outcome_index: u16,
        amount: u64,
        outcome_pool: u64,
        total_pool: u64,
        shares: u64,
    }

    struct MarketModuleVersionMigrated has copy, drop {
        market_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct MarketPauseChanged has copy, drop {
        market_id: 0x2::object::ID,
        paused: bool,
    }

    struct MarketClosed has copy, drop {
        market_id: 0x2::object::ID,
        total_pool: u64,
        permissionless: bool,
    }

    struct MarketSettled has copy, drop {
        market_id: 0x2::object::ID,
        winning_outcome: u16,
        winning_pool: u64,
        total_pool: u64,
        verification_policy_version: u16,
        resolved_at_ms: u64,
    }

    struct MarketCancelled has copy, drop {
        market_id: 0x2::object::ID,
        total_pool: u64,
        disposition: u8,
        resolved_at_ms: u64,
    }

    struct MarketResolvedWithoutWinners has copy, drop {
        market_id: 0x2::object::ID,
        winning_outcome: u16,
        total_pool: u64,
    }

    struct MarketResolvedFromRecord has copy, drop {
        market_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        record_disposition: u8,
        record_outcome_schema_version: u16,
    }

    struct MarketCanonicalWinners has copy, drop {
        market_id: 0x2::object::ID,
        winner_count: u64,
        winning_participant_ids: vector<vector<u8>>,
    }

    struct PayoutClaimed has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        amount: u64,
        claimed_total: u64,
    }

    struct RefundClaimed has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        amount: u64,
        claimed_total: u64,
    }

    struct UnclaimedSwept has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    fun apply_cancellation(arg0: &mut PredictionMarket, arg1: u8, arg2: u64) {
        if (arg0.status == 3) {
            return
        };
        assert!(arg0.status != 2, 13906843399936016429);
        assert!(arg0.status == 0 || arg0.status == 1, 13906843438589804575);
        arg0.status = 3;
        arg0.resolved_at_ms = 0x1::option::some<u64>(arg2);
        let v0 = MarketCancelled{
            market_id      : 0x2::object::id<PredictionMarket>(arg0),
            total_pool     : arg0.total_pool,
            disposition    : arg1,
            resolved_at_ms : arg2,
        };
        0x2::event::emit<MarketCancelled>(v0);
    }

    fun arm_attested_gate(arg0: &mut PredictionMarket) {
        let v0 = AttestedGatePermit{dummy_field: false};
        0x2::dynamic_field::add<AttestedGatePermit, bool>(&mut arg0.id, v0, true);
    }

    fun assert_admitted_version(arg0: &PredictionMarket) {
        assert!(is_admitted_version(arg0), 13906837983985008727);
    }

    public(friend) fun assert_binding_names_this_market(arg0: &PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::PredictBindingV1) {
        let v0 = if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_market_object_id(arg1) == arg0.execution_id) {
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_market_local_id(arg1) == 0) {
                if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_window_id(arg1) == 0) {
                    0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_selection_revision(arg1) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906839044841668691);
    }

    fun assert_canonical_outcomes(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 >= 2 && v0 <= 256, 13906842734214381587);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v1)) == 32, 13906842751394250771);
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<vector<u8>>(arg0, v1) != 0x1::vector::borrow<vector<u8>>(arg0, v2), 13906842764279152659);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_not_attested(arg0: &mut PredictionMarket) {
        if (is_attested(arg0)) {
            let v0 = AttestedGatePermit{dummy_field: false};
            assert!(0x2::dynamic_field::exists_with_type<AttestedGatePermit, bool>(&arg0.id, v0), 13906843936809287761);
            0x2::dynamic_field::remove<AttestedGatePermit, bool>(&mut arg0.id, v0);
        };
    }

    public(friend) fun assert_open_for_positions(arg0: &PredictionMarket, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 13906840496536944667);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.close_deadline_ms, 13906840500832043037);
    }

    public(friend) fun assert_writable(arg0: &PredictionMarket) {
        assert_admitted_version(arg0);
        assert!(!arg0.paused, 13906838031229780057);
    }

    fun attested_binding_digest(arg0: &PredictionMarket) : vector<u8> {
        let v0 = AttestedProfileKey{dummy_field: false};
        0x2::dynamic_field::borrow<AttestedProfileKey, AttestedProfile>(&arg0.id, v0).binding_digest
    }

    public fun attested_market_for_execution(arg0: &MarketAuthorityCap, arg1: &vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = AttestedMarketKey{execution_id: *arg1};
        if (0x2::dynamic_field::exists_with_type<AttestedMarketKey, 0x2::object::ID>(&arg0.id, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<AttestedMarketKey, 0x2::object::ID>(&arg0.id, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun cancel_expired_market(arg0: &mut PredictionMarket, arg1: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert!(arg0.status == 1, 13906841123602432031);
        assert_not_attested(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.close_deadline_ms, 13906841166552367139);
        assert!(v0 - arg0.close_deadline_ms >= arg0.claim_window_ms, 13906841179437269027);
        apply_cancellation(arg0, 1, v0);
    }

    public fun cancel_expired_market_attested(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg2: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert!(is_attested(arg0), 13906841299699368017);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_cancelled(arg1, attested_binding_digest(arg0));
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.close_deadline_ms, 13906841312581255203);
        assert!(v0 - arg0.close_deadline_ms >= arg0.claim_window_ms, 13906841325466157091);
        apply_cancellation(arg0, 1, v0);
    }

    public fun cancel_market(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert_not_attested(arg0);
        apply_cancellation(arg0, 1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun cancel_market_attested(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: &0x2::clock::Clock, arg3: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore) {
        assert!(is_attested(arg0), 13906844160147587153);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_cancelled(arg3, attested_binding_digest(arg0));
        arm_attested_gate(arg0);
        cancel_market(arg0, arg1, arg2);
    }

    public(friend) fun catalog_sweep_message(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: &vector<address>, arg5: &vector<u16>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: &vector<u64>) : vector<u8> {
        let v0 = b"dopamint-arena::catalog::market-sweep::v2";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let v1 = 0x1::vector::length<address>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(0x1::vector::borrow<address>(arg4, v2)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(0x1::vector::borrow<u16>(arg5, v2)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg6, v2)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg7, v2)));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(0x1::vector::borrow<u64>(arg8, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun claim_payout(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0x2::tx_context::TxContext) {
        assert_admitted_version(arg0);
        assert!(arg0.status == 2, 13906841922467528753);
        settle_recorded_position(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun claim_refund(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0x2::tx_context::TxContext) {
        assert_admitted_version(arg0);
        assert!(arg0.status == 3, 13906842008367005747);
        settle_recorded_position(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun claim_window_ms(arg0: &PredictionMarket) : u64 {
        arg0.claim_window_ms
    }

    public fun claimed_total(arg0: &PredictionMarket) : u64 {
        arg0.claimed_total
    }

    public fun close_expired_market(arg0: &mut PredictionMarket, arg1: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        assert!(arg0.status == 0, 13906840891673935899);
        assert_not_attested(arg0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.close_deadline_ms, 13906840908854198305);
        arg0.status = 1;
        let v0 = MarketClosed{
            market_id      : 0x2::object::id<PredictionMarket>(arg0),
            total_pool     : arg0.total_pool,
            permissionless : true,
        };
        0x2::event::emit<MarketClosed>(v0);
    }

    public fun close_market(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        assert!(arg0.status == 0, 13906840780004786203);
        assert_not_attested(arg0);
        arg0.status = 1;
        let v0 = MarketClosed{
            market_id      : 0x2::object::id<PredictionMarket>(arg0),
            total_pool     : arg0.total_pool,
            permissionless : false,
        };
        0x2::event::emit<MarketClosed>(v0);
    }

    public fun close_market_attested(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: &0x2::clock::Clock, arg3: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg4: vector<u8>) {
        assert!(is_attested(arg0), 13906844108607979601);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg3, attested_binding_digest(arg0), arg4);
        arm_attested_gate(arg0);
        close_market(arg0, arg1, arg2);
    }

    public(friend) fun contribution_of(arg0: &PredictionMarket, arg1: address, arg2: u64) : u64 {
        assert!(arg2 < 0x1::vector::length<u64>(&arg0.pools), 13906844430727905321);
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        *0x1::vector::borrow<u64>(&0x2::table::borrow<address, Position>(&arg0.positions, arg1).contributions, arg2)
    }

    public fun create_market(arg0: &MarketAuthorityCap, arg1: MarketBinding, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PredictionMarket>(create_market_object(arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun create_market_attested(arg0: &mut MarketAuthorityCap, arg1: MarketBinding, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = create_market_object(arg1, arg2, arg3, arg4, arg5, arg8, arg9);
        let v1 = execution_id(&v0);
        let v2 = attested_market_for_execution(arg0, &v1);
        assert!(0x1::option::is_none<0x2::object::ID>(&v2), 13906838563805462613);
        let v3 = AttestedMarketKey{execution_id: v1};
        0x2::dynamic_field::add<AttestedMarketKey, 0x2::object::ID>(&mut arg0.id, v3, 0x2::object::id<PredictionMarket>(&v0));
        let v4 = AttestedProfileKey{dummy_field: false};
        let v5 = AttestedProfile{binding_digest: derive_catalog_binding_digest(&v0, arg7, arg6)};
        0x2::dynamic_field::add<AttestedProfileKey, AttestedProfile>(&mut v0.id, v4, v5);
        0x2::transfer::share_object<PredictionMarket>(v0);
    }

    fun create_market_object(arg0: MarketBinding, arg1: vector<vector<u8>>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : PredictionMarket {
        assert_canonical_outcomes(&arg1);
        let v0 = if (arg2 > 0x2::clock::timestamp_ms(arg5)) {
            if (arg3 >= 60000) {
                arg3 <= 2592000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906839130737213465);
        let v1 = 0x1::vector::length<vector<u8>>(&arg1);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = 0x2::object::new(arg6);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let MarketBinding {
            tunnel_id                      : v6,
            product_manifest_digest        : v7,
            protocol_id                    : v8,
            protocol_version               : v9,
            expected_record_schema_version : v10,
            verification_policy_version    : v11,
            execution_id                   : v12,
            participant_set_digest         : v13,
            outcome_schema_version         : v14,
        } = arg0;
        let v15 = MarketCreated{
            market_id              : v5,
            execution_id           : v12,
            participant_set_digest : v13,
            outcome_schema_version : v14,
            outcome_count          : v1,
            close_deadline_ms      : arg2,
            claim_window_ms        : arg3,
        };
        0x2::event::emit<MarketCreated>(v15);
        let v16 = MarketCreatedContractSchemaVersion{
            market_id                      : v5,
            market_contract_schema_version : 1,
        };
        0x2::event::emit<MarketCreatedContractSchemaVersion>(v16);
        let v17 = MarketParticipantOutcomes{
            market_id : v5,
            outcomes  : arg1,
        };
        0x2::event::emit<MarketParticipantOutcomes>(v17);
        let v18 = MarketTunnelBinding{
            market_id : v5,
            tunnel_id : v6,
        };
        0x2::event::emit<MarketTunnelBinding>(v18);
        let v19 = MarketCatalogLiquidity{
            market_id : v5,
            liquidity : arg4,
        };
        0x2::event::emit<MarketCatalogLiquidity>(v19);
        PredictionMarket{
            id                             : v4,
            contract_schema_version        : 1,
            tunnel_id                      : v6,
            execution_id                   : v12,
            participant_set_digest         : v13,
            outcome_schema_version         : v14,
            outcomes                       : arg1,
            pools                          : v2,
            total_pool                     : 0,
            positions                      : 0x2::table::new<address, Position>(arg6),
            status                         : 0,
            winning_outcome                : 0x1::option::none<u16>(),
            product_manifest_digest        : v7,
            protocol_id                    : v8,
            protocol_version               : v9,
            expected_record_schema_version : v10,
            verification_policy_version    : v11,
            claimed_total                  : 0,
            close_deadline_ms              : arg2,
            claim_window_ms                : arg3,
            resolved_at_ms                 : 0x1::option::none<u64>(),
            catalog_swept                  : 0x2::table::new<CatalogSweptKey, bool>(arg6),
            liquidity                      : arg4,
            module_version                 : 1,
            paused                         : false,
        }
    }

    public fun create_predict_profile_config(arg0: &MarketAuthorityCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::share_profile_config(arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun credit_position(arg0: &mut PredictionMarket, arg1: address, arg2: u16, arg3: u64, arg4: u64) {
        let v0 = (arg2 as u64);
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            let v1 = 0x1::vector::length<vector<u8>>(&arg0.outcomes);
            let v2 = vector[];
            let v3 = 0;
            while (v3 < v1) {
                0x1::vector::push_back<u64>(&mut v2, 0);
                v3 = v3 + 1;
            };
            let v4 = vector[];
            let v5 = 0;
            while (v5 < v1) {
                0x1::vector::push_back<u64>(&mut v4, 0);
                v5 = v5 + 1;
            };
            let v6 = Position{
                contributions : v2,
                shares        : v4,
                total         : 0,
                claimed       : false,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, arg1, v6);
        };
        let v7 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg1);
        let v8 = 0x1::vector::borrow_mut<u64>(&mut v7.contributions, v0);
        *v8 = *v8 + arg3;
        let v9 = 0x1::vector::borrow_mut<u64>(&mut v7.shares, v0);
        *v9 = *v9 + arg4;
        v7.total = v7.total + arg3;
        let v10 = 0x1::vector::borrow_mut<u64>(&mut arg0.pools, v0);
        *v10 = *v10 + arg3;
        arg0.total_pool = arg0.total_pool + arg3;
        let v11 = PositionTaken{
            market_id     : 0x2::object::id<PredictionMarket>(arg0),
            bettor        : arg1,
            outcome_index : arg2,
            amount        : arg3,
            outcome_pool  : *v10,
            total_pool    : arg0.total_pool,
            shares        : arg4,
        };
        0x2::event::emit<PositionTaken>(v11);
    }

    public fun current_module_version() : u64 {
        1
    }

    fun decode_match_winner(arg0: &vector<u8>) : (u64, vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) >= 3, 13906843515901706309);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 1, 13906843520196673605);
        let v0 = (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u64);
        assert!(v0 > 0, 13906843528786608197);
        assert!(0x1::vector::length<u8>(arg0) == 3 + v0 * 32, 13906843533081575493);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, 3 + v2));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun decode_match_winner_ids(arg0: &vector<u8>) : vector<vector<u8>> {
        let (v0, _) = decode_match_winner(arg0);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v0) {
            let v4 = b"";
            let v5 = 0;
            while (v5 < 32) {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, 3 + v3 * 32 + v5));
                v5 = v5 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v2, v4);
            v3 = v3 + 1;
        };
        v2
    }

    fun derive_catalog_binding_digest(arg0: &PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg2: vector<u8>) : vector<u8> {
        let v0 = 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::decode_binding(arg2);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::assert_deployment_identity(arg1, 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_chain_id(&v0), 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_environment_id(&v0), 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_package_id(&v0));
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_contract_kind(&v0) == 0, 13906838727014088787);
        assert!(0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_execution_id(&v0) == arg0.execution_id, 13906838744193957971);
        let v1 = if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_market_object_id(&v0) == arg0.execution_id) {
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_market_local_id(&v0) == 0) {
                if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_window_id(&v0) == 0) {
                    if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_selection_revision(&v0) == 0) {
                        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_reserve_id(&v0) != x"0000000000000000000000000000000000000000000000000000000000000000"
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906838933172518995);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::binding_digest(arg2)
    }

    public(friend) fun disposition_cancelled() : u8 {
        1
    }

    public(friend) fun disposition_resolved() : u8 {
        0
    }

    public(friend) fun disposition_tied() : u8 {
        2
    }

    fun emit_settled(arg0: &mut PredictionMarket, arg1: u16, arg2: u64, arg3: u64) {
        arg0.status = 2;
        arg0.resolved_at_ms = 0x1::option::some<u64>(arg3);
        let v0 = MarketSettled{
            market_id                   : 0x2::object::id<PredictionMarket>(arg0),
            winning_outcome             : arg1,
            winning_pool                : arg2,
            total_pool                  : arg0.total_pool,
            verification_policy_version : arg0.verification_policy_version,
            resolved_at_ms              : arg3,
        };
        0x2::event::emit<MarketSettled>(v0);
    }

    public fun execution_id(arg0: &PredictionMarket) : vector<u8> {
        arg0.execution_id
    }

    public(friend) fun expected_record_schema_version(arg0: &PredictionMarket) : u16 {
        arg0.expected_record_schema_version
    }

    public(friend) fun has_claimed(arg0: &PredictionMarket, arg1: address) : bool {
        0x2::table::contains<address, Position>(&arg0.positions, arg1) && 0x2::table::borrow<address, Position>(&arg0.positions, arg1).claimed
    }

    fun house_settlement(arg0: &PredictionMarket) : HouseSettlement {
        let v0 = HouseSettlementKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<HouseSettlementKey, HouseSettlement>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<HouseSettlementKey, HouseSettlement>(&arg0.id, v0)
        } else {
            HouseSettlement{consumed: 0, paid: 0}
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAuthorityCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketAuthorityCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_admitted_version(arg0: &PredictionMarket) : bool {
        version_is_admitted(1, arg0.module_version)
    }

    public(friend) fun is_attested(arg0: &PredictionMarket) : bool {
        let v0 = AttestedProfileKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<AttestedProfileKey, AttestedProfile>(&arg0.id, v0)
    }

    public fun liquidity(arg0: &PredictionMarket) : u64 {
        arg0.liquidity
    }

    public fun migrate_version(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap) {
        if (arg0.module_version == 1) {
            return
        };
        assert!(arg0.module_version + 1 == 1, 13906838112834027607);
        arg0.module_version = 1;
        let v0 = MarketModuleVersionMigrated{
            market_id    : 0x2::object::id<PredictionMarket>(arg0),
            from_version : arg0.module_version,
            to_version   : 1,
        };
        0x2::event::emit<MarketModuleVersionMigrated>(v0);
    }

    public fun module_version(arg0: &PredictionMarket) : u64 {
        arg0.module_version
    }

    public fun new_market_binding(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u16, arg4: u16, arg5: u16, arg6: vector<u8>, arg7: vector<u8>, arg8: u16) : MarketBinding {
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906836961778073615);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 13906836966073171985);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906836970368532503);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906836974663499799);
        assert!(arg8 > 0, 13906836978958336021);
        MarketBinding{
            tunnel_id                      : arg0,
            product_manifest_digest        : arg1,
            protocol_id                    : arg2,
            protocol_version               : arg3,
            expected_record_schema_version : arg4,
            verification_policy_version    : arg5,
            execution_id                   : arg6,
            participant_set_digest         : arg7,
            outcome_schema_version         : arg8,
        }
    }

    public fun outcome_count(arg0: &PredictionMarket) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.outcomes)
    }

    fun outcome_index_of(arg0: &PredictionMarket, arg1: &vector<u8>) : u16 {
        let v0 = &arg0.outcomes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            if (0x1::vector::borrow<vector<u8>>(v0, v1) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13906843649043857449);
                return (*0x1::option::borrow<u64>(&v2) as u16)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun paused(arg0: &PredictionMarket) : bool {
        arg0.paused
    }

    public fun pin_settlement_cap(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: u64) {
        assert_admitted_version(arg0);
        assert!(is_attested(arg0), 13906836098493972561);
        assert!(arg2 > 0, 13906836102786056229);
        let v0 = SettlementCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SettlementCapKey, u64>(&arg0.id, v0)) {
            assert!(*0x2::dynamic_field::borrow<SettlementCapKey, u64>(&arg0.id, v0) == arg2, 13906836124264562781);
            return
        };
        0x2::dynamic_field::add<SettlementCapKey, u64>(&mut arg0.id, v0, arg2);
    }

    public fun pinned_settlement_cap(arg0: &PredictionMarket) : 0x1::option::Option<u64> {
        let v0 = SettlementCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SettlementCapKey, u64>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<SettlementCapKey, u64>(&arg0.id, v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun pool_of(arg0: &PredictionMarket, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<u64>(&arg0.pools), 13906844254634246185);
        *0x1::vector::borrow<u64>(&arg0.pools, arg1)
    }

    public(friend) fun position_total_of(arg0: &PredictionMarket, arg1: address) : u64 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Position>(&arg0.positions, arg1).total
    }

    fun prepare_verified_resolution(arg0: &mut PredictionMarket, arg1: OutcomeAttestation, arg2: u64) : (bool, u16, u64) {
        let v0 = if (arg1.execution_id == arg0.execution_id) {
            if (arg1.participant_set_digest == arg0.participant_set_digest) {
                arg1.outcome_schema_version == arg0.outcome_schema_version
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906842863064973355);
        let v1 = if (arg1.disposition == 0) {
            true
        } else if (arg1.disposition == 1) {
            true
        } else {
            arg1.disposition == 2
        };
        assert!(v1, 13906842901719941167);
        if (arg1.disposition == 1 || arg1.disposition == 2) {
            apply_cancellation(arg0, arg1.disposition, arg2);
            return (false, 0, 0)
        };
        let v2 = outcome_index_of(arg0, &arg1.winning_participant_id);
        if (arg0.status == 2 || arg0.status == 3) {
            assert!(0x1::option::contains<u16>(&arg0.winning_outcome, &v2), 13906842996209090605);
            return (false, 0, 0)
        };
        assert!(arg0.status == 1, 13906843017683009567);
        arg0.winning_outcome = 0x1::option::some<u16>(v2);
        (true, v2, *0x1::vector::borrow<u64>(&arg0.pools, (v2 as u64)))
    }

    public fun product_manifest_digest(arg0: &PredictionMarket) : vector<u8> {
        arg0.product_manifest_digest
    }

    public fun protocol_id(arg0: &PredictionMarket) : vector<u8> {
        arg0.protocol_id
    }

    public fun protocol_version(arg0: &PredictionMarket) : u16 {
        arg0.protocol_version
    }

    public(friend) fun reserve_settlement_message(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u8, arg4: &vector<address>) : vector<u8> {
        let v0 = b"dopamint-arena::catalog::reserve-settlement::v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg3));
        let v1 = 0x1::vector::length<address>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v1));
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(0x1::vector::borrow<address>(arg4, v2)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun resolve_from_record(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg3: &0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::SettledOutcomeRecord, arg4: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert!(arg0.status != 0, 13906841488674652191);
        assert_not_attested(arg0);
        assert!(0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_product_manifest_digest(arg3) == arg0.product_manifest_digest, 13906841510152110151);
        let v0 = if (0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_schema_version(arg3) == arg0.expected_record_schema_version) {
            if (0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_protocol_version(arg3) == arg0.protocol_version) {
                if (0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_protocol_id(arg3) == arg0.protocol_id) {
                    0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_verification_policy_version(arg3) == arg0.verification_policy_version
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906841540217012297);
        let v1 = 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_execution_id(arg3);
        let v2 = 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_participant_set_digest(arg3);
        assert!(v1 == arg0.execution_id && v2 == arg0.participant_set_digest, 13906841570281914443);
        assert!(0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_tunnel_id(arg3) == arg0.tunnel_id, 13906841596051849293);
        let v3 = 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_outcome_schema_version(arg3);
        let v4 = arg0.status;
        let v5 = vector[];
        if (v3 == 0) {
            apply_cancellation(arg0, 1, 0x2::clock::timestamp_ms(arg4));
        } else {
            assert!(v3 == arg0.outcome_schema_version, 13906841647591587919);
            let v6 = 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_outcome(arg3);
            let (v7, v8) = decode_match_winner(&v6);
            v5 = decode_match_winner_ids(&v6);
            if (v7 == 1) {
                let v9 = OutcomeAttestation{
                    execution_id           : v1,
                    outcome_schema_version : v3,
                    participant_set_digest : v2,
                    disposition            : 0,
                    winning_participant_id : v8,
                };
                resolve_verified(arg0, arg1, arg2, v9, 0x2::clock::timestamp_ms(arg4));
            } else {
                apply_cancellation(arg0, 2, 0x2::clock::timestamp_ms(arg4));
            };
        };
        if (arg0.status != v4 || v4 == 3) {
            let v10 = MarketResolvedFromRecord{
                market_id                     : 0x2::object::id<PredictionMarket>(arg0),
                record_id                     : 0x2::object::id<0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::SettledOutcomeRecord>(arg3),
                record_disposition            : 0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::record_disposition(arg3),
                record_outcome_schema_version : v3,
            };
            0x2::event::emit<MarketResolvedFromRecord>(v10);
            if (!0x1::vector::is_empty<vector<u8>>(&v5)) {
                let v11 = MarketCanonicalWinners{
                    market_id               : 0x2::object::id<PredictionMarket>(arg0),
                    winner_count            : 0x1::vector::length<vector<u8>>(&v5),
                    winning_participant_ids : v5,
                };
                0x2::event::emit<MarketCanonicalWinners>(v11);
            };
        };
    }

    public fun resolve_from_record_attested(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg3: &0x27a0e0a46f31fb502bcebdcc2df7e08ce43e2fd1e79dede166a41b81530f5bf8::anchor::SettledOutcomeRecord, arg4: &0x2::clock::Clock, arg5: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg6: vector<u8>) {
        assert!(is_attested(arg0), 13906844224572096593);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg5, attested_binding_digest(arg0), arg6);
        arm_attested_gate(arg0);
        resolve_from_record(arg0, arg1, arg2, arg3, arg4);
    }

    fun resolve_verified(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg3: OutcomeAttestation, arg4: u64) {
        let (v0, v1, v2) = prepare_verified_resolution(arg0, arg3, arg4);
        if (!v0) {
            return
        };
        if (v2 == 0) {
            arg0.claimed_total = arg0.total_pool;
            if (arg0.total_pool > 0 && !is_attested(arg0)) {
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::burn_from_escrow(arg1, arg2, 0x2::object::id<PredictionMarket>(arg0), arg0.total_pool);
            };
            emit_settled(arg0, v1, v2, arg4);
            let v3 = MarketResolvedWithoutWinners{
                market_id       : 0x2::object::id<PredictionMarket>(arg0),
                winning_outcome : v1,
                total_pool      : arg0.total_pool,
            };
            0x2::event::emit<MarketResolvedWithoutWinners>(v3);
            return
        };
        emit_settled(arg0, v1, v2, arg4);
    }

    public fun resolved_at_ms(arg0: &PredictionMarket) : 0x1::option::Option<u64> {
        arg0.resolved_at_ms
    }

    public fun seed_liquidity(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg5: address, arg6: u64, arg7: u64) {
        assert_writable(arg0);
        assert!(arg0.status == 0, 13906839886651588635);
        assert_not_attested(arg0);
        assert!(arg6 > 0, 13906839895242178597);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::issue_into_escrow(arg4, arg1, arg2, arg3, 0x2::object::id<PredictionMarket>(arg0), arg5, arg6, arg7);
        arg0.total_pool = arg0.total_pool + arg6;
    }

    public fun seed_position(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinIssuerCap, arg5: address, arg6: u16, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert_open_for_positions(arg0, arg9);
        assert!(arg7 > 0, 13906839762098192421);
        assert!((arg6 as u64) < 0x1::vector::length<vector<u8>>(&arg0.outcomes), 13906839770688389161);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::issue_into_escrow(arg4, arg1, arg2, arg3, 0x2::object::id<PredictionMarket>(arg0), arg5, arg7, arg8);
        credit_position(arg0, arg5, arg6, arg7, arg7);
    }

    fun set_house_settlement(arg0: &mut PredictionMarket, arg1: HouseSettlement) {
        let v0 = HouseSettlementKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<HouseSettlementKey, HouseSettlement>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<HouseSettlementKey, HouseSettlement>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<HouseSettlementKey, HouseSettlement>(&mut arg0.id, v0, arg1);
        };
    }

    public fun set_paused(arg0: &mut PredictionMarket, arg1: &MarketAuthorityCap, arg2: bool) {
        assert_admitted_version(arg0);
        if (arg0.paused == arg2) {
            return
        };
        arg0.paused = arg2;
        let v0 = MarketPauseChanged{
            market_id : 0x2::object::id<PredictionMarket>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<MarketPauseChanged>(v0);
    }

    public fun set_profile_chain_id(arg0: &MarketAuthorityCap, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::PredictProfileConfig, arg2: vector<u8>) {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::ownership::set_chain_identity(arg1, arg2);
    }

    public fun settle_position(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: address) {
        assert_admitted_version(arg0);
        settle_recorded_position(arg0, arg1, arg2, arg3, arg4);
    }

    fun settle_recorded_position(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: address) {
        assert!(arg0.status == 2 || arg0.status == 3, 13906842205936025659);
        assert_not_attested(arg0);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, arg4), 13906842248885305397);
        let v0 = arg0.status == 2;
        let v1 = if (v0) {
            (*0x1::option::borrow<u16>(&arg0.winning_outcome) as u64)
        } else {
            0
        };
        let v2 = if (v0) {
            *0x1::vector::borrow<u64>(&arg0.pools, v1)
        } else {
            0
        };
        if (v0) {
            assert!(v2 > 0, 13906842291835895875);
        };
        let v3 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg4);
        assert!(!v3.claimed, 13906842309015109689);
        v3.claimed = true;
        let v4 = if (v0) {
            *0x1::vector::borrow<u64>(&v3.shares, v1)
        } else {
            v3.total
        };
        assert!(arg0.claimed_total + v4 <= arg0.total_pool, 13906842369145176129);
        arg0.claimed_total = arg0.claimed_total + v4;
        if (v4 > 0) {
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg1, arg2, arg3, 0x2::object::id<PredictionMarket>(arg0), arg4, v4);
        };
        if (v0) {
            let v5 = PayoutClaimed{
                market_id     : 0x2::object::id<PredictionMarket>(arg0),
                bettor        : arg4,
                amount        : v4,
                claimed_total : arg0.claimed_total,
            };
            0x2::event::emit<PayoutClaimed>(v5);
        } else {
            let v6 = RefundClaimed{
                market_id     : 0x2::object::id<PredictionMarket>(arg0),
                bettor        : arg4,
                amount        : v4,
                claimed_total : arg0.claimed_total,
            };
            0x2::event::emit<RefundClaimed>(v6);
        };
    }

    public fun settle_reserve_positions(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::ExecutionReserve, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg5: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg6: vector<address>, arg7: u64, arg8: 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::RuntimeAuth, arg9: vector<u8>) {
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::terminal_gate::require_endorsement(arg5, attested_binding_digest(arg0), arg9);
        let v0 = 0x2::object::id<PredictionMarket>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = reserve_settlement_message(&arg0.execution_id, &v1, arg7, arg0.status, &arg6);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::verify_admitted_auth(arg5, arg0.execution_id, &v2, &arg8);
        settle_reserve_positions_inner(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    fun settle_reserve_positions_inner(arg0: &mut PredictionMarket, arg1: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::ExecutionReserve, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg4: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg5: vector<address>) {
        assert_admitted_version(arg0);
        assert!(is_attested(arg0), 13906835647522406481);
        assert!(arg0.status == 2 || arg0.status == 3, 13906835660405866555);
        let v0 = arg0.status == 2;
        let v1 = if (v0) {
            (*0x1::option::borrow<u16>(&arg0.winning_outcome) as u64)
        } else {
            0
        };
        let v2 = 0x2::object::id<0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::ExecutionReserve>(arg1);
        let v3 = house_settlement(arg0);
        let v4 = v3.consumed;
        let v5 = v3.paid;
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg5)) {
            let v7 = *0x1::vector::borrow<address>(&arg5, v6);
            v6 = v6 + 1;
            if (!0x2::table::contains<address, Position>(&arg0.positions, v7)) {
                continue
            };
            let v8 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v7);
            if (v8.claimed) {
                continue
            };
            let v9 = v8.total;
            let v10 = if (v0) {
                *0x1::vector::borrow<u64>(&v8.shares, v1)
            } else {
                v9
            };
            let v11 = v9 > 0 && !0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::holds_contribution(arg1, v7, v9);
            if (!v11 && v9 > 0) {
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::debit_contribution(arg1, v7, v9);
                v4 = v4 + v9;
            };
            let v12 = if (v11) {
                0
            } else {
                v9
            };
            let v13 = if (v10 > v12) {
                v10 - v12
            } else {
                0
            };
            let v14 = v5 + v10;
            v5 = v14;
            assert!(v14 <= v4 + settlement_cap_of(arg0), 13906835849386524763);
            v8.claimed = true;
            arg0.claimed_total = arg0.claimed_total + v10;
            if (v10 > 0) {
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::release_to_holder(arg2, arg3, arg4, v2, v7, v10);
            };
            let v15 = if (v11) {
                0
            } else {
                v9
            };
            let v16 = ReservePositionSettled{
                market_id      : 0x2::object::id<PredictionMarket>(arg0),
                holder         : v7,
                stake_consumed : v15,
                amount         : v10,
                house_subsidy  : v13,
            };
            0x2::event::emit<ReservePositionSettled>(v16);
        };
        let v17 = HouseSettlement{
            consumed : v4,
            paid     : v5,
        };
        set_house_settlement(arg0, v17);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::assert_backed(arg1, 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_account_balance(arg4, v2));
    }

    fun settlement_cap_of(arg0: &PredictionMarket) : u64 {
        let v0 = SettlementCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SettlementCapKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<SettlementCapKey, u64>(&arg0.id, v0)
        } else {
            arg0.liquidity
        }
    }

    public(friend) fun shares_of(arg0: &PredictionMarket, arg1: address, arg2: u64) : u64 {
        assert!(arg2 < 0x1::vector::length<u64>(&arg0.pools), 13906844477972545577);
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        *0x1::vector::borrow<u64>(&0x2::table::borrow<address, Position>(&arg0.positions, arg1).shares, arg2)
    }

    public fun status(arg0: &PredictionMarket) : u8 {
        arg0.status
    }

    public(friend) fun status_cancelled() : u8 {
        3
    }

    public(friend) fun status_closed() : u8 {
        1
    }

    public(friend) fun status_open() : u8 {
        0
    }

    public(friend) fun status_settled() : u8 {
        2
    }

    public fun sweep_positions(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::frontier_commitment::FrontierCommitmentStore, arg6: vector<address>, arg7: vector<u16>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::RuntimeAuth, arg13: &0x2::clock::Clock) {
        assert_writable(arg0);
        assert_open_for_positions(arg0, arg13);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg6)) {
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, *0x1::vector::borrow<address>(&arg6, v0));
            v0 = v0 + 1;
        };
        assert_open_for_positions(arg0, arg13);
        let v1 = if (0x1::vector::length<address>(&arg6) == 0x1::vector::length<u64>(&arg8)) {
            if (0x1::vector::length<address>(&arg6) == 0x1::vector::length<u16>(&arg7)) {
                if (0x1::vector::length<address>(&arg6) == 0x1::vector::length<u64>(&arg10)) {
                    0x1::vector::length<address>(&arg6) == 0x1::vector::length<u64>(&arg9)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906840058451066919);
        let v2 = 0x2::object::id<PredictionMarket>(arg0);
        let v3 = 0x2::object::id_to_bytes(&v2);
        let v4 = catalog_sweep_message(&arg0.execution_id, &v3, 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::runtime_generation(&arg12), arg11, &arg6, &arg7, &arg8, &arg9, &arg10);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::reserve::verify_admitted_auth(arg5, arg0.execution_id, &v4, &arg12);
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg6)) {
            let v6 = *0x1::vector::borrow<address>(&arg6, v5);
            let v7 = *0x1::vector::borrow<u16>(&arg7, v5);
            let v8 = *0x1::vector::borrow<u64>(&arg8, v5);
            let v9 = *0x1::vector::borrow<u64>(&arg9, v5);
            let v10 = *0x1::vector::borrow<u64>(&arg10, v5);
            v5 = v5 + 1;
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::is_enrolled(arg1, v6)) {
                0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, v6);
            };
            if (v8 == 0 || v8 > arg11) {
                continue
            };
            if ((v7 as u64) >= 0x1::vector::length<vector<u8>>(&arg0.outcomes)) {
                continue
            };
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::is_excluded(arg4, v6)) {
                continue
            };
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::holder_shard_index(v6) != (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::shard_index(arg2) as u64)) {
                continue
            };
            if (0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::balance_of(arg2, v6) < v8) {
                continue
            };
            let v11 = CatalogSweptKey{
                holder : v6,
                nonce  : v10,
            };
            if (0x2::table::contains<CatalogSweptKey, bool>(&arg0.catalog_swept, v11)) {
                continue
            };
            0x2::table::add<CatalogSweptKey, bool>(&mut arg0.catalog_swept, v11, true);
            0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_contribution(arg1, arg2, arg3, arg4, v2, v6, v8);
            credit_position(arg0, v6, v7, v8, v9);
        };
    }

    public fun sweep_unclaimed(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg3: &0x2::clock::Clock) {
        assert_admitted_version(arg0);
        assert!(arg0.status == 2 || arg0.status == 3, 13906842592483082299);
        assert!(0x2::clock::timestamp_ms(arg3) >= *0x1::option::borrow<u64>(&arg0.resolved_at_ms) + arg0.claim_window_ms, 13906842635432886333);
        let v0 = arg0.total_pool - arg0.claimed_total;
        assert!(v0 > 0, 13906842648317919295);
        arg0.claimed_total = arg0.total_pool;
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::burn_from_escrow(arg1, arg2, 0x2::object::id<PredictionMarket>(arg0), v0);
        let v1 = UnclaimedSwept{
            market_id : 0x2::object::id<PredictionMarket>(arg0),
            amount    : v0,
        };
        0x2::event::emit<UnclaimedSwept>(v1);
    }

    public(friend) fun take_position(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: u16, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_writable(arg0);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, 0x2::tx_context::sender(arg8));
        assert_open_for_positions(arg0, arg7);
        assert!(arg6 > 0, 13906839525874991141);
        assert!((arg5 as u64) < 0x1::vector::length<vector<u8>>(&arg0.outcomes), 13906839534465187881);
        let v0 = 0x2::tx_context::sender(arg8);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_contribution(arg1, arg2, arg3, arg4, 0x2::object::id<PredictionMarket>(arg0), v0, arg6);
        credit_position(arg0, v0, arg5, arg6, arg6);
    }

    public(friend) fun take_quoted_position(arg0: &mut PredictionMarket, arg1: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinLedger, arg2: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinShard, arg3: &mut 0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::PlayCoinEscrowBook, arg4: &0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::eligibility::EligibilityRegistry, arg5: u16, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_writable(arg0);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::assert_not_enrolled(arg1, 0x2::tx_context::sender(arg9));
        assert_open_for_positions(arg0, arg8);
        assert!(arg6 > 0, 13906839641839108133);
        assert!((arg5 as u64) < 0x1::vector::length<vector<u8>>(&arg0.outcomes), 13906839650429304873);
        let v0 = 0x2::tx_context::sender(arg9);
        0xf412d3a6c89c0b2c5aa49dd7edc006c9930f7cde25e667de37aa8688c26afa6::play_coin::escrow_contribution(arg1, arg2, arg3, arg4, 0x2::object::id<PredictionMarket>(arg0), v0, arg6);
        credit_position(arg0, v0, arg5, arg6, arg7);
    }

    public fun total_pool(arg0: &PredictionMarket) : u64 {
        arg0.total_pool
    }

    public fun transfer_market_authority_cap(arg0: MarketAuthorityCap, arg1: address) {
        assert!(arg1 != @0x0, 13906837859428859959);
        0x2::transfer::transfer<MarketAuthorityCap>(arg0, arg1);
    }

    public fun tunnel_id(arg0: &PredictionMarket) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public fun verification_policy_version(arg0: &PredictionMarket) : u16 {
        arg0.verification_policy_version
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 == arg0 || arg0 > 1 && arg1 == arg0 - 1
    }

    public fun winning_outcome(arg0: &PredictionMarket) : 0x1::option::Option<u16> {
        arg0.winning_outcome
    }

    // decompiled from Move bytecode v7
}

