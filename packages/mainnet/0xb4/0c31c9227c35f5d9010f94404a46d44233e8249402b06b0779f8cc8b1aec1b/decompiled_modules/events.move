module 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::events {
    struct MapTemplatePublishedEvent has copy, drop {
        template_id: 0x2::object::ID,
        publisher: address,
        tile_count: u64,
        building_count: u64,
    }

    struct RegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
    }

    struct GameDataCreatedEvent has copy, drop {
        data_id: 0x2::object::ID,
    }

    struct GameCreatedEvent has copy, drop {
        game: 0x2::object::ID,
        creator: address,
        template_map_id: 0x2::object::ID,
    }

    struct PlayerJoinedEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        player_index: u8,
    }

    struct GameStartedEvent has copy, drop {
        game: 0x2::object::ID,
        template_map_id: 0x2::object::ID,
        players: vector<address>,
        starting_player: address,
    }

    struct GameEndedEvent has copy, drop {
        game: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        round: u16,
        turn_in_round: u8,
        reason: u8,
    }

    struct TurnStartEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        round: u16,
        turn_in_round: u8,
    }

    struct SkipTurnEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        reason: u8,
        remaining_turns: u8,
        round: u16,
        turn: u8,
    }

    struct RoundEndedEvent has copy, drop {
        game: 0x2::object::ID,
        round: u16,
        npc_kind: u8,
        tile_id: u16,
    }

    struct BankruptEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        debt: u64,
        creditor: 0x1::option::Option<address>,
    }

    struct BuildingDecisionEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        round: u16,
        turn: u8,
        auto_decision: bool,
        decision: BuildingDecisionInfo,
    }

    struct RentDecisionEvent has copy, drop {
        game: 0x2::object::ID,
        round: u16,
        turn: u8,
        auto_decision: bool,
        decision: RentDecisionInfo,
    }

    struct DecisionSkippedEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        decision_type: u8,
        tile_id: u16,
        round: u16,
        turn: u8,
    }

    struct CashDelta has copy, drop, store {
        player: address,
        is_debit: bool,
        amount: u64,
        reason: u8,
        details: u16,
    }

    struct CardDrawItem has copy, drop, store {
        tile_id: u16,
        kind: u8,
        count: u8,
        is_pass: bool,
    }

    struct NpcChangeItem has copy, drop, store {
        tile_id: u16,
        kind: u8,
        action: u8,
        consumed: bool,
    }

    struct BuffChangeItem has copy, drop, store {
        buff_type: u8,
        target: address,
        last_active_round: 0x1::option::Option<u16>,
    }

    struct NpcStepEvent has copy, drop, store {
        tile_id: u16,
        kind: u8,
        result: u8,
        consumed: bool,
        result_tile: 0x1::option::Option<u16>,
    }

    struct BuildingDecisionInfo has copy, drop, store {
        decision_type: u8,
        building_id: u16,
        tile_id: u16,
        amount: u64,
        new_level: u8,
        building_type: u8,
    }

    struct RentDecisionInfo has copy, drop, store {
        payer: address,
        owner: address,
        building_id: u16,
        tile_id: u16,
        rent_amount: u64,
        used_rent_free: bool,
    }

    struct StopEffect has copy, drop, store {
        tile_id: u16,
        tile_kind: u8,
        stop_type: u8,
        amount: u64,
        owner: 0x1::option::Option<address>,
        level: 0x1::option::Option<u8>,
        turns: 0x1::option::Option<u8>,
        card_gains: vector<CardDrawItem>,
        pending_decision: u8,
        decision_tile: u16,
        decision_amount: u64,
        building_decision: 0x1::option::Option<BuildingDecisionInfo>,
        rent_decision: 0x1::option::Option<RentDecisionInfo>,
    }

    struct StepEffect has copy, drop, store {
        step_index: u8,
        from_tile: u16,
        to_tile: u16,
        remaining_steps: u8,
        pass_draws: vector<CardDrawItem>,
        npc_event: 0x1::option::Option<NpcStepEvent>,
        stop_effect: 0x1::option::Option<StopEffect>,
    }

    struct UseCardActionEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        round: u16,
        turn_in_round: u8,
        kind: u8,
        params: vector<u16>,
        npc_changes: vector<NpcChangeItem>,
        buff_changes: vector<BuffChangeItem>,
        cash_changes: vector<CashDelta>,
    }

    struct RollAndStepActionEvent has copy, drop {
        game: 0x2::object::ID,
        player: address,
        round: u16,
        turn_in_round: u8,
        dice: u8,
        path_choices: vector<u16>,
        from: u16,
        steps: vector<StepEffect>,
        cash_changes: vector<CashDelta>,
        end_pos: u16,
    }

    public(friend) fun emit_bankrupt_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::option::Option<address>) {
        let v0 = BankruptEvent{
            game     : arg0,
            player   : arg1,
            debt     : arg2,
            creditor : arg3,
        };
        0x2::event::emit<BankruptEvent>(v0);
    }

    public(friend) fun emit_building_decision_event(arg0: 0x2::object::ID, arg1: address, arg2: u16, arg3: u8, arg4: bool, arg5: BuildingDecisionInfo) {
        let v0 = BuildingDecisionEvent{
            game          : arg0,
            player        : arg1,
            round         : arg2,
            turn          : arg3,
            auto_decision : arg4,
            decision      : arg5,
        };
        0x2::event::emit<BuildingDecisionEvent>(v0);
    }

    public(friend) fun emit_decision_skipped_event(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u16, arg4: u16, arg5: u8) {
        let v0 = DecisionSkippedEvent{
            game          : arg0,
            player        : arg1,
            decision_type : arg2,
            tile_id       : arg3,
            round         : arg4,
            turn          : arg5,
        };
        0x2::event::emit<DecisionSkippedEvent>(v0);
    }

    public(friend) fun emit_game_created_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID) {
        let v0 = GameCreatedEvent{
            game            : arg0,
            creator         : arg1,
            template_map_id : arg2,
        };
        0x2::event::emit<GameCreatedEvent>(v0);
    }

    public(friend) fun emit_game_data_created_event(arg0: 0x2::object::ID) {
        let v0 = GameDataCreatedEvent{data_id: arg0};
        0x2::event::emit<GameDataCreatedEvent>(v0);
    }

    public(friend) fun emit_game_ended_event(arg0: 0x2::object::ID, arg1: 0x1::option::Option<address>, arg2: u16, arg3: u8, arg4: u8) {
        let v0 = GameEndedEvent{
            game          : arg0,
            winner        : arg1,
            round         : arg2,
            turn_in_round : arg3,
            reason        : arg4,
        };
        0x2::event::emit<GameEndedEvent>(v0);
    }

    public(friend) fun emit_game_started_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<address>, arg3: address) {
        let v0 = GameStartedEvent{
            game            : arg0,
            template_map_id : arg1,
            players         : arg2,
            starting_player : arg3,
        };
        0x2::event::emit<GameStartedEvent>(v0);
    }

    public(friend) fun emit_map_template_published_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MapTemplatePublishedEvent{
            template_id    : arg0,
            publisher      : arg1,
            tile_count     : arg2,
            building_count : arg3,
        };
        0x2::event::emit<MapTemplatePublishedEvent>(v0);
    }

    public(friend) fun emit_player_joined_event(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = PlayerJoinedEvent{
            game         : arg0,
            player       : arg1,
            player_index : arg2,
        };
        0x2::event::emit<PlayerJoinedEvent>(v0);
    }

    public(friend) fun emit_registry_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RegistryCreatedEvent{
            registry_id : arg0,
            creator     : arg1,
        };
        0x2::event::emit<RegistryCreatedEvent>(v0);
    }

    public(friend) fun emit_rent_decision_event(arg0: 0x2::object::ID, arg1: u16, arg2: u8, arg3: bool, arg4: RentDecisionInfo) {
        let v0 = RentDecisionEvent{
            game          : arg0,
            round         : arg1,
            turn          : arg2,
            auto_decision : arg3,
            decision      : arg4,
        };
        0x2::event::emit<RentDecisionEvent>(v0);
    }

    public(friend) fun emit_roll_and_step_action_event_with_choices(arg0: 0x2::object::ID, arg1: address, arg2: u16, arg3: u8, arg4: u8, arg5: vector<u16>, arg6: u16, arg7: vector<StepEffect>, arg8: vector<CashDelta>, arg9: u16) {
        let v0 = RollAndStepActionEvent{
            game          : arg0,
            player        : arg1,
            round         : arg2,
            turn_in_round : arg3,
            dice          : arg4,
            path_choices  : arg5,
            from          : arg6,
            steps         : arg7,
            cash_changes  : arg8,
            end_pos       : arg9,
        };
        0x2::event::emit<RollAndStepActionEvent>(v0);
    }

    public(friend) fun emit_round_ended_event(arg0: 0x2::object::ID, arg1: u16, arg2: u8, arg3: u16) {
        let v0 = RoundEndedEvent{
            game     : arg0,
            round    : arg1,
            npc_kind : arg2,
            tile_id  : arg3,
        };
        0x2::event::emit<RoundEndedEvent>(v0);
    }

    public(friend) fun emit_skip_turn_event(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u8, arg4: u16, arg5: u8) {
        let v0 = SkipTurnEvent{
            game            : arg0,
            player          : arg1,
            reason          : arg2,
            remaining_turns : arg3,
            round           : arg4,
            turn            : arg5,
        };
        0x2::event::emit<SkipTurnEvent>(v0);
    }

    public(friend) fun emit_use_card_action_event(arg0: 0x2::object::ID, arg1: address, arg2: u16, arg3: u8, arg4: u8, arg5: vector<u16>, arg6: vector<NpcChangeItem>, arg7: vector<BuffChangeItem>, arg8: vector<CashDelta>) {
        let v0 = UseCardActionEvent{
            game          : arg0,
            player        : arg1,
            round         : arg2,
            turn_in_round : arg3,
            kind          : arg4,
            params        : arg5,
            npc_changes   : arg6,
            buff_changes  : arg7,
            cash_changes  : arg8,
        };
        0x2::event::emit<UseCardActionEvent>(v0);
    }

    public(friend) fun make_buff_change(arg0: u8, arg1: address, arg2: 0x1::option::Option<u16>) : BuffChangeItem {
        BuffChangeItem{
            buff_type         : arg0,
            target            : arg1,
            last_active_round : arg2,
        }
    }

    public(friend) fun make_building_decision_info(arg0: u8, arg1: u16, arg2: u16, arg3: u64, arg4: u8, arg5: u8) : BuildingDecisionInfo {
        BuildingDecisionInfo{
            decision_type : arg0,
            building_id   : arg1,
            tile_id       : arg2,
            amount        : arg3,
            new_level     : arg4,
            building_type : arg5,
        }
    }

    public(friend) fun make_card_draw_item(arg0: u16, arg1: u8, arg2: u8, arg3: bool) : CardDrawItem {
        CardDrawItem{
            tile_id : arg0,
            kind    : arg1,
            count   : arg2,
            is_pass : arg3,
        }
    }

    public(friend) fun make_cash_delta(arg0: address, arg1: bool, arg2: u64, arg3: u8, arg4: u16) : CashDelta {
        CashDelta{
            player   : arg0,
            is_debit : arg1,
            amount   : arg2,
            reason   : arg3,
            details  : arg4,
        }
    }

    public(friend) fun make_npc_change(arg0: u16, arg1: u8, arg2: u8, arg3: bool) : NpcChangeItem {
        NpcChangeItem{
            tile_id  : arg0,
            kind     : arg1,
            action   : arg2,
            consumed : arg3,
        }
    }

    public(friend) fun make_npc_step_event(arg0: u16, arg1: u8, arg2: u8, arg3: bool, arg4: 0x1::option::Option<u16>) : NpcStepEvent {
        NpcStepEvent{
            tile_id     : arg0,
            kind        : arg1,
            result      : arg2,
            consumed    : arg3,
            result_tile : arg4,
        }
    }

    public(friend) fun make_rent_decision_info(arg0: address, arg1: address, arg2: u16, arg3: u16, arg4: u64, arg5: bool) : RentDecisionInfo {
        RentDecisionInfo{
            payer          : arg0,
            owner          : arg1,
            building_id    : arg2,
            tile_id        : arg3,
            rent_amount    : arg4,
            used_rent_free : arg5,
        }
    }

    public(friend) fun make_step_effect(arg0: u8, arg1: u16, arg2: u16, arg3: u8, arg4: vector<CardDrawItem>, arg5: 0x1::option::Option<NpcStepEvent>, arg6: 0x1::option::Option<StopEffect>) : StepEffect {
        StepEffect{
            step_index      : arg0,
            from_tile       : arg1,
            to_tile         : arg2,
            remaining_steps : arg3,
            pass_draws      : arg4,
            npc_event       : arg5,
            stop_effect     : arg6,
        }
    }

    public(friend) fun make_stop_effect(arg0: u16, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::option::Option<address>, arg5: 0x1::option::Option<u8>, arg6: 0x1::option::Option<u8>, arg7: vector<CardDrawItem>, arg8: u8, arg9: u16, arg10: u64, arg11: 0x1::option::Option<BuildingDecisionInfo>, arg12: 0x1::option::Option<RentDecisionInfo>) : StopEffect {
        StopEffect{
            tile_id           : arg0,
            tile_kind         : arg1,
            stop_type         : arg2,
            amount            : arg3,
            owner             : arg4,
            level             : arg5,
            turns             : arg6,
            card_gains        : arg7,
            pending_decision  : arg8,
            decision_tile     : arg9,
            decision_amount   : arg10,
            building_decision : arg11,
            rent_decision     : arg12,
        }
    }

    public(friend) fun npc_action_hit() : u8 {
        3
    }

    public(friend) fun npc_action_remove() : u8 {
        2
    }

    public(friend) fun npc_action_spawn() : u8 {
        1
    }

    public(friend) fun npc_result_barrier_stop() : u8 {
        2
    }

    public(friend) fun npc_result_none() : u8 {
        0
    }

    public(friend) fun npc_result_send_hospital() : u8 {
        1
    }

    public(friend) fun stop_bonus() : u8 {
        5
    }

    public(friend) fun stop_building_no_rent() : u8 {
        2
    }

    public(friend) fun stop_building_toll() : u8 {
        1
    }

    public(friend) fun stop_building_unowned() : u8 {
        8
    }

    public(friend) fun stop_card_stop() : u8 {
        7
    }

    public(friend) fun stop_fee() : u8 {
        6
    }

    public(friend) fun stop_hospital() : u8 {
        3
    }

    public(friend) fun stop_none() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

