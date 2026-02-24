module 0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::events {
    struct FeeCollected has copy, drop {
        agent: address,
        operation: u8,
        amount: u64,
        principal: u64,
    }

    struct ConfigUpdated has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
        updated_by: address,
    }

    struct ProtocolPaused has copy, drop {
        paused_by: address,
    }

    struct ProtocolUnpaused has copy, drop {
        unpaused_by: address,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        total_withdrawn: u64,
    }

    struct FeeChangeProposed has copy, drop {
        save_bps: u64,
        swap_bps: u64,
        borrow_bps: u64,
        effective_at: u64,
    }

    struct AdminTransferProposed has copy, drop {
        current_admin: address,
        proposed_admin: address,
    }

    struct AdminTransferAccepted has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public(friend) fun emit_admin_transfer_accepted(arg0: address, arg1: address) {
        let v0 = AdminTransferAccepted{
            old_admin : arg0,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferAccepted>(v0);
    }

    public(friend) fun emit_admin_transfer_proposed(arg0: address, arg1: address) {
        let v0 = AdminTransferProposed{
            current_admin  : arg0,
            proposed_admin : arg1,
        };
        0x2::event::emit<AdminTransferProposed>(v0);
    }

    public(friend) fun emit_config_updated(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: address) {
        let v0 = ConfigUpdated{
            field      : arg0,
            old_value  : arg1,
            new_value  : arg2,
            updated_by : arg3,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun emit_fee_change_proposed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = FeeChangeProposed{
            save_bps     : arg0,
            swap_bps     : arg1,
            borrow_bps   : arg2,
            effective_at : arg3,
        };
        0x2::event::emit<FeeChangeProposed>(v0);
    }

    public(friend) fun emit_fee_collected(arg0: address, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = FeeCollected{
            agent     : arg0,
            operation : arg1,
            amount    : arg2,
            principal : arg3,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public(friend) fun emit_fees_withdrawn(arg0: u64, arg1: address, arg2: u64) {
        let v0 = FeesWithdrawn{
            amount          : arg0,
            recipient       : arg1,
            total_withdrawn : arg2,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public(friend) fun emit_protocol_paused(arg0: address) {
        let v0 = ProtocolPaused{paused_by: arg0};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public(friend) fun emit_protocol_unpaused(arg0: address) {
        let v0 = ProtocolUnpaused{unpaused_by: arg0};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

