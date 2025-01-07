module 0x47d7fa24f5374dfac46f1c1124ac5613cf6aea02d6ff097e45ce660c1a00adf1::events {
    struct CreatedDaoFeePoolEvent has copy, drop {
        dao_fee_pool_id: 0x2::object::ID,
        inner_pool_id: 0x2::object::ID,
        fee_bps: u16,
        fee_recipient: address,
    }

    struct UpdatedFeeBpsEvent has copy, drop {
        dao_fee_pool_id: 0x2::object::ID,
        old_fee_bps: u16,
        new_fee_bps: u16,
    }

    struct UpdatedFeeRecipientEvent has copy, drop {
        dao_fee_pool_id: 0x2::object::ID,
        old_fee_address: address,
        new_fee_address: address,
    }

    public(friend) fun emit_created_pool_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u16, arg3: address) {
        let v0 = CreatedDaoFeePoolEvent{
            dao_fee_pool_id : arg0,
            inner_pool_id   : arg1,
            fee_bps         : arg2,
            fee_recipient   : arg3,
        };
        0x2::event::emit<CreatedDaoFeePoolEvent>(v0);
    }

    public(friend) fun emit_updated_fee_bps_event(arg0: 0x2::object::ID, arg1: u16, arg2: u16) {
        let v0 = UpdatedFeeBpsEvent{
            dao_fee_pool_id : arg0,
            old_fee_bps     : arg1,
            new_fee_bps     : arg2,
        };
        0x2::event::emit<UpdatedFeeBpsEvent>(v0);
    }

    public(friend) fun emit_updated_fee_recipient_event(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = UpdatedFeeRecipientEvent{
            dao_fee_pool_id : arg0,
            old_fee_address : arg1,
            new_fee_address : arg2,
        };
        0x2::event::emit<UpdatedFeeRecipientEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

