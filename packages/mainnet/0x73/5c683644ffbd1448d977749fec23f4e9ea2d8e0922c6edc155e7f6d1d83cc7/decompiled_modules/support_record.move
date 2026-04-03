module 0x85414a4d2a076f209b1eaddb1d3143832acc478601dfe3ecbc40bd7dfea6e000::support_record {
    struct SupportRecord has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ProjectSupport has drop, store {
        project_id: 0x2::object::ID,
        amount: u64,
        started_at: u64,
        last_updated: u64,
    }

    public fun create_support_record(arg0: &mut 0x2::tx_context::TxContext) : SupportRecord {
        SupportRecord{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        }
    }

    public(friend) fun decrease_support(arg0: &mut SupportRecord, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1);
        assert!(v0.amount >= arg2, 1);
        v0.amount = v0.amount - arg2;
        v0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg3);
        if (v0.amount == 0) {
            0x2::dynamic_field::remove<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1);
        };
    }

    public(friend) fun end_support(arg0: &mut SupportRecord, arg1: 0x2::object::ID) {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1);
        };
    }

    public fun get_support_amount(arg0: &SupportRecord, arg1: 0x2::object::ID) : u64 {
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            return 0
        };
        0x2::dynamic_field::borrow<0x2::object::ID, ProjectSupport>(&arg0.id, arg1).amount
    }

    public fun get_support_details(arg0: &SupportRecord, arg1: 0x2::object::ID) : (u64, u64, u64) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 0);
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, ProjectSupport>(&arg0.id, arg1);
        (v0.amount, v0.started_at, v0.last_updated)
    }

    public(friend) fun increase_support(arg0: &mut SupportRecord, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1);
        v0.amount = v0.amount + arg2;
        v0.last_updated = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public fun is_supporting(arg0: &SupportRecord, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun owner(arg0: &SupportRecord) : address {
        arg0.owner
    }

    public(friend) fun start_support(arg0: &mut SupportRecord, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1);
            v1.amount = v1.amount + arg2;
            v1.last_updated = v0;
        } else {
            let v2 = ProjectSupport{
                project_id   : arg1,
                amount       : arg2,
                started_at   : v0,
                last_updated : v0,
            };
            0x2::dynamic_field::add<0x2::object::ID, ProjectSupport>(&mut arg0.id, arg1, v2);
        };
    }

    // decompiled from Move bytecode v6
}

