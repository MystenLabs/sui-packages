module 0x3754acc5912fe974aa290ee9e6d5ff6f07674d48f4f3c22c72b3499b34945874::action_spec_builder {
    struct PendingBorrow has copy, drop {
        cap_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
    }

    struct Builder has copy, drop {
        specs: vector<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>,
        source_type: u8,
        source_id: 0x2::object::ID,
        outcome_index: u64,
        pending_borrows: vector<PendingBorrow>,
    }

    public fun length(arg0: &Builder) : u64 {
        0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg0.specs)
    }

    public fun is_empty(arg0: &Builder) : bool {
        0x1::vector::is_empty<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg0.specs)
    }

    public fun add(arg0: &mut Builder, arg1: 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec) {
        0x1::vector::push_back<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&mut arg0.specs, arg1);
    }

    public fun add_pending_borrow(arg0: &mut Builder, arg1: 0x1::type_name::TypeName, arg2: 0x1::string::String) {
        let v0 = PendingBorrow{
            cap_type : arg1,
            name     : arg2,
        };
        0x1::vector::push_back<PendingBorrow>(&mut arg0.pending_borrows, v0);
    }

    public fun into_vector(arg0: Builder) : vector<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec> {
        let Builder {
            specs           : v0,
            source_type     : _,
            source_id       : _,
            outcome_index   : _,
            pending_borrows : v4,
        } = arg0;
        let v5 = v4;
        assert!(0x1::vector::is_empty<PendingBorrow>(&v5), 0);
        v0
    }

    public fun new(arg0: u8, arg1: 0x2::object::ID, arg2: u64) : Builder {
        Builder{
            specs           : 0x1::vector::empty<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(),
            source_type     : arg0,
            source_id       : arg1,
            outcome_index   : arg2,
            pending_borrows : 0x1::vector::empty<PendingBorrow>(),
        }
    }

    public fun next_action_index(arg0: &Builder) : u64 {
        0x1::vector::length<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec>(&arg0.specs)
    }

    public fun outcome_index(arg0: &Builder) : u64 {
        arg0.outcome_index
    }

    public fun remove_pending_borrow(arg0: &mut Builder, arg1: 0x1::type_name::TypeName, arg2: 0x1::string::String) {
        let v0 = PendingBorrow{
            cap_type : arg1,
            name     : arg2,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<PendingBorrow>(&arg0.pending_borrows)) {
            if (0x1::vector::borrow<PendingBorrow>(&arg0.pending_borrows, v1) == &v0) {
                0x1::vector::swap_remove<PendingBorrow>(&mut arg0.pending_borrows, v1);
                return
            };
            v1 = v1 + 1;
        };
        abort 1
    }

    public fun source_id(arg0: &Builder) : 0x2::object::ID {
        arg0.source_id
    }

    public fun source_type(arg0: &Builder) : u8 {
        arg0.source_type
    }

    public fun specs(arg0: &Builder) : &vector<0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::intents::ActionSpec> {
        &arg0.specs
    }

    // decompiled from Move bytecode v6
}

