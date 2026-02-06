module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry {
    struct TemplateRegistry has key {
        id: 0x2::object::UID,
        templates_by_creator: 0x2::table::Table<address, vector<address>>,
        active_templates: vector<address>,
        metadata: 0x2::table::Table<address, TemplateMetadata>,
        active_count: u64,
    }

    struct TemplateMetadata has copy, drop, store {
        template_id: address,
        creator: address,
        height: u64,
        share_count: u64,
        total_stake: u64,
        is_active: bool,
        created_at_ms: u64,
    }

    struct TemplateIndexed has copy, drop {
        template_id: address,
        creator: address,
        height: u64,
        timestamp_ms: u64,
    }

    struct TemplateDeactivated has copy, drop {
        template_id: address,
        creator: address,
        timestamp_ms: u64,
    }

    struct StakeUpdated has copy, drop {
        template_id: address,
        old_stake: u64,
        new_stake: u64,
    }

    struct ShareCountUpdated has copy, drop {
        template_id: address,
        new_share_count: u64,
    }

    struct TemplateScore has copy, drop, store {
        template_id: address,
        score: u128,
        creator: address,
        height: u64,
        share_count: u64,
        total_stake: u64,
    }

    public fun deactivate_in_index(arg0: &mut TemplateRegistry, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, TemplateMetadata>(&mut arg0.metadata, arg1);
        if (!v0.is_active) {
            return
        };
        v0.is_active = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.active_templates)) {
            if (*0x1::vector::borrow<address>(&arg0.active_templates, v1) == arg1) {
                0x1::vector::remove<address>(&mut arg0.active_templates, v1);
                arg0.active_count = arg0.active_count - 1;
                break
            };
            v1 = v1 + 1;
        };
        let v2 = TemplateDeactivated{
            template_id  : arg1,
            creator      : v0.creator,
            timestamp_ms : arg2,
        };
        0x2::event::emit<TemplateDeactivated>(v2);
    }

    public fun get_active_count(arg0: &TemplateRegistry) : u64 {
        arg0.active_count
    }

    public fun get_active_template_for_creator(arg0: &TemplateRegistry, arg1: address) : address {
        if (!0x2::table::contains<address, vector<address>>(&arg0.templates_by_creator, arg1)) {
            return @0x0
        };
        let v0 = 0x2::table::borrow<address, vector<address>>(&arg0.templates_by_creator, arg1);
        let v1 = 0x1::vector::length<address>(v0);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = *0x1::vector::borrow<address>(v0, v1);
            if (0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, v2)) {
                if (0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, v2).is_active) {
                    return v2
                };
            };
        };
        @0x0
    }

    public fun get_active_templates(arg0: &TemplateRegistry) : vector<address> {
        arg0.active_templates
    }

    public fun get_combined_leader(arg0: &TemplateRegistry) : (address, u128) {
        let v0 = @0x0;
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0.active_templates)) {
            let v4 = *0x1::vector::borrow<address>(&arg0.active_templates, v3);
            if (0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, v4)) {
                let v5 = 0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, v4);
                if (v5.is_active) {
                    let v6 = (v5.total_stake as u128) * (v5.share_count as u128);
                    if (v6 > v1) {
                        v2 = v6;
                        v0 = v4;
                    };
                };
            };
            v3 = v3 + 1;
        };
        (v0, v2)
    }

    public fun get_highest_shares_template(arg0: &TemplateRegistry) : (address, u64) {
        let v0 = @0x0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.active_templates)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.active_templates, v2);
            if (0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, v3)) {
                let v4 = 0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, v3);
                if (v4.is_active && v4.share_count > v1) {
                    v1 = v4.share_count;
                    v0 = v3;
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_highest_stake_template(arg0: &TemplateRegistry) : (address, u64) {
        let v0 = @0x0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.active_templates)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.active_templates, v2);
            if (0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, v3)) {
                let v4 = 0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, v3);
                if (v4.is_active && v4.total_stake > v1) {
                    v1 = v4.total_stake;
                    v0 = v3;
                };
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_template_metadata(arg0: &TemplateRegistry, arg1: address) : (address, u64, u64, u64, bool) {
        if (!0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1)) {
            return (@0x0, 0, 0, 0, false)
        };
        let v0 = 0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, arg1);
        (v0.creator, v0.height, v0.share_count, v0.total_stake, v0.is_active)
    }

    public fun get_templates_by_creator(arg0: &TemplateRegistry, arg1: address) : vector<address> {
        if (!0x2::table::contains<address, vector<address>>(&arg0.templates_by_creator, arg1)) {
            return 0x1::vector::empty<address>()
        };
        *0x2::table::borrow<address, vector<address>>(&arg0.templates_by_creator, arg1)
    }

    public fun get_top_templates(arg0: &TemplateRegistry, arg1: u8, arg2: u64) : vector<TemplateScore> {
        assert!(arg2 > 0 && arg2 <= 100, 203);
        let v0 = 0x1::vector::empty<TemplateScore>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.active_templates)) {
            let v2 = *0x1::vector::borrow<address>(&arg0.active_templates, v1);
            if (0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, v2)) {
                let v3 = 0x2::table::borrow<address, TemplateMetadata>(&arg0.metadata, v2);
                if (v3.is_active) {
                    let v4 = if (arg1 == 0) {
                        (v3.total_stake as u128)
                    } else if (arg1 == 1) {
                        (v3.share_count as u128)
                    } else {
                        (v3.total_stake as u128) * (v3.share_count as u128)
                    };
                    let v5 = TemplateScore{
                        template_id : v2,
                        score       : v4,
                        creator     : v3.creator,
                        height      : v3.height,
                        share_count : v3.share_count,
                        total_stake : v3.total_stake,
                    };
                    0x1::vector::push_back<TemplateScore>(&mut v0, v5);
                };
            };
            v1 = v1 + 1;
        };
        let v6 = 0x1::vector::length<TemplateScore>(&v0);
        if (v6 > 1) {
            let v7 = 0;
            while (v7 < v6 - 1) {
                let v8 = 0;
                while (v8 < v6 - v7 - 1) {
                    if (0x1::vector::borrow<TemplateScore>(&v0, v8).score < 0x1::vector::borrow<TemplateScore>(&v0, v8 + 1).score) {
                        0x1::vector::swap<TemplateScore>(&mut v0, v8, v8 + 1);
                    };
                    v8 = v8 + 1;
                };
                v7 = v7 + 1;
            };
        };
        while (0x1::vector::length<TemplateScore>(&v0) > arg2) {
            0x1::vector::pop_back<TemplateScore>(&mut v0);
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TemplateRegistry{
            id                   : 0x2::object::new(arg0),
            templates_by_creator : 0x2::table::new<address, vector<address>>(arg0),
            active_templates     : 0x1::vector::empty<address>(),
            metadata             : 0x2::table::new<address, TemplateMetadata>(arg0),
            active_count         : 0,
        };
        0x2::transfer::share_object<TemplateRegistry>(v0);
    }

    public fun is_template_registered(arg0: &TemplateRegistry, arg1: address) : bool {
        0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1)
    }

    public fun register_in_index(arg0: &mut TemplateRegistry, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        assert!(!0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1), 201);
        let v0 = TemplateMetadata{
            template_id   : arg1,
            creator       : arg2,
            height        : arg3,
            share_count   : 0,
            total_stake   : 0,
            is_active     : true,
            created_at_ms : arg4,
        };
        0x2::table::add<address, TemplateMetadata>(&mut arg0.metadata, arg1, v0);
        0x1::vector::push_back<address>(&mut arg0.active_templates, arg1);
        arg0.active_count = arg0.active_count + 1;
        if (!0x2::table::contains<address, vector<address>>(&arg0.templates_by_creator, arg2)) {
            0x2::table::add<address, vector<address>>(&mut arg0.templates_by_creator, arg2, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.templates_by_creator, arg2), arg1);
        let v1 = TemplateIndexed{
            template_id  : arg1,
            creator      : arg2,
            height       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<TemplateIndexed>(v1);
    }

    public fun update_share_count(arg0: &mut TemplateRegistry, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1)) {
            return
        };
        0x2::table::borrow_mut<address, TemplateMetadata>(&mut arg0.metadata, arg1).share_count = arg2;
        let v0 = ShareCountUpdated{
            template_id     : arg1,
            new_share_count : arg2,
        };
        0x2::event::emit<ShareCountUpdated>(v0);
    }

    public fun update_stake(arg0: &mut TemplateRegistry, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, TemplateMetadata>(&arg0.metadata, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, TemplateMetadata>(&mut arg0.metadata, arg1);
        v0.total_stake = arg2;
        let v1 = StakeUpdated{
            template_id : arg1,
            old_stake   : v0.total_stake,
            new_stake   : arg2,
        };
        0x2::event::emit<StakeUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

