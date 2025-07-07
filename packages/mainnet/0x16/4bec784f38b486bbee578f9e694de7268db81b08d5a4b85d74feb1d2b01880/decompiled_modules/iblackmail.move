module 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::iblackmail {
    struct PlayerBlackmailInfo has key {
        id: 0x2::object::UID,
        defending_resource: u8,
        blackmail_success: u64,
        blackmail_failed: u64,
    }

    struct Range has store {
        min: u64,
        max: u64,
    }

    struct LootProtection has store {
        very_easy: Range,
        easy: Range,
        normal: Range,
        hard: Range,
        very_hard: Range,
    }

    struct LPModifier has store {
        attacking_higher: u64,
        attacking_lower: u64,
        attacking_same: u64,
        min_success: u64,
        max_success: u64,
        base: u64,
        failed: u64,
    }

    struct BlackmailRegistry has key {
        id: 0x2::object::UID,
        attacker_cooldown_duration: Range,
        target_cooldown_duration: Range,
        resource_hidden_penalty: u64,
        base_success: u64,
        higher_level_penalty: u64,
        lower_level_bonus: u64,
        min_success: u64,
        max_success: u64,
        lp_modifier: LPModifier,
        loot_percentage: LootProtection,
    }

    struct BlackmailType has key {
        id: 0x2::object::UID,
        resource_type: 0x1::string::String,
    }

    public fun borrow_blackmail_registry(arg0: &BlackmailRegistry) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.attacker_cooldown_duration.min);
        0x1::vector::push_back<u64>(v1, arg0.attacker_cooldown_duration.max);
        0x1::vector::push_back<u64>(v1, arg0.target_cooldown_duration.min);
        0x1::vector::push_back<u64>(v1, arg0.target_cooldown_duration.max);
        0x1::vector::push_back<u64>(v1, arg0.resource_hidden_penalty);
        0x1::vector::push_back<u64>(v1, arg0.base_success);
        0x1::vector::push_back<u64>(v1, arg0.higher_level_penalty);
        0x1::vector::push_back<u64>(v1, arg0.lower_level_bonus);
        0x1::vector::push_back<u64>(v1, arg0.min_success);
        0x1::vector::push_back<u64>(v1, arg0.max_success);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.attacking_higher);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.attacking_lower);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.attacking_same);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.min_success);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.max_success);
        0x1::vector::push_back<u64>(v1, arg0.lp_modifier.base);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.very_easy.min);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.very_easy.max);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.easy.min);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.easy.max);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.normal.min);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.normal.max);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.hard.min);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.hard.max);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.very_hard.min);
        0x1::vector::push_back<u64>(v1, arg0.loot_percentage.very_hard.max);
        v0
    }

    public fun borrow_blackmail_resource_type(arg0: &BlackmailType) : 0x1::string::String {
        arg0.resource_type
    }

    public fun create_blackmail_info(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PlayerBlackmailInfo{
            id                 : 0x2::object::new(arg0),
            defending_resource : 0,
            blackmail_success  : 0,
            blackmail_failed   : 0,
        };
        0x2::transfer::share_object<PlayerBlackmailInfo>(v0);
        0x2::object::id<PlayerBlackmailInfo>(&v0)
    }

    public(friend) fun get_blackmail_defending_resource(arg0: &PlayerBlackmailInfo) : u8 {
        arg0.defending_resource
    }

    public(friend) fun get_blackmail_failed_count(arg0: &PlayerBlackmailInfo) : u64 {
        arg0.blackmail_success
    }

    public(friend) fun get_blackmail_success_count(arg0: &PlayerBlackmailInfo) : u64 {
        arg0.blackmail_success
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BlackmailRegistry>(new_blackmail_registry(arg0));
    }

    public fun new_blackmail_info(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap, arg1: &mut 0x2::tx_context::TxContext) : PlayerBlackmailInfo {
        PlayerBlackmailInfo{
            id                 : 0x2::object::new(arg1),
            defending_resource : 0,
            blackmail_success  : 0,
            blackmail_failed   : 0,
        }
    }

    public(friend) fun new_blackmail_registry(arg0: &mut 0x2::tx_context::TxContext) : BlackmailRegistry {
        let v0 = Range{
            min : 0,
            max : 0,
        };
        let v1 = Range{
            min : 0,
            max : 0,
        };
        let v2 = LPModifier{
            attacking_higher : 0,
            attacking_lower  : 0,
            attacking_same   : 0,
            min_success      : 0,
            max_success      : 0,
            base             : 0,
            failed           : 0,
        };
        let v3 = Range{
            min : 0,
            max : 0,
        };
        let v4 = Range{
            min : 0,
            max : 0,
        };
        let v5 = Range{
            min : 0,
            max : 0,
        };
        let v6 = Range{
            min : 0,
            max : 0,
        };
        let v7 = Range{
            min : 0,
            max : 0,
        };
        let v8 = LootProtection{
            very_easy : v3,
            easy      : v4,
            normal    : v5,
            hard      : v6,
            very_hard : v7,
        };
        BlackmailRegistry{
            id                         : 0x2::object::new(arg0),
            attacker_cooldown_duration : v0,
            target_cooldown_duration   : v1,
            resource_hidden_penalty    : 0,
            base_success               : 0,
            higher_level_penalty       : 0,
            lower_level_bonus          : 0,
            min_success                : 0,
            max_success                : 0,
            lp_modifier                : v2,
            loot_percentage            : v8,
        }
    }

    public(friend) fun new_blackmail_type(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlackmailType{
            id            : 0x2::object::new(arg1),
            resource_type : arg0,
        };
        0x2::transfer::share_object<BlackmailType>(v0);
    }

    public(friend) fun set_blackmail_config(arg0: &mut BlackmailRegistry, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        arg0.attacker_cooldown_duration.min = *0x1::vector::borrow<u64>(&arg1, 0);
        arg0.attacker_cooldown_duration.max = *0x1::vector::borrow<u64>(&arg1, 1);
        arg0.target_cooldown_duration.min = *0x1::vector::borrow<u64>(&arg1, 2);
        arg0.target_cooldown_duration.max = *0x1::vector::borrow<u64>(&arg1, 3);
        arg0.resource_hidden_penalty = *0x1::vector::borrow<u64>(&arg2, 0);
        arg0.base_success = *0x1::vector::borrow<u64>(&arg2, 1);
        arg0.higher_level_penalty = *0x1::vector::borrow<u64>(&arg2, 2);
        arg0.lower_level_bonus = *0x1::vector::borrow<u64>(&arg2, 3);
        arg0.min_success = *0x1::vector::borrow<u64>(&arg2, 4);
        arg0.max_success = *0x1::vector::borrow<u64>(&arg2, 5);
        arg0.lp_modifier.attacking_higher = *0x1::vector::borrow<u64>(&arg3, 0);
        arg0.lp_modifier.attacking_lower = *0x1::vector::borrow<u64>(&arg3, 1);
        arg0.lp_modifier.attacking_same = *0x1::vector::borrow<u64>(&arg3, 2);
        arg0.lp_modifier.min_success = *0x1::vector::borrow<u64>(&arg3, 3);
        arg0.lp_modifier.max_success = *0x1::vector::borrow<u64>(&arg3, 4);
        arg0.lp_modifier.base = *0x1::vector::borrow<u64>(&arg3, 5);
        arg0.lp_modifier.failed = *0x1::vector::borrow<u64>(&arg3, 6);
        arg0.loot_percentage.very_easy.min = *0x1::vector::borrow<u64>(&arg4, 0);
        arg0.loot_percentage.very_easy.max = *0x1::vector::borrow<u64>(&arg4, 1);
        arg0.loot_percentage.easy.min = *0x1::vector::borrow<u64>(&arg4, 2);
        arg0.loot_percentage.easy.max = *0x1::vector::borrow<u64>(&arg4, 3);
        arg0.loot_percentage.normal.min = *0x1::vector::borrow<u64>(&arg4, 4);
        arg0.loot_percentage.normal.max = *0x1::vector::borrow<u64>(&arg4, 5);
        arg0.loot_percentage.hard.min = *0x1::vector::borrow<u64>(&arg4, 6);
        arg0.loot_percentage.hard.max = *0x1::vector::borrow<u64>(&arg4, 7);
        arg0.loot_percentage.very_hard.min = *0x1::vector::borrow<u64>(&arg4, 8);
        arg0.loot_percentage.very_hard.max = *0x1::vector::borrow<u64>(&arg4, 9);
    }

    public fun set_blackmail_defending_resource(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap, arg1: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::Version, arg2: &mut PlayerBlackmailInfo, arg3: u8) {
        0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_version::validate_version(arg1);
        arg2.defending_resource = arg3;
    }

    public(friend) fun set_blackmail_failed_count(arg0: &mut PlayerBlackmailInfo, arg1: u64) {
        arg0.blackmail_failed = arg0.blackmail_failed + arg1;
    }

    public(friend) fun set_blackmail_resource_type(arg0: &mut BlackmailType, arg1: 0x1::string::String) {
        arg0.resource_type = arg1;
    }

    public(friend) fun set_blackmail_success_count(arg0: &mut PlayerBlackmailInfo, arg1: u64) {
        arg0.blackmail_success = arg0.blackmail_success + arg1;
    }

    public fun share_blackmail(arg0: &0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::crimes_authority::CrimesCap, arg1: PlayerBlackmailInfo) {
        0x2::transfer::share_object<PlayerBlackmailInfo>(arg1);
    }

    // decompiled from Move bytecode v6
}

