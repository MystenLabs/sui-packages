module 0xf03886dacd7a9a542a1c02ffcfe2dc0b5aa03f3275a6c440e4f9cd10c765cfdb::check_in {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        paused: bool,
    }

    struct CheckInCampaign has store, key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
        point_cap: 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap,
        liquidlink_config_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        points_per_check_in: u64,
        reset_offset_ms: u64,
        day_length_ms: u64,
        total_check_ins: u64,
        users: 0x2::table::Table<address, UserCheckIn>,
    }

    struct UserCheckIn has copy, drop, store {
        last_day: u64,
        streak: u64,
        total_check_ins: u64,
        last_checked_in_at_ms: u64,
    }

    struct GlobalConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        allowed_versions: vector<u64>,
    }

    struct VersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        version: u64,
        allowed: bool,
    }

    struct GlobalPauseUpdated has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        liquidlink_config_id: 0x2::object::ID,
        point_cap_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        points_per_check_in: u64,
        reset_offset_ms: u64,
        day_length_ms: u64,
    }

    struct CampaignConfigUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
        points_per_check_in: u64,
        reset_offset_ms: u64,
        day_length_ms: u64,
        enabled: bool,
    }

    struct CampaignPauseUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
        enabled: bool,
    }

    struct CheckedIn has copy, drop {
        campaign_id: 0x2::object::ID,
        user: address,
        day: u64,
        points: u64,
        streak: u64,
        user_total_check_ins: u64,
        campaign_total_check_ins: u64,
        timestamp_ms: u64,
    }

    public fun check_in(arg0: &GlobalConfig, arg1: &mut CheckInCampaign, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current(arg0);
        assert_campaign_current(arg1);
        assert!(arg1.enabled, 2);
        assert_campaign_bindings(arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = check_in_day_at(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let (v3, v4) = record_check_in(arg1, v2, v1, v0);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::router::add_point_by_admin(arg2, &arg1.point_cap, arg3, arg1.points_per_check_in, 1, v2);
        let v5 = CheckedIn{
            campaign_id              : 0x2::object::id<CheckInCampaign>(arg1),
            user                     : v2,
            day                      : v1,
            points                   : arg1.points_per_check_in,
            streak                   : v3,
            user_total_check_ins     : v4,
            campaign_total_check_ins : arg1.total_check_ins,
            timestamp_ms             : v0,
        };
        0x2::event::emit<CheckedIn>(v5);
    }

    public fun allow_config_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg2);
        };
        let v0 = VersionUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg2,
            allowed   : true,
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u64> {
        0x2::vec_set::into_keys<u64>(arg0.allowed_versions)
    }

    fun assert_campaign_bindings(arg0: &CheckInCampaign, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg1, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::router_domain());
        assert!(arg0.liquidlink_config_id == 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig>(arg1), 6);
        assert!(arg0.scoreboard_id == 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard>(arg2), 6);
        assert!(arg0.point_cap_id == 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap>(&arg0.point_cap), 6);
        assert!(arg0.project_id == *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::get_point_cap_project_ID(&arg0.point_cap), 6);
        assert_scoreboard_match(&arg0.point_cap, arg2);
    }

    fun assert_campaign_current(arg0: &CheckInCampaign) {
        assert!(arg0.version == 1, 0);
    }

    fun assert_current(arg0: &GlobalConfig) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 0);
        assert!(!arg0.paused, 1);
    }

    fun assert_scoreboard_match(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard) {
        assert!(*0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::get_point_cap_project_ID(arg0) == *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_scoreboard_project_ID(arg1), 6);
    }

    fun assert_valid_schedule(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 3);
        assert!(arg2 > 0, 4);
        assert!(arg1 <= 86399999, 5);
        assert!(arg1 < arg2, 5);
    }

    public fun campaign_day_length_ms(arg0: &CheckInCampaign) : u64 {
        arg0.day_length_ms
    }

    public fun campaign_enabled(arg0: &CheckInCampaign) : bool {
        arg0.enabled
    }

    public fun campaign_points_per_check_in(arg0: &CheckInCampaign) : u64 {
        arg0.points_per_check_in
    }

    public fun campaign_project_id(arg0: &CheckInCampaign) : 0x2::object::ID {
        arg0.project_id
    }

    public fun campaign_reset_offset_ms(arg0: &CheckInCampaign) : u64 {
        arg0.reset_offset_ms
    }

    public fun campaign_scoreboard_id(arg0: &CheckInCampaign) : 0x2::object::ID {
        arg0.scoreboard_id
    }

    public fun campaign_total_check_ins(arg0: &CheckInCampaign) : u64 {
        arg0.total_check_ins
    }

    public fun check_in_day(arg0: &CheckInCampaign, arg1: &0x2::clock::Clock) : u64 {
        check_in_day_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun check_in_day_at(arg0: &CheckInCampaign, arg1: u64) : u64 {
        if (arg1 < arg0.reset_offset_ms) {
            0
        } else {
            (arg1 - arg0.reset_offset_ms) / arg0.day_length_ms
        }
    }

    public fun create_campaign_by_admin(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg3: 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap, arg4: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_campaign(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_share_object<CheckInCampaign>(v0);
        0x2::object::id<CheckInCampaign>(&v0)
    }

    public fun current_version() : u64 {
        1
    }

    public fun disallow_config_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg2);
        };
        let v0 = VersionUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            version   : arg2,
            allowed   : false,
        };
        0x2::event::emit<VersionUpdated>(v0);
    }

    public fun has_checked_in_today(arg0: &CheckInCampaign, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, UserCheckIn>(&arg0.users, arg1)) {
            return false
        };
        0x2::table::borrow<address, UserCheckIn>(&arg0.users, arg1).last_day == check_in_day(arg0, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(new_global_config(arg0));
    }

    fun new_campaign(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg3: 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap, arg4: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : CheckInCampaign {
        assert_current(arg0);
        assert_valid_schedule(arg5, arg6, arg7);
        assert_scoreboard_match(&arg3, arg4);
        let v0 = 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::PointCap>(&arg3);
        let v1 = *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap::get_point_cap_project_ID(&arg3);
        let v2 = CheckInCampaign{
            id                   : 0x2::object::new(arg8),
            version              : 1,
            enabled              : true,
            point_cap            : arg3,
            liquidlink_config_id : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig>(arg2),
            point_cap_id         : v0,
            scoreboard_id        : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard>(arg4),
            project_id           : v1,
            points_per_check_in  : arg5,
            reset_offset_ms      : arg6,
            day_length_ms        : arg7,
            total_check_ins      : 0,
            users                : 0x2::table::new<address, UserCheckIn>(arg8),
        };
        let v3 = CampaignCreated{
            campaign_id          : 0x2::object::id<CheckInCampaign>(&v2),
            liquidlink_config_id : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig>(arg2),
            point_cap_id         : v0,
            scoreboard_id        : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard>(arg4),
            project_id           : v1,
            points_per_check_in  : arg5,
            reset_offset_ms      : arg6,
            day_length_ms        : arg7,
        };
        0x2::event::emit<CampaignCreated>(v3);
        v2
    }

    fun new_global_config(arg0: &mut 0x2::tx_context::TxContext) : GlobalConfig {
        let v0 = 0x2::vec_set::empty<u64>();
        0x2::vec_set::insert<u64>(&mut v0, 1);
        let v1 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            allowed_versions : v0,
            paused           : false,
        };
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 1);
        let v3 = GlobalConfigCreated{
            config_id        : 0x2::object::id<GlobalConfig>(&v1),
            allowed_versions : v2,
        };
        0x2::event::emit<GlobalConfigCreated>(v3);
        v1
    }

    public fun next_reset_ms(arg0: &CheckInCampaign, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.reset_offset_ms) {
            arg0.reset_offset_ms
        } else {
            arg0.reset_offset_ms + (check_in_day_at(arg0, v0) + 1) * arg0.day_length_ms
        }
    }

    public fun paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    fun record_check_in(arg0: &mut CheckInCampaign, arg1: address, arg2: u64, arg3: u64) : (u64, u64) {
        if (!0x2::table::contains<address, UserCheckIn>(&arg0.users, arg1)) {
            let v0 = UserCheckIn{
                last_day              : arg2,
                streak                : 1,
                total_check_ins       : 1,
                last_checked_in_at_ms : arg3,
            };
            0x2::table::add<address, UserCheckIn>(&mut arg0.users, arg1, v0);
            arg0.total_check_ins = arg0.total_check_ins + 1;
            return (1, 1)
        };
        let v1 = 0x2::table::borrow_mut<address, UserCheckIn>(&mut arg0.users, arg1);
        assert!(v1.last_day != arg2, 7);
        let v2 = if (arg2 == v1.last_day + 1) {
            v1.streak + 1
        } else {
            1
        };
        v1.last_day = arg2;
        v1.streak = v2;
        v1.total_check_ins = v1.total_check_ins + 1;
        v1.last_checked_in_at_ms = arg3;
        arg0.total_check_ins = arg0.total_check_ins + 1;
        (v2, v1.total_check_ins)
    }

    public fun set_campaign_config_by_admin(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &mut CheckInCampaign, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        assert_current(arg0);
        assert_campaign_current(arg2);
        assert_valid_schedule(arg3, arg4, arg5);
        arg2.points_per_check_in = arg3;
        arg2.reset_offset_ms = arg4;
        arg2.day_length_ms = arg5;
        arg2.enabled = arg6;
        let v0 = CampaignConfigUpdated{
            campaign_id         : 0x2::object::id<CheckInCampaign>(arg2),
            points_per_check_in : arg3,
            reset_offset_ms     : arg4,
            day_length_ms       : arg5,
            enabled             : arg6,
        };
        0x2::event::emit<CampaignConfigUpdated>(v0);
    }

    public fun set_campaign_enabled_by_admin(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &mut CheckInCampaign, arg3: bool) {
        assert_current(arg0);
        assert_campaign_current(arg2);
        arg2.enabled = arg3;
        let v0 = CampaignPauseUpdated{
            campaign_id : 0x2::object::id<CheckInCampaign>(arg2),
            enabled     : arg3,
        };
        0x2::event::emit<CampaignPauseUpdated>(v0);
    }

    public fun set_global_paused(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = GlobalPauseUpdated{
            config_id : 0x2::object::id<GlobalConfig>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<GlobalPauseUpdated>(v0);
    }

    public fun user_check_in_info(arg0: &CheckInCampaign, arg1: address) : UserCheckIn {
        assert!(0x2::table::contains<address, UserCheckIn>(&arg0.users, arg1), 8);
        *0x2::table::borrow<address, UserCheckIn>(&arg0.users, arg1)
    }

    public fun user_last_checked_in_at_ms(arg0: &CheckInCampaign, arg1: address) : u64 {
        let v0 = user_check_in_info(arg0, arg1);
        v0.last_checked_in_at_ms
    }

    public fun user_last_day(arg0: &CheckInCampaign, arg1: address) : u64 {
        let v0 = user_check_in_info(arg0, arg1);
        v0.last_day
    }

    public fun user_streak(arg0: &CheckInCampaign, arg1: address) : u64 {
        let v0 = user_check_in_info(arg0, arg1);
        v0.streak
    }

    public fun user_total_check_ins(arg0: &CheckInCampaign, arg1: address) : u64 {
        let v0 = user_check_in_info(arg0, arg1);
        v0.total_check_ins
    }

    public fun version_allowed(arg0: &GlobalConfig, arg1: u64) : bool {
        0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1)
    }

    // decompiled from Move bytecode v7
}

