module 0x25b8b326943a89464c15fc3cdbacb25ca5ca9858827f212046f8bf0d8f744ad0::agent_pass {
    struct AgentPass has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        coin: 0x1::option::Option<0x1::type_name::TypeName>,
        spender: address,
        paused: bool,
        max_daily_limit: u64,
        max_duration_ms: u64,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
    }

    struct GuardianKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PassIssued has copy, drop {
        funder: address,
        daily_limit: u256,
        expires_at_ms: u64,
    }

    struct PausedSet has copy, drop {
        paused: bool,
    }

    struct SpenderSet has copy, drop {
        spender: address,
    }

    struct PassRotated has copy, drop {
        allowance: 0x2::object::ID,
        spender: address,
    }

    struct LimitsSet has copy, drop {
        max_daily_limit: u64,
        max_duration_ms: u64,
    }

    struct GuardianIssued has copy, drop {
        guardian: 0x2::object::ID,
        to: address,
    }

    struct GuardianPaused has copy, drop {
        guardian: 0x2::object::ID,
    }

    public fun issue<T0>(arg0: &Config, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg0);
        assert!(arg0.coin == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()), 13835903025673666569);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg1);
        let (v1, v2) = check_terms(arg0, 0x2::allowance::spender(v0), 0x2::allowance::start_timestamp_ms(v0), 0x2::allowance::expiration_timestamp_ms(v0), 0x2::allowance::rate_limit(v0), 0x2::clock::timestamp_ms(arg2));
        0x2::allowance::issue<0x2::balance::Balance<T0>, AgentPass>(arg1, 0x2::allowance::settings_permit<AgentPass>(0x1::internal::permit<AgentPass>()), arg3);
        let v3 = PassIssued{
            funder        : 0x2::allowance::funder(v0),
            daily_limit   : v1,
            expires_at_ms : v2,
        };
        0x2::event::emit<PassIssued>(v3);
    }

    public fun spend_permit(arg0: &Config, arg1: &0x2::tx_context::TxContext) : 0x2::allowance::SpendPermit<AgentPass> {
        assert_live(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.spender, 13835621632301203463);
        0x2::allowance::spend_permit<AgentPass>(0x1::internal::permit<AgentPass>())
    }

    public fun spender(arg0: &Config) : address {
        arg0.spender
    }

    fun assert_live(arg0: &Config) {
        assert!(arg0.version == 1, 13835340595411025925);
        assert!(!arg0.paused, 13835059124729151491);
    }

    public fun check_terms(arg0: &Config, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<0x2::allowance::RateLimit>, arg5: u64) : (u256, u64) {
        assert!(arg1 == 0x1::option::some<address>(arg0.spender), 13836184638089461771);
        assert!(0x1::option::is_none<u64>(&arg2), 13837592017268637717);
        assert!(0x1::option::is_some<u64>(&arg3), 13836466121656238093);
        let v0 = 0x1::option::destroy_some<u64>(arg3);
        assert!(v0 > arg5 && v0 - arg5 <= arg0.max_duration_ms, 13836747605223014415);
        assert!(0x1::option::is_some<0x2::allowance::RateLimit>(&arg4), 13837029084494823441);
        let v1 = 0x1::option::destroy_some<0x2::allowance::RateLimit>(arg4);
        let v2 = 0x2::allowance::rate_limit_limit(&v1);
        assert!(v2 <= (arg0.max_daily_limit as u256), 13837310572356567059);
        assert!(v1 == 0x2::allowance::periodic_rate_limit(86400000, v2), 13837029101674692625);
        (v2, v0)
    }

    public fun guardian_pause(arg0: &mut Config, arg1: &GuardianCap) {
        assert!(arg0.version == 1, 13835340436497235973);
        let v0 = GuardianKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<GuardianKey>(&arg0.id, v0)) {
            let v2 = GuardianKey{dummy_field: false};
            *0x2::dynamic_field::borrow<GuardianKey, 0x2::object::ID>(&arg0.id, v2) == 0x2::object::id<GuardianCap>(arg1)
        } else {
            false
        };
        assert!(v1, 13838436678422364187);
        arg0.paused = true;
        let v3 = GuardianPaused{guardian: 0x2::object::id<GuardianCap>(arg1)};
        0x2::event::emit<GuardianPaused>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id              : 0x2::object::new(arg0),
            version         : 1,
            coin            : 0x1::option::none<0x1::type_name::TypeName>(),
            spender         : 0x2::tx_context::sender(arg0),
            paused          : true,
            max_daily_limit : 1000000000,
            max_duration_ms : 90 * 86400000,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun issue_guardian(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13835340376367693829);
        let v0 = GuardianCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<GuardianCap>(&v0);
        let v2 = GuardianKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GuardianKey>(&arg0.id, v2)) {
            let v3 = GuardianKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<GuardianKey, 0x2::object::ID>(&mut arg0.id, v3) = v1;
        } else {
            let v4 = GuardianKey{dummy_field: false};
            0x2::dynamic_field::add<GuardianKey, 0x2::object::ID>(&mut arg0.id, v4, v1);
        };
        0x2::transfer::transfer<GuardianCap>(v0, arg2);
        let v5 = GuardianIssued{
            guardian : v1,
            to       : arg2,
        };
        0x2::event::emit<GuardianIssued>(v5);
    }

    public fun max_daily_limit(arg0: &Config) : u64 {
        arg0.max_daily_limit
    }

    public fun max_duration_ms(arg0: &Config) : u64 {
        arg0.max_duration_ms
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 1, 13838155293639835673);
        arg0.version = 1;
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun rotate<T0>(arg0: &Config, arg1: &AdminCap, arg2: &mut 0x2::allowance::Allowance<T0>) {
        assert!(arg0.version == 1, 13835340346302922757);
        0x2::allowance::rotate_spender<T0, AgentPass>(arg2, 0x2::allowance::settings_permit<AgentPass>(0x1::internal::permit<AgentPass>()), arg0.spender);
        let v0 = PassRotated{
            allowance : 0x2::object::id<0x2::allowance::Allowance<T0>>(arg2),
            spender   : arg0.spender,
        };
        0x2::event::emit<PassRotated>(v0);
    }

    public fun set_coin<T0>(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version == 1, 13835340483741876229);
        arg0.coin = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    public fun set_limits(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert!(arg0.version == 1, 13835340505216712709);
        assert!(arg2 > 0 && arg3 > 0, 13837873784303255575);
        arg0.max_daily_limit = arg2;
        arg0.max_duration_ms = arg3;
        let v0 = LimitsSet{
            max_daily_limit : arg2,
            max_duration_ms : arg3,
        };
        0x2::event::emit<LimitsSet>(v0);
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        assert!(arg0.version == 1, 13835340286173380613);
        arg0.paused = arg2;
        let v0 = PausedSet{paused: arg2};
        0x2::event::emit<PausedSet>(v0);
    }

    public fun set_spender(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert!(arg0.version == 1, 13835340316238151685);
        arg0.spender = arg2;
        let v0 = SpenderSet{spender: arg2};
        0x2::event::emit<SpenderSet>(v0);
    }

    // decompiled from Move bytecode v7
}

