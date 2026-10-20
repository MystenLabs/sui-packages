module 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::account {
    struct AgentsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct AccountKey<phantom T0> has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct Binding has copy, drop, store {
        owner: address,
        kiosk_id: 0x2::object::ID,
        bound_at_ms: u64,
    }

    struct Crew has copy, drop, store {
        member_character_ids: vector<0x2::object::ID>,
        defense_strategy_hash: vector<u8>,
    }

    struct AgentAccount<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        character_id: 0x2::object::ID,
        is_house: bool,
        binding: 0x1::option::Option<Binding>,
        binding_nonce: u64,
        mandate: 0x1::option::Option<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>,
        meter: 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::SpendMeter,
        budget: 0x2::balance::Balance<0x2::sui::SUI>,
        crew: 0x1::option::Option<Crew>,
        total_fees_paid: u64,
        challenge_seq: u64,
    }

    struct ChallengeAuth has copy, drop {
        lead_account_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        character_ids: vector<0x2::object::ID>,
        fee_paid: u64,
        epoch: u64,
        is_house: bool,
    }

    struct DefenseLineup has copy, drop {
        lead_account_id: 0x2::object::ID,
        owner: address,
        character_ids: vector<0x2::object::ID>,
        strategy_hash: vector<u8>,
        is_house: bool,
    }

    struct ChallengeFee has drop {
        dummy_field: bool,
    }

    struct AccountOpened has copy, drop {
        account_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
    }

    struct AccountBound has copy, drop {
        account_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        binding_nonce: u64,
        previous_owner: 0x1::option::Option<address>,
        refunded: u64,
    }

    struct MandateSet has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        mandate: 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate,
    }

    struct MandateRevoked has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct AgentKeyRotated has copy, drop {
        account_id: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
    }

    struct BudgetDeposited has copy, drop {
        account_id: 0x2::object::ID,
        amount: u64,
        balance_after: u64,
    }

    struct BudgetWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        balance_after: u64,
    }

    struct CrewSet has copy, drop {
        account_id: 0x2::object::ID,
        member_character_ids: vector<0x2::object::ID>,
        defense_strategy_hash: vector<u8>,
    }

    struct CrewCleared has copy, drop {
        account_id: 0x2::object::ID,
    }

    struct ChallengeFeePaid has copy, drop {
        account_id: 0x2::object::ID,
        agent: address,
        owner: address,
        fee: u64,
        epoch: u64,
        spent_in_epoch: u64,
    }

    struct HouseFlagSet has copy, drop {
        account_id: 0x2::object::ID,
        is_house: bool,
    }

    public fun account_address<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = AccountKey<T0>{pos0: arg1};
        0x2::derived_object::derive_address<AccountKey<T0>>(arg0, v0)
    }

    fun assert_bound_holder<T0>(arg0: &AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert_holds_character(arg1, arg2, arg0.character_id);
        let v0 = &arg0.binding;
        let v1 = if (0x1::option::is_some<Binding>(v0)) {
            let v2 = 0x1::option::borrow<Binding>(v0);
            v2.owner == 0x2::tx_context::sender(arg3) && v2.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1)
        } else {
            false
        };
        assert!(v1, 13906837060562124812);
    }

    fun assert_bound_kiosk<T0>(arg0: &AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk) : address {
        let v0 = &arg0.binding;
        assert!(0x1::option::is_some<Binding>(v0) && 0x1::option::borrow<Binding>(v0).kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 13906837150756438028);
        assert!(0x2::kiosk::has_item_with_type<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg1, arg0.character_id), 13906837159346241546);
        0x1::option::borrow<Binding>(&arg0.binding).owner
    }

    fun assert_bound_owner<T0>(arg0: &AgentAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = &arg0.binding;
        assert!(0x1::option::is_some<Binding>(v0) && 0x1::option::borrow<Binding>(v0).owner == 0x2::tx_context::sender(arg1), 13906837090626895884);
    }

    fun assert_holds_character(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg1) == 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 13906837112101470216);
        assert!(0x2::kiosk::has_item_with_type<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg0, arg2), 13906837116396568586);
    }

    fun assert_members_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: &vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            assert!(0x2::kiosk::has_item_with_type<0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets::Character>(arg0, *0x1::vector::borrow<0x2::object::ID>(arg1, v0)), 13906837185116045322);
            v0 = v0 + 1;
        };
    }

    fun assert_owner<T0>(arg0: &AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906836987547156484);
        assert_bound_holder<T0>(arg0, arg1, arg2, arg3);
    }

    public fun auth_character_ids(arg0: &ChallengeAuth) : vector<0x2::object::ID> {
        arg0.character_ids
    }

    public fun auth_epoch(arg0: &ChallengeAuth) : u64 {
        arg0.epoch
    }

    public fun auth_fee_paid(arg0: &ChallengeAuth) : u64 {
        arg0.fee_paid
    }

    public fun auth_is_house(arg0: &ChallengeAuth) : bool {
        arg0.is_house
    }

    public fun auth_kiosk_id(arg0: &ChallengeAuth) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun auth_lead_account_id(arg0: &ChallengeAuth) : 0x2::object::ID {
        arg0.lead_account_id
    }

    public fun auth_owner(arg0: &ChallengeAuth) : address {
        arg0.owner
    }

    public fun authorize_challenge<T0>(arg0: &mut AgentAccount<T0>, arg1: &AgentRegistry, arg2: &0x2::kiosk::Kiosk, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg4: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : ChallengeAuth {
        assert!(arg1.version == 1 && arg0.version == 1, 13906836283172519940);
        assert!(!arg1.paused, 13906836287467618310);
        assert!(0x1::option::is_some<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(&arg0.mandate), 13906836291763109902);
        let v0 = *0x1::option::borrow<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(&arg0.mandate);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(v1 == 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::agent(&v0), 13906836304648142864);
        assert!(!0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::is_expired(&v0, arg6), 13906836308943241234);
        assert!(0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::allows(&v0, 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::action_challenge()), 13906836313238339604);
        let v2 = assert_bound_kiosk<T0>(arg0, arg2);
        assert!(0x1::option::is_some<Crew>(&arg0.crew), 13906836321828405270);
        let v3 = 0x1::option::borrow<Crew>(&arg0.crew).member_character_ids;
        assert_members_in_kiosk(arg2, &v3);
        let v4 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::challenge_fee_mist<T0>(arg4);
        assert!(v4 == arg5, 13906836339008667676);
        let v5 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::current_epoch<T0>(arg4, arg6);
        0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::charge(&mut arg0.meter, &v0, v5, v4);
        assert!(v4 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.budget), 13906836356188667934);
        let v6 = ChallengeFee{dummy_field: false};
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::deposit<T0, ChallengeFee>(arg3, arg4, v6, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.budget, v4));
        arg0.total_fees_paid = arg0.total_fees_paid + v4;
        arg0.challenge_seq = arg0.challenge_seq + 1;
        let v7 = 0x2::object::id<AgentAccount<T0>>(arg0);
        let v8 = ChallengeFeePaid{
            account_id     : v7,
            agent          : v1,
            owner          : v2,
            fee            : v4,
            epoch          : v5,
            spent_in_epoch : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::meter_spent(&arg0.meter),
        };
        0x2::event::emit<ChallengeFeePaid>(v8);
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v9, arg0.character_id);
        0x1::vector::append<0x2::object::ID>(&mut v9, v3);
        ChallengeAuth{
            lead_account_id : v7,
            owner           : v2,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            character_ids   : v9,
            fee_paid        : v4,
            epoch           : v5,
            is_house        : arg0.is_house,
        }
    }

    public fun bind<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835492898537476);
        assert_holds_character(arg1, arg2, arg0.character_id);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = &arg0.binding;
        let v3 = if (0x1::option::is_some<Binding>(v2)) {
            0x1::option::some<address>(0x1::option::borrow<Binding>(v2).owner)
        } else {
            0x1::option::none<address>()
        };
        let v4 = v3;
        let v5 = 0;
        if (v4 != 0x1::option::some<address>(v0)) {
            arg0.mandate = 0x1::option::none<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>();
            arg0.crew = 0x1::option::none<Crew>();
            0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::reset(&mut arg0.meter);
            arg0.binding_nonce = arg0.binding_nonce + 1;
            let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.budget);
            v5 = v6;
            if (v6 > 0 && 0x1::option::is_some<address>(&v4)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.budget), arg4), *0x1::option::borrow<address>(&v4));
            } else {
                v5 = 0;
            };
        };
        let v7 = Binding{
            owner       : v0,
            kiosk_id    : v1,
            bound_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        arg0.binding = 0x1::option::some<Binding>(v7);
        let v8 = AccountBound{
            account_id     : 0x2::object::id<AgentAccount<T0>>(arg0),
            character_id   : arg0.character_id,
            owner          : v0,
            kiosk_id       : v1,
            binding_nonce  : arg0.binding_nonce,
            previous_owner : v4,
            refunded       : v5,
        };
        0x2::event::emit<AccountBound>(v8);
    }

    public fun binding<T0>(arg0: &AgentAccount<T0>) : 0x1::option::Option<Binding> {
        arg0.binding
    }

    public fun binding_kiosk_id(arg0: &Binding) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun binding_nonce<T0>(arg0: &AgentAccount<T0>) : u64 {
        arg0.binding_nonce
    }

    public fun binding_owner(arg0: &Binding) : address {
        arg0.owner
    }

    public fun budget_value<T0>(arg0: &AgentAccount<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.budget)
    }

    public fun challenge_seq<T0>(arg0: &AgentAccount<T0>) : u64 {
        arg0.challenge_seq
    }

    public fun character_id<T0>(arg0: &AgentAccount<T0>) : 0x2::object::ID {
        arg0.character_id
    }

    public fun clear_crew<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1, arg2, arg3);
        assert!(0x1::option::is_some<Crew>(&arg0.crew), 13906836171504549910);
        arg0.crew = 0x1::option::none<Crew>();
        let v0 = CrewCleared{account_id: 0x2::object::id<AgentAccount<T0>>(arg0)};
        0x2::event::emit<CrewCleared>(v0);
    }

    public fun crew<T0>(arg0: &AgentAccount<T0>) : 0x1::option::Option<Crew> {
        arg0.crew
    }

    public fun crew_defense_strategy_hash(arg0: &Crew) : vector<u8> {
        arg0.defense_strategy_hash
    }

    public fun crew_member_character_ids(arg0: &Crew) : vector<0x2::object::ID> {
        arg0.member_character_ids
    }

    public fun defense_lineup<T0>(arg0: &AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk) : DefenseLineup {
        assert!(0x1::option::is_some<Crew>(&arg0.crew), 13906836489332129814);
        let v0 = *0x1::option::borrow<Crew>(&arg0.crew);
        assert_members_in_kiosk(arg1, &v0.member_character_ids);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, arg0.character_id);
        0x1::vector::append<0x2::object::ID>(&mut v1, v0.member_character_ids);
        DefenseLineup{
            lead_account_id : 0x2::object::id<AgentAccount<T0>>(arg0),
            owner           : assert_bound_kiosk<T0>(arg0, arg1),
            character_ids   : v1,
            strategy_hash   : v0.defense_strategy_hash,
            is_house        : arg0.is_house,
        }
    }

    public fun deposit_budget<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1, arg2, arg4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 13906835896627298336);
        let v1 = BudgetDeposited{
            account_id    : 0x2::object::id<AgentAccount<T0>>(arg0),
            amount        : v0,
            balance_after : 0x2::balance::join<0x2::sui::SUI>(&mut arg0.budget, 0x2::coin::into_balance<0x2::sui::SUI>(arg3)),
        };
        0x2::event::emit<BudgetDeposited>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AgentsAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AgentRegistry{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
        };
        0x2::transfer::share_object<AgentRegistry>(v1);
    }

    public fun is_house<T0>(arg0: &AgentAccount<T0>) : bool {
        arg0.is_house
    }

    public fun is_paused(arg0: &AgentRegistry) : bool {
        arg0.paused
    }

    public fun lineup_character_ids(arg0: &DefenseLineup) : vector<0x2::object::ID> {
        arg0.character_ids
    }

    public fun lineup_is_house(arg0: &DefenseLineup) : bool {
        arg0.is_house
    }

    public fun lineup_lead_account_id(arg0: &DefenseLineup) : 0x2::object::ID {
        arg0.lead_account_id
    }

    public fun lineup_owner(arg0: &DefenseLineup) : address {
        arg0.owner
    }

    public fun lineup_strategy_hash(arg0: &DefenseLineup) : vector<u8> {
        arg0.strategy_hash
    }

    public fun mandate<T0>(arg0: &AgentAccount<T0>) : 0x1::option::Option<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate> {
        arg0.mandate
    }

    public fun meter<T0>(arg0: &AgentAccount<T0>) : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::SpendMeter {
        arg0.meter
    }

    public fun migrate_account<T0>(arg0: &mut AgentAccount<T0>) {
        assert!(arg0.version < 1, 13906836665424609284);
        arg0.version = 1;
    }

    public fun migrate_registry(arg0: &mut AgentRegistry, arg1: &AgentsAdminCap) {
        assert!(arg0.version < 1, 13906836635359838212);
        arg0.version = 1;
    }

    public fun open_account<T0>(arg0: &mut AgentRegistry, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.version == 1, 13906835295330041860);
        assert_holds_character(arg1, arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = AccountKey<T0>{pos0: arg3};
        let v3 = Binding{
            owner       : v0,
            kiosk_id    : v1,
            bound_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        let v4 = AgentAccount<T0>{
            id              : 0x2::derived_object::claim<AccountKey<T0>>(&mut arg0.id, v2),
            version         : 1,
            character_id    : arg3,
            is_house        : false,
            binding         : 0x1::option::some<Binding>(v3),
            binding_nonce   : 0,
            mandate         : 0x1::option::none<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(),
            meter           : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::new_meter(),
            budget          : 0x2::balance::zero<0x2::sui::SUI>(),
            crew            : 0x1::option::none<Crew>(),
            total_fees_paid : 0,
            challenge_seq   : 0,
        };
        let v5 = 0x2::object::id<AgentAccount<T0>>(&v4);
        let v6 = AccountOpened{
            account_id   : v5,
            character_id : arg3,
        };
        0x2::event::emit<AccountOpened>(v6);
        let v7 = AccountBound{
            account_id     : v5,
            character_id   : arg3,
            owner          : v0,
            kiosk_id       : v1,
            binding_nonce  : 0,
            previous_owner : 0x1::option::none<address>(),
            refunded       : 0,
        };
        0x2::event::emit<AccountBound>(v7);
        0x2::transfer::share_object<AgentAccount<T0>>(v4);
        v5
    }

    public fun revoke_mandate<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 13906835729121738756);
        assert_bound_owner<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(&arg0.mandate), 13906835737712328718);
        arg0.mandate = 0x1::option::none<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>();
        0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::reset(&mut arg0.meter);
        let v0 = MandateRevoked{
            account_id : 0x2::object::id<AgentAccount<T0>>(arg0),
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MandateRevoked>(v0);
    }

    public fun rotate_agent_key<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1, arg2, arg4);
        assert!(0x1::option::is_some<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(&arg0.mandate), 13906835815021740046);
        let v0 = 0x1::option::borrow_mut<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(&mut arg0.mandate);
        0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::set_agent(v0, arg3);
        let v1 = AgentKeyRotated{
            account_id : 0x2::object::id<AgentAccount<T0>>(arg0),
            old_agent  : 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::agent(v0),
            new_agent  : arg3,
        };
        0x2::event::emit<AgentKeyRotated>(v1);
    }

    public fun set_crew<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1, arg2, arg5);
        let v0 = if (0x1::vector::length<0x2::object::ID>(&arg3) == 2) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg3, 0) != *0x1::vector::borrow<0x2::object::ID>(&arg3, 1)) {
                !0x1::vector::contains<0x2::object::ID>(&arg3, &arg0.character_id)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906836098490236952);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906836107080302618);
        assert_members_in_kiosk(arg1, &arg3);
        let v1 = Crew{
            member_character_ids  : arg3,
            defense_strategy_hash : arg4,
        };
        arg0.crew = 0x1::option::some<Crew>(v1);
        let v2 = CrewSet{
            account_id            : 0x2::object::id<AgentAccount<T0>>(arg0),
            member_character_ids  : arg3,
            defense_strategy_hash : arg4,
        };
        0x2::event::emit<CrewSet>(v2);
    }

    public fun set_house<T0>(arg0: &mut AgentAccount<T0>, arg1: &AgentsAdminCap, arg2: bool) {
        assert!(arg0.version == 1, 13906836566640361476);
        arg0.is_house = arg2;
        let v0 = HouseFlagSet{
            account_id : 0x2::object::id<AgentAccount<T0>>(arg0),
            is_house   : arg2,
        };
        0x2::event::emit<HouseFlagSet>(v0);
    }

    public fun set_mandate<T0>(arg0: &mut AgentAccount<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate, arg4: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1, arg2, arg4);
        arg0.mandate = 0x1::option::some<0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::Mandate>(arg3);
        0x37930ead1f410aeea4bb934efdd48a1d6249f9814eda4a61dba04e04b8dc4799::mandate::reset(&mut arg0.meter);
        let v0 = MandateSet{
            account_id : 0x2::object::id<AgentAccount<T0>>(arg0),
            owner      : 0x2::tx_context::sender(arg4),
            mandate    : arg3,
        };
        0x2::event::emit<MandateSet>(v0);
    }

    public fun set_paused(arg0: &mut AgentRegistry, arg1: &AgentsAdminCap, arg2: bool) {
        assert!(arg0.version == 1, 13906836605295067140);
        arg0.paused = arg2;
    }

    public fun total_fees_paid<T0>(arg0: &AgentAccount<T0>) : u64 {
        arg0.total_fees_paid
    }

    public fun withdraw_budget<T0>(arg0: &mut AgentAccount<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version <= 1, 13906835965344940036);
        assert_bound_owner<T0>(arg0, arg2);
        assert!(arg1 > 0, 13906835973936709664);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.budget), 13906835978231545886);
        let v0 = BudgetWithdrawn{
            account_id    : 0x2::object::id<AgentAccount<T0>>(arg0),
            owner         : 0x2::tx_context::sender(arg2),
            amount        : arg1,
            balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.budget),
        };
        0x2::event::emit<BudgetWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.budget, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

