module 0xe660c11d5cddf961e2f153e2e9c89517bdbb2dfa64b9d3aae711672aeb7f240d::game_events {
    struct EventCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct HushDirtyCopEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        hushed_cash: u128,
        gained_xp: u128,
        hushed_v_amount: u64,
    }

    struct RaidEvent has copy, drop {
        attacker_dvd_id: 0x2::object::ID,
        defender_dvd_id: 0x2::object::ID,
        attacker_id: 0x2::object::ID,
        defender_id: 0x2::object::ID,
        attacker_name: 0x1::string::String,
        defender_name: 0x1::string::String,
        raided_cash: u128,
        raided_weapon: u128,
        timestamp: u64,
    }

    struct MissionEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        mission_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        success: bool,
        weapon: u128,
        cash: u128,
        cooldown_time: u64,
        level_point: u128,
    }

    struct CaptureEvent has copy, drop {
        attacker_dvd_id: 0x2::object::ID,
        defender_dvd_id: 0x2::object::ID,
        attacker_id: 0x2::object::ID,
        defender_id: 0x2::object::ID,
        attacker_name: 0x1::string::String,
        defender_name: 0x1::string::String,
        turf_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct HeadquarterDestroyedEvent has copy, drop {
        attacker_dvd_id: 0x2::object::ID,
        defender_dvd_id: 0x2::object::ID,
        attacker: 0x2::object::ID,
        attacker_name: 0x1::string::String,
        defender: 0x2::object::ID,
        defender_name: 0x1::string::String,
        timestamp: u64,
        raided_resources_event: RaidedResourcesEvent,
    }

    struct RaidedResourcesEvent has copy, drop {
        cash: u128,
        weapon: u128,
        xp: u128,
    }

    struct WeeklyReportResetEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
    }

    struct CrackSafeEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        safe_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        total_amount: u128,
        code: u64,
        status: u8,
        earned_amount: u128,
        heat_point: u128,
        level_point: u64,
    }

    struct RewardClaimEvent has copy, drop {
        gangster_totals: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        perk_totals: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        resource_totals: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct DVDRewardClaimEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        tire: u64,
        resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        gangsters: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u8>,
    }

    struct ClaimResourcesEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        building_name: 0x1::string::String,
        resource_type: 0x1::string::String,
        resource_amount: u128,
    }

    struct UpgradeBuildingEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        building_name: 0x1::string::String,
        upgrade_to: u64,
    }

    struct DayRewardClaimedEvent has copy, drop {
        day: 0x1::string::String,
        rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        player_id: 0x2::object::ID,
        current_streak: u64,
        claim_time_ms: u64,
        dvd_id: 0x2::object::ID,
    }

    struct LateCheckInEvent has copy, drop {
        day: vector<0x1::string::String>,
        rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        player_id: 0x2::object::ID,
        current_streak: u64,
        claim_time_ms: u64,
        dvd_id: 0x2::object::ID,
    }

    struct TrainRecruitEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        gangster_name: 0x1::string::String,
        gangster_count: u64,
        cash_cost: u128,
        weapon_cost: u128,
    }

    struct PerkEnableEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        perk_name: 0x1::string::String,
    }

    struct BuyPerkEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        perk_name: 0x1::string::String,
        count: u64,
    }

    struct CreatePlayerEvent has copy, drop {
        name: 0x1::string::String,
        player_id: 0x2::object::ID,
        created_at: u64,
        dvd_id: 0x2::object::ID,
    }

    struct ChangeProfileEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        new_image: 0x1::string::String,
    }

    struct FeedPeopleEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        recruit_count: u64,
        hushed_cash: u128,
        gained_xp: u128,
        hushed_v_amount: u64,
    }

    struct HireScoutsEvent has copy, drop, store {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        total_cost: u128,
        hired_scouts: u64,
    }

    struct ChangePlayerNameEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        new_name: 0x1::string::String,
    }

    struct BlackmailEvent has copy, drop {
        target_player_id: 0x2::object::ID,
        target_player_dvd: 0x2::object::ID,
        target_player: 0x1::string::String,
        blackmailer: 0x2::object::ID,
        blackmailer_player: 0x1::string::String,
        blackmailer_dvd: 0x2::object::ID,
        tried_at: u64,
        success: bool,
        blackmail_type: 0x1::string::String,
        amount_earned: u128,
        heat_point: u128,
        level_point: u128,
    }

    struct WeeklyReportClaimEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        xp_gained: u128,
    }

    struct PenaltyPaidEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        henchman: u64,
        bouncer: u64,
        enforcer: u64,
        recruits: u64,
    }

    struct DowngradeBuildingEvent has copy, drop {
        defender_player_id: 0x2::object::ID,
        defender_dvd_id: 0x2::object::ID,
        defender_player_name: 0x1::string::String,
        building_name: 0x1::string::String,
        downgrade_to: u64,
        downgrade_from: u64,
    }

    struct RaidSearchEvent has copy, drop {
        attacker_id: 0x2::object::ID,
        attacker_dvd_id: 0x2::object::ID,
        attacker_player_name: 0x1::string::String,
        defender_id: 0x2::object::ID,
        defender_dvd_id: 0x2::object::ID,
        defender_player_name: 0x1::string::String,
        defender_turf: 0x2::object::ID,
        raided_resources: RaidedResourcesEvent,
    }

    struct PlayerLeveledUpEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        level: u64,
        level_up_by: u64,
        next_level_at: u128,
        level_point: u128,
        previous_level_point: u128,
    }

    struct BountyCreatedEvent has copy, drop {
        initiator_player_id: 0x2::object::ID,
        bounty_creator_name: 0x1::string::String,
        bounty_creator_dvd: 0x2::object::ID,
        target_player_id: 0x2::object::ID,
        target_player_name: 0x1::string::String,
        target_player_dvd: 0x2::object::ID,
        cash: u128,
    }

    struct BountyAdditionalEvent has copy, drop {
        initiator_player_id: 0x2::object::ID,
        bounty_creator_name: 0x1::string::String,
        bounty_creator_dvd: 0x2::object::ID,
        target_player_id: 0x2::object::ID,
        target_player_name: 0x1::string::String,
        cash: u128,
    }

    struct BountyClosedEvent has copy, drop {
        target_player_id: 0x2::object::ID,
        target_player_name: 0x1::string::String,
        attacker_id: 0x2::object::ID,
        attacker_name: 0x1::string::String,
        attacker_dvd: 0x2::object::ID,
        cash: u128,
    }

    struct BountyShootEvent has copy, drop {
        target_player_id: 0x2::object::ID,
        target_player_name: 0x1::string::String,
        attacker_id: 0x2::object::ID,
        attacker_name: 0x1::string::String,
    }

    struct BountyEvaluatedEvent has copy, drop {
        target_player_id: 0x2::object::ID,
        target_player_name: 0x1::string::String,
        attacker_id: 0x2::object::ID,
        attacker_name: 0x1::string::String,
        winner_id: 0x2::object::ID,
        total_reward: u128,
        target_player_bullet_used: u64,
        attacker_bullet_used: u64,
        result: 0x1::string::String,
    }

    public fun emit_7days_reward_event(arg0: &EventCap, arg1: 0x1::string::String, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: 0x2::object::ID) {
        let v0 = DayRewardClaimedEvent{
            day            : arg1,
            rewards        : arg2,
            player_id      : arg3,
            current_streak : arg4,
            claim_time_ms  : arg5,
            dvd_id         : arg6,
        };
        0x2::event::emit<DayRewardClaimedEvent>(v0);
    }

    public fun emit_blackmail_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: u64, arg9: bool, arg10: u128, arg11: u128, arg12: u128) {
        let v0 = BlackmailEvent{
            target_player_id   : arg1,
            target_player_dvd  : arg2,
            target_player      : arg3,
            blackmailer        : arg4,
            blackmailer_player : arg6,
            blackmailer_dvd    : arg7,
            tried_at           : arg8,
            success            : arg9,
            blackmail_type     : arg5,
            amount_earned      : arg10,
            heat_point         : arg11,
            level_point        : arg12,
        };
        0x2::event::emit<BlackmailEvent>(v0);
    }

    public fun emit_bounty_additional_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: u128) {
        let v0 = BountyAdditionalEvent{
            initiator_player_id : arg1,
            bounty_creator_name : arg2,
            bounty_creator_dvd  : arg3,
            target_player_id    : arg4,
            target_player_name  : arg5,
            cash                : arg6,
        };
        0x2::event::emit<BountyAdditionalEvent>(v0);
    }

    public fun emit_bounty_closed_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x2::object::ID, arg6: u128) {
        let v0 = BountyClosedEvent{
            target_player_id   : arg1,
            target_player_name : arg2,
            attacker_id        : arg3,
            attacker_name      : arg4,
            attacker_dvd       : arg5,
            cash               : arg6,
        };
        0x2::event::emit<BountyClosedEvent>(v0);
    }

    public fun emit_bounty_created_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x2::object::ID, arg7: u128) {
        let v0 = BountyCreatedEvent{
            initiator_player_id : arg1,
            bounty_creator_name : arg2,
            bounty_creator_dvd  : arg3,
            target_player_id    : arg4,
            target_player_name  : arg5,
            target_player_dvd   : arg6,
            cash                : arg7,
        };
        0x2::event::emit<BountyCreatedEvent>(v0);
    }

    public fun emit_bounty_evaluated_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x2::object::ID, arg6: u128, arg7: u64, arg8: u64, arg9: 0x1::string::String) {
        let v0 = BountyEvaluatedEvent{
            target_player_id          : arg1,
            target_player_name        : arg2,
            attacker_id               : arg3,
            attacker_name             : arg4,
            winner_id                 : arg5,
            total_reward              : arg6,
            target_player_bullet_used : arg7,
            attacker_bullet_used      : arg8,
            result                    : arg9,
        };
        0x2::event::emit<BountyEvaluatedEvent>(v0);
    }

    public fun emit_bounty_shoot_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        let v0 = BountyShootEvent{
            target_player_id   : arg1,
            target_player_name : arg2,
            attacker_id        : arg3,
            attacker_name      : arg4,
        };
        0x2::event::emit<BountyShootEvent>(v0);
    }

    public fun emit_buy_perk_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        let v0 = BuyPerkEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            perk_name   : arg4,
            count       : arg5,
        };
        0x2::event::emit<BuyPerkEvent>(v0);
    }

    public fun emit_capture_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: u64) {
        let v0 = CaptureEvent{
            attacker_dvd_id : arg1,
            defender_dvd_id : arg2,
            attacker_id     : arg3,
            defender_id     : arg4,
            attacker_name   : arg5,
            defender_name   : arg6,
            turf_id         : arg7,
            timestamp       : arg8,
        };
        0x2::event::emit<CaptureEvent>(v0);
    }

    public fun emit_change_player_name_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = ChangePlayerNameEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            new_name    : arg4,
        };
        0x2::event::emit<ChangePlayerNameEvent>(v0);
    }

    public fun emit_change_profile_pic_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = ChangeProfileEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            new_image   : arg4,
        };
        0x2::event::emit<ChangeProfileEvent>(v0);
    }

    public fun emit_claim_resource_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u128) {
        let v0 = ClaimResourcesEvent{
            player_id       : arg1,
            dvd_id          : arg2,
            player_name     : arg3,
            building_name   : arg4,
            resource_type   : arg5,
            resource_amount : arg6,
        };
        0x2::event::emit<ClaimResourcesEvent>(v0);
    }

    public fun emit_crack_safe_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: u128, arg6: u64, arg7: u8, arg8: u128, arg9: u128, arg10: u64) {
        let v0 = CrackSafeEvent{
            player_id     : arg1,
            dvd_id        : arg2,
            safe_id       : arg3,
            player_name   : arg4,
            total_amount  : arg5,
            code          : arg6,
            status        : arg7,
            earned_amount : arg8,
            heat_point    : arg9,
            level_point   : arg10,
        };
        0x2::event::emit<CrackSafeEvent>(v0);
    }

    public fun emit_create_player(arg0: &EventCap, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID) {
        let v0 = CreatePlayerEvent{
            name       : arg1,
            player_id  : arg2,
            created_at : arg3,
            dvd_id     : arg4,
        };
        0x2::event::emit<CreatePlayerEvent>(v0);
    }

    public fun emit_downgrade_building_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64) {
        let v0 = DowngradeBuildingEvent{
            defender_player_id   : arg1,
            defender_dvd_id      : arg2,
            defender_player_name : arg3,
            building_name        : arg4,
            downgrade_to         : arg5,
            downgrade_from       : arg6,
        };
        0x2::event::emit<DowngradeBuildingEvent>(v0);
    }

    public fun emit_dvd_reward_claim_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg6: 0x2::vec_map::VecMap<0x1::string::String, u8>, arg7: 0x2::vec_map::VecMap<0x1::string::String, u8>) {
        let v0 = DVDRewardClaimEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            tire        : arg4,
            resources   : arg5,
            gangsters   : arg6,
            perks       : arg7,
        };
        0x2::event::emit<DVDRewardClaimEvent>(v0);
    }

    public fun emit_feed_people_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u128, arg6: u128, arg7: u64) {
        let v0 = FeedPeopleEvent{
            player_id       : arg1,
            dvd_id          : arg2,
            player_name     : arg3,
            recruit_count   : arg4,
            hushed_cash     : arg5,
            gained_xp       : arg6,
            hushed_v_amount : arg7,
        };
        0x2::event::emit<FeedPeopleEvent>(v0);
    }

    public fun emit_headquarter_destroyed_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: u64, arg8: u128, arg9: u128, arg10: u128) {
        let v0 = RaidedResourcesEvent{
            cash   : arg8,
            weapon : arg9,
            xp     : arg10,
        };
        let v1 = HeadquarterDestroyedEvent{
            attacker_dvd_id        : arg1,
            defender_dvd_id        : arg2,
            attacker               : arg3,
            attacker_name          : arg4,
            defender               : arg5,
            defender_name          : arg6,
            timestamp              : arg7,
            raided_resources_event : v0,
        };
        0x2::event::emit<HeadquarterDestroyedEvent>(v1);
    }

    public fun emit_hire_scout_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u128, arg5: u64) {
        let v0 = HireScoutsEvent{
            player_id    : arg1,
            dvd_id       : arg2,
            player_name  : arg3,
            total_cost   : arg4,
            hired_scouts : arg5,
        };
        0x2::event::emit<HireScoutsEvent>(v0);
    }

    public fun emit_hush_dirty_cop_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u128, arg5: u128, arg6: u64) {
        let v0 = HushDirtyCopEvent{
            player_id       : arg1,
            dvd_id          : arg2,
            player_name     : arg3,
            hushed_cash     : arg4,
            gained_xp       : arg5,
            hushed_v_amount : arg6,
        };
        0x2::event::emit<HushDirtyCopEvent>(v0);
    }

    public fun emit_late_checkin(arg0: &EventCap, arg1: vector<0x1::string::String>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: 0x2::object::ID) {
        let v0 = LateCheckInEvent{
            day            : arg1,
            rewards        : arg2,
            player_id      : arg3,
            current_streak : arg4,
            claim_time_ms  : arg5,
            dvd_id         : arg6,
        };
        0x2::event::emit<LateCheckInEvent>(v0);
    }

    public fun emit_mission_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: bool, arg6: u128, arg7: u128, arg8: u64, arg9: u128) {
        let v0 = MissionEvent{
            player_id     : arg1,
            dvd_id        : arg2,
            mission_id    : arg3,
            player_name   : arg4,
            success       : arg5,
            weapon        : arg6,
            cash          : arg7,
            cooldown_time : arg8,
            level_point   : arg9,
        };
        0x2::event::emit<MissionEvent>(v0);
    }

    public fun emit_operator_cap_issued_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OperatorCapIssuedEvent{
            cap_id    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v0);
    }

    public fun emit_operator_cap_revoked_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = OperatorCapIssuedEvent{
            cap_id    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v0);
    }

    public fun emit_penalty_paid_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = PenaltyPaidEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            henchman    : arg4,
            bouncer     : arg5,
            enforcer    : arg6,
            recruits    : arg7,
        };
        0x2::event::emit<PenaltyPaidEvent>(v0);
    }

    public fun emit_perk_enable_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = PerkEnableEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            perk_name   : arg4,
        };
        0x2::event::emit<PerkEnableEvent>(v0);
    }

    public fun emit_player_leveled_up_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u128) {
        let v0 = PlayerLeveledUpEvent{
            player_id            : arg1,
            dvd_id               : arg2,
            player_name          : arg3,
            level                : arg4,
            level_up_by          : arg5,
            next_level_at        : arg6,
            level_point          : arg7,
            previous_level_point : arg8,
        };
        0x2::event::emit<PlayerLeveledUpEvent>(v0);
    }

    public fun emit_raid_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u128, arg8: u128, arg9: u64) {
        let v0 = RaidEvent{
            attacker_dvd_id : arg1,
            defender_dvd_id : arg2,
            attacker_id     : arg3,
            defender_id     : arg4,
            attacker_name   : arg5,
            defender_name   : arg6,
            raided_cash     : arg7,
            raided_weapon   : arg8,
            timestamp       : arg9,
        };
        0x2::event::emit<RaidEvent>(v0);
    }

    public fun emit_raid_search_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: u128, arg9: u128, arg10: u128) {
        let v0 = RaidedResourcesEvent{
            cash   : arg8,
            weapon : arg9,
            xp     : arg10,
        };
        let v1 = RaidSearchEvent{
            attacker_id          : arg1,
            attacker_dvd_id      : arg2,
            attacker_player_name : arg3,
            defender_id          : arg4,
            defender_dvd_id      : arg5,
            defender_player_name : arg6,
            defender_turf        : arg7,
            raided_resources     : v0,
        };
        0x2::event::emit<RaidSearchEvent>(v1);
    }

    public fun emit_reward_claim_event(arg0: &EventCap, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: 0x2::vec_map::VecMap<0x1::string::String, u64>) {
        let v0 = RewardClaimEvent{
            gangster_totals : arg1,
            perk_totals     : arg2,
            resource_totals : arg3,
        };
        0x2::event::emit<RewardClaimEvent>(v0);
    }

    public fun emit_train_recruit_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u128, arg7: u128) {
        let v0 = TrainRecruitEvent{
            player_id      : arg1,
            dvd_id         : arg2,
            player_name    : arg3,
            gangster_name  : arg4,
            gangster_count : arg5,
            cash_cost      : arg6,
            weapon_cost    : arg7,
        };
        0x2::event::emit<TrainRecruitEvent>(v0);
    }

    public fun emit_weekly_report_claim_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u128) {
        let v0 = WeeklyReportClaimEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
            xp_gained   : arg4,
        };
        0x2::event::emit<WeeklyReportClaimEvent>(v0);
    }

    public fun emit_weekly_report_reset_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String) {
        let v0 = WeeklyReportResetEvent{
            player_id   : arg1,
            dvd_id      : arg2,
            player_name : arg3,
        };
        0x2::event::emit<WeeklyReportResetEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<EventCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun upgrade_building_event(arg0: &EventCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        let v0 = UpgradeBuildingEvent{
            player_id     : arg1,
            dvd_id        : arg2,
            player_name   : arg3,
            building_name : arg4,
            upgrade_to    : arg5,
        };
        0x2::event::emit<UpgradeBuildingEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

