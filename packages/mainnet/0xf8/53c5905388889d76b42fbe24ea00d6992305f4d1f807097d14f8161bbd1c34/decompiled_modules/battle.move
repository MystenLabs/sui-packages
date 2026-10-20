module 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::battle {
    struct Challenge<phantom T0> has key {
        id: 0x2::object::UID,
        attacker_lead_account_id: 0x2::object::ID,
        attacker_owner: address,
        attacker_character_ids: vector<0x2::object::ID>,
        attacker_is_house: bool,
        attacker_strategy_hash: vector<u8>,
        defender_lead_account_id: 0x2::object::ID,
        defender_owner: address,
        defender_character_ids: vector<0x2::object::ID>,
        defender_is_house: bool,
        defender_strategy_hash: vector<u8>,
        ruleset_hash: vector<u8>,
        seed: vector<u8>,
        fee_paid: u64,
        epoch: u64,
        created_at_ms: u64,
        settle_by_ms: u64,
    }

    struct MatchTicket has copy, drop {
        domain: vector<u8>,
        arena_id: 0x2::object::ID,
        attacker_lead_account_id: 0x2::object::ID,
        attacker_challenge_seq: u64,
        defender_lead_account_id: 0x2::object::ID,
        expires_at_ms: u64,
    }

    struct Settlement<phantom T0> {
        challenge_id: 0x2::object::ID,
        outcome: u8,
        attacker_points: u64,
        defender_points: u64,
        pending_attackers: vector<0x2::object::ID>,
        pending_defenders: vector<0x2::object::ID>,
    }

    struct ChallengeCreated has copy, drop {
        challenge_id: 0x2::object::ID,
        attacker_lead_account_id: 0x2::object::ID,
        attacker_owner: address,
        attacker_character_ids: vector<0x2::object::ID>,
        attacker_strategy_hash: vector<u8>,
        defender_lead_account_id: 0x2::object::ID,
        defender_owner: address,
        defender_character_ids: vector<0x2::object::ID>,
        defender_is_house: bool,
        defender_strategy_hash: vector<u8>,
        ruleset_hash: vector<u8>,
        seed: vector<u8>,
        fee_paid: u64,
        epoch: u64,
        created_at_ms: u64,
        settle_by_ms: u64,
    }

    struct ChallengeSettled has copy, drop {
        challenge_id: 0x2::object::ID,
        verifier_cap_id: 0x2::object::ID,
        outcome: u8,
        attacker_owner: address,
        defender_owner: address,
        attacker_points: u64,
        defender_points: u64,
        attacker_fuel: u8,
        defender_fuel: u8,
        replay_blob_id: vector<u8>,
        replay_digest: vector<u8>,
        challenge_epoch: u64,
        points_epoch: u64,
        settled_at_ms: u64,
    }

    struct ChallengeExpired has copy, drop {
        challenge_id: 0x2::object::ID,
        epoch: u64,
    }

    public fun apply_result<T0>(arg0: &mut Settlement<T0>, arg1: &mut 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::CharacterRecord<T0>) {
        let v0 = 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::record_character_id<T0>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.pending_attackers, &v0);
        if (v1) {
            0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.pending_attackers, v2);
            0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::record_attack<T0>(arg1, arg0.challenge_id, arg0.outcome, arg0.attacker_points);
            return
        };
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(&arg0.pending_defenders, &v0);
        assert!(v3, 13906835591683964950);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.pending_defenders, v4);
        0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::record_defense<T0>(arg1, arg0.challenge_id, arg0.outcome, arg0.defender_points);
    }

    fun assert_opponents(arg0: address, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID) {
        assert!(arg0 != arg2 && arg1 != arg3, 13906836420611997708);
    }

    fun assert_outcome(arg0: u8, arg1: u8, arg2: u8) {
        assert!(arg0 == 0 && arg1 > arg2 || arg0 == 1 && arg1 == arg2 || arg0 == 2 && arg1 < arg2 || arg0 == 3, 13906836695490035726);
    }

    public fun attacker_character_ids<T0>(arg0: &Challenge<T0>) : vector<0x2::object::ID> {
        arg0.attacker_character_ids
    }

    public fun attacker_owner<T0>(arg0: &Challenge<T0>) : address {
        arg0.attacker_owner
    }

    fun authorize<T0>(arg0: &0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::Arena<T0>, arg1: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg2: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg4: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>, arg5: &0x2::kiosk::Kiosk, arg6: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>, arg7: &0x2::kiosk::Kiosk, arg8: &vector<u8>, arg9: u64, arg10: u64, arg11: &vector<u8>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) : (0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::ChallengeAuth, 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::DefenseLineup) {
        assert!(0x1::vector::length<u8>(arg8) == 32, 13906836210158469130);
        0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::assert_accepting_challenges<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        assert!(v0 < arg10 && arg10 - v0 <= 3600000, 13906836231634354202);
        if (arg12) {
            let v1 = ticket_message(0x2::object::id<0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::Arena<T0>>(arg0), 0x2::object::id<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>>(arg4), 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::challenge_seq<T0>(arg4), 0x2::object::id<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>>(arg6), arg10);
            0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::assert_ticket<T0>(arg0, &v1, arg11);
        };
        let v2 = 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::authorize_challenge<T0>(arg4, arg1, arg5, arg3, arg2, arg9, arg13, arg14);
        let v3 = 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::defense_lineup<T0>(arg6, arg7);
        assert_opponents(0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_owner(&v2), 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_kiosk_id(&v2), 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_owner(&v3), 0x2::object::id<0x2::kiosk::Kiosk>(arg7));
        (v2, v3)
    }

    entry fun challenge<T0>(arg0: &0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::Arena<T0>, arg1: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentRegistry, arg2: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg4: &mut 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>, arg5: &0x2::kiosk::Kiosk, arg6: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::AgentAccount<T0>, arg7: &0x2::kiosk::Kiosk, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &0x2::random::Random, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = authorize<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, arg9, arg10, &arg11, true, arg13, arg14);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::random::new_generator(arg12, arg14);
        share_challenge<T0>(new_challenge<T0>(arg0, &v3, &v2, arg8, 0x2::random::generate_bytes(&mut v4, 32), arg13, arg14));
    }

    public fun defender_character_ids<T0>(arg0: &Challenge<T0>) : vector<0x2::object::ID> {
        arg0.defender_character_ids
    }

    public fun defender_owner<T0>(arg0: &Challenge<T0>) : address {
        arg0.defender_owner
    }

    public fun expire<T0>(arg0: Challenge<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.settle_by_ms, 13906835802137231380);
        let Challenge {
            id                       : v0,
            attacker_lead_account_id : _,
            attacker_owner           : _,
            attacker_character_ids   : _,
            attacker_is_house        : _,
            attacker_strategy_hash   : _,
            defender_lead_account_id : _,
            defender_owner           : _,
            defender_character_ids   : _,
            defender_is_house        : _,
            defender_strategy_hash   : _,
            ruleset_hash             : _,
            seed                     : _,
            fee_paid                 : _,
            epoch                    : v14,
            created_at_ms            : _,
            settle_by_ms             : _,
        } = arg0;
        let v17 = v0;
        let v18 = ChallengeExpired{
            challenge_id : 0x2::object::uid_to_inner(&v17),
            epoch        : v14,
        };
        0x2::event::emit<ChallengeExpired>(v18);
        0x2::object::delete(v17);
    }

    public fun finish<T0>(arg0: Settlement<T0>) {
        assert!(settlement_pending<T0>(&arg0) == 0, 13906835763482787864);
        let Settlement {
            challenge_id      : _,
            outcome           : _,
            attacker_points   : _,
            defender_points   : _,
            pending_attackers : _,
            pending_defenders : _,
        } = arg0;
    }

    public fun max_ticket_ttl_ms() : u64 {
        3600000
    }

    fun new_challenge<T0>(arg0: &0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::Arena<T0>, arg1: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::ChallengeAuth, arg2: &0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::DefenseLineup, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Challenge<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        Challenge<T0>{
            id                       : 0x2::object::new(arg6),
            attacker_lead_account_id : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_lead_account_id(arg1),
            attacker_owner           : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_owner(arg1),
            attacker_character_ids   : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_character_ids(arg1),
            attacker_is_house        : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_is_house(arg1),
            attacker_strategy_hash   : arg3,
            defender_lead_account_id : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_lead_account_id(arg2),
            defender_owner           : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_owner(arg2),
            defender_character_ids   : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_character_ids(arg2),
            defender_is_house        : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_is_house(arg2),
            defender_strategy_hash   : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::lineup_strategy_hash(arg2),
            ruleset_hash             : 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::ruleset_hash<T0>(arg0),
            seed                     : arg4,
            fee_paid                 : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_fee_paid(arg1),
            epoch                    : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account::auth_epoch(arg1),
            created_at_ms            : v0,
            settle_by_ms             : v0 + 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::settle_window_ms<T0>(arg0),
        }
    }

    public fun open_record_and_apply_result<T0>(arg0: &mut Settlement<T0>, arg1: &mut 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::RecordsRegistry, arg2: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.pending_attackers, &arg2) || 0x1::vector::contains<0x2::object::ID>(&arg0.pending_defenders, &arg2), 13906835711943049238);
        let v0 = 0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::new_record<T0>(arg1, arg2);
        let v1 = &mut v0;
        apply_result<T0>(arg0, v1);
        0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::share_record<T0>(v0);
        0x2::object::id<0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::CharacterRecord<T0>>(&v0)
    }

    public fun outcome_attacker_win() : u8 {
        0
    }

    public fun outcome_defender_win() : u8 {
        2
    }

    public fun outcome_draw() : u8 {
        1
    }

    public fun outcome_void() : u8 {
        3
    }

    fun points_for<T0>(arg0: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg1: u8, arg2: bool, arg3: bool) : (u64, u64) {
        if (arg1 == 3) {
            return (0, 0)
        };
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::points<T0>(arg0);
        let v1 = if (arg1 == 0) {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::win(&v0)
        } else if (arg1 == 1) {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::draw(&v0)
        } else {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::loss(&v0)
        };
        let v2 = if (arg2) {
            0
        } else if (arg3) {
            0x1::u64::mul_div(v1, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::house_bps(&v0), 10000)
        } else {
            v1
        };
        let v3 = if (arg3 || arg1 != 2) {
            0
        } else {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::defense(&v0)
        };
        (v2, v3)
    }

    public fun seed<T0>(arg0: &Challenge<T0>) : vector<u8> {
        arg0.seed
    }

    public fun settle<T0>(arg0: Challenge<T0>, arg1: &0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::Arena<T0>, arg2: &0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::VerifierCap, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: u8, arg5: u8, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) : Settlement<T0> {
        0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::assert_verifier<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(v0 <= arg0.settle_by_ms, 13906835273856122898);
        assert_outcome(arg4, arg5, arg6);
        assert!(0x1::vector::length<u8>(&arg7) == 32 && 0x1::vector::length<u8>(&arg8) == 32, 13906835291035861008);
        let (v1, v2) = points_for<T0>(arg3, arg4, arg0.attacker_is_house, arg0.defender_is_house);
        let Challenge {
            id                       : v3,
            attacker_lead_account_id : _,
            attacker_owner           : v5,
            attacker_character_ids   : v6,
            attacker_is_house        : _,
            attacker_strategy_hash   : _,
            defender_lead_account_id : _,
            defender_owner           : v10,
            defender_character_ids   : v11,
            defender_is_house        : _,
            defender_strategy_hash   : _,
            ruleset_hash             : _,
            seed                     : _,
            fee_paid                 : _,
            epoch                    : v17,
            created_at_ms            : _,
            settle_by_ms             : _,
        } = arg0;
        let v20 = v3;
        let v21 = 0x2::object::uid_to_inner(&v20);
        0x2::object::delete(v20);
        let v22 = ChallengeSettled{
            challenge_id    : v21,
            verifier_cap_id : 0x2::object::id<0xf853c5905388889d76b42fbe24ea00d6992305f4d1f807097d14f8161bbd1c34::arena::VerifierCap>(arg2),
            outcome         : arg4,
            attacker_owner  : v5,
            defender_owner  : v10,
            attacker_points : v1,
            defender_points : v2,
            attacker_fuel   : arg5,
            defender_fuel   : arg6,
            replay_blob_id  : arg7,
            replay_digest   : arg8,
            challenge_epoch : v17,
            points_epoch    : 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::current_epoch<T0>(arg3, arg9),
            settled_at_ms   : v0,
        };
        0x2::event::emit<ChallengeSettled>(v22);
        let v23 = arg4 == 3;
        let v24 = if (v23) {
            0x1::vector::empty<0x2::object::ID>()
        } else {
            v6
        };
        let v25 = if (v23) {
            0x1::vector::empty<0x2::object::ID>()
        } else {
            v11
        };
        Settlement<T0>{
            challenge_id      : v21,
            outcome           : arg4,
            attacker_points   : v1,
            defender_points   : v2,
            pending_attackers : v24,
            pending_defenders : v25,
        }
    }

    public fun settle_by_ms<T0>(arg0: &Challenge<T0>) : u64 {
        arg0.settle_by_ms
    }

    public fun settlement_attacker_points<T0>(arg0: &Settlement<T0>) : u64 {
        arg0.attacker_points
    }

    public fun settlement_defender_points<T0>(arg0: &Settlement<T0>) : u64 {
        arg0.defender_points
    }

    public fun settlement_outcome<T0>(arg0: &Settlement<T0>) : u8 {
        arg0.outcome
    }

    public fun settlement_pending<T0>(arg0: &Settlement<T0>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pending_attackers) + 0x1::vector::length<0x2::object::ID>(&arg0.pending_defenders)
    }

    fun share_challenge<T0>(arg0: Challenge<T0>) {
        let v0 = ChallengeCreated{
            challenge_id             : 0x2::object::id<Challenge<T0>>(&arg0),
            attacker_lead_account_id : arg0.attacker_lead_account_id,
            attacker_owner           : arg0.attacker_owner,
            attacker_character_ids   : arg0.attacker_character_ids,
            attacker_strategy_hash   : arg0.attacker_strategy_hash,
            defender_lead_account_id : arg0.defender_lead_account_id,
            defender_owner           : arg0.defender_owner,
            defender_character_ids   : arg0.defender_character_ids,
            defender_is_house        : arg0.defender_is_house,
            defender_strategy_hash   : arg0.defender_strategy_hash,
            ruleset_hash             : arg0.ruleset_hash,
            seed                     : arg0.seed,
            fee_paid                 : arg0.fee_paid,
            epoch                    : arg0.epoch,
            created_at_ms            : arg0.created_at_ms,
            settle_by_ms             : arg0.settle_by_ms,
        };
        0x2::event::emit<ChallengeCreated>(v0);
        0x2::transfer::share_object<Challenge<T0>>(arg0);
    }

    public fun ticket_message(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: u64) : vector<u8> {
        let v0 = MatchTicket{
            domain                   : b"BLASTOFF_MATCH_TICKET_V1",
            arena_id                 : arg0,
            attacker_lead_account_id : arg1,
            attacker_challenge_seq   : arg2,
            defender_lead_account_id : arg3,
            expires_at_ms            : arg4,
        };
        0x1::bcs::to_bytes<MatchTicket>(&v0)
    }

    // decompiled from Move bytecode v7
}

