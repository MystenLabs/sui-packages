module 0xcd22dacf4d38126acb78ad21f04093b1fe9a81d23376ebb2f70b36eaf6dc4f5f::record_audience {
    struct RecordAudience has key {
        id: 0x2::object::UID,
        rules: 0x2::table::Table<0x2::object::ID, RecordAudienceRule>,
    }

    struct RecordAudienceAdminCap has store, key {
        id: 0x2::object::UID,
        audience_id: 0x2::object::ID,
    }

    struct RecordAudienceRule has copy, drop, store {
        edition_min: 0x1::option::Option<u16>,
        edition_max: 0x1::option::Option<u16>,
        number_min: 0x1::option::Option<u32>,
        number_max: 0x1::option::Option<u32>,
    }

    struct RecordAudienceCreatedEvent has copy, drop {
        audience_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct RecordAudienceRuleSetEvent has copy, drop {
        audience_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        rule: RecordAudienceRule,
    }

    struct RecordAudienceRuleRemovedEvent has copy, drop {
        audience_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (RecordAudience, RecordAudienceAdminCap) {
        let v0 = RecordAudience{
            id    : 0x2::object::new(arg0),
            rules : 0x2::table::new<0x2::object::ID, RecordAudienceRule>(arg0),
        };
        let v1 = 0x2::object::id<RecordAudience>(&v0);
        let v2 = RecordAudienceAdminCap{
            id          : 0x2::object::new(arg0),
            audience_id : v1,
        };
        let v3 = RecordAudienceCreatedEvent{
            audience_id  : v1,
            admin_cap_id : 0x2::object::id<RecordAudienceAdminCap>(&v2),
        };
        0x2::event::emit<RecordAudienceCreatedEvent>(v3);
        (v0, v2)
    }

    public fun admits(arg0: &RecordAudience, arg1: 0x2::object::ID, arg2: u16, arg3: u32) : bool {
        if (!0x2::table::contains<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg1);
        let v1 = v0.edition_max;
        let v2 = v0.edition_min;
        let v3 = &v2;
        let v4 = if (0x1::option::is_none<u16>(v3) || arg2 >= *0x1::option::borrow<u16>(v3)) {
            let v5 = &v1;
            0x1::option::is_none<u16>(v5) || arg2 <= *0x1::option::borrow<u16>(v5)
        } else {
            false
        };
        if (v4) {
            let v7 = v0.number_max;
            let v8 = v0.number_min;
            let v9 = &v8;
            if (0x1::option::is_none<u32>(v9) || arg3 >= *0x1::option::borrow<u32>(v9)) {
                let v10 = &v7;
                0x1::option::is_none<u32>(v10) || arg3 <= *0x1::option::borrow<u32>(v10)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun has_rule(arg0: &RecordAudience, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg1)
    }

    public fun max_rules() : u64 {
        1000
    }

    public fun new_rule(arg0: 0x1::option::Option<u16>, arg1: 0x1::option::Option<u16>, arg2: 0x1::option::Option<u32>, arg3: 0x1::option::Option<u32>) : RecordAudienceRule {
        let v0 = &arg0;
        let v1 = if (0x1::option::is_none<u16>(v0)) {
            true
        } else {
            let v2 = 0x1::option::borrow<u16>(v0);
            let v3 = &arg1;
            0x1::option::is_none<u16>(v3) || *v2 <= *0x1::option::borrow<u16>(v3)
        };
        assert!(v1, 2);
        let v4 = &arg2;
        let v5 = if (0x1::option::is_none<u32>(v4)) {
            true
        } else {
            let v6 = 0x1::option::borrow<u32>(v4);
            let v7 = &arg3;
            0x1::option::is_none<u32>(v7) || *v6 <= *0x1::option::borrow<u32>(v7)
        };
        assert!(v5, 2);
        RecordAudienceRule{
            edition_min : arg0,
            edition_max : arg1,
            number_min  : arg2,
            number_max  : arg3,
        }
    }

    public fun record_audience_admin_cap_audience_id(arg0: &RecordAudienceAdminCap) : 0x2::object::ID {
        arg0.audience_id
    }

    public fun record_audience_rule_edition_max(arg0: &RecordAudienceRule) : 0x1::option::Option<u16> {
        arg0.edition_max
    }

    public fun record_audience_rule_edition_min(arg0: &RecordAudienceRule) : 0x1::option::Option<u16> {
        arg0.edition_min
    }

    public fun record_audience_rule_number_max(arg0: &RecordAudienceRule) : 0x1::option::Option<u32> {
        arg0.number_max
    }

    public fun record_audience_rule_number_min(arg0: &RecordAudienceRule) : 0x1::option::Option<u32> {
        arg0.number_min
    }

    public fun remove_rule(arg0: &mut RecordAudience, arg1: &RecordAudienceAdminCap, arg2: 0x2::object::ID) {
        assert!(arg1.audience_id == 0x2::object::id<RecordAudience>(arg0), 0);
        if (!0x2::table::contains<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, RecordAudienceRule>(&mut arg0.rules, arg2);
        let v0 = RecordAudienceRuleRemovedEvent{
            audience_id : 0x2::object::id<RecordAudience>(arg0),
            release_id  : arg2,
        };
        0x2::event::emit<RecordAudienceRuleRemovedEvent>(v0);
    }

    public fun rule(arg0: &RecordAudience, arg1: 0x2::object::ID) : RecordAudienceRule {
        assert!(0x2::table::contains<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg1), 3);
        *0x2::table::borrow<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg1)
    }

    public fun rule_count(arg0: &RecordAudience) : u64 {
        0x2::table::length<0x2::object::ID, RecordAudienceRule>(&arg0.rules)
    }

    public fun set_rule(arg0: &mut RecordAudience, arg1: &RecordAudienceAdminCap, arg2: 0x2::object::ID, arg3: RecordAudienceRule) {
        assert!(arg1.audience_id == 0x2::object::id<RecordAudience>(arg0), 0);
        if (0x2::table::contains<0x2::object::ID, RecordAudienceRule>(&arg0.rules, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, RecordAudienceRule>(&mut arg0.rules, arg2);
            if (*v0 == arg3) {
                return
            };
            *v0 = arg3;
        } else {
            assert!(0x2::table::length<0x2::object::ID, RecordAudienceRule>(&arg0.rules) < 1000, 1);
            0x2::table::add<0x2::object::ID, RecordAudienceRule>(&mut arg0.rules, arg2, arg3);
        };
        let v1 = RecordAudienceRuleSetEvent{
            audience_id : 0x2::object::id<RecordAudience>(arg0),
            release_id  : arg2,
            rule        : arg3,
        };
        0x2::event::emit<RecordAudienceRuleSetEvent>(v1);
    }

    public fun share(arg0: RecordAudience) {
        0x2::transfer::share_object<RecordAudience>(arg0);
    }

    // decompiled from Move bytecode v7
}

