module 0x13881e2d84136c31a89bcc0b849dd15701004a6092ad9bd466d1195016bdb410::record {
    struct PendingUnstakeRecord has drop, store {
        requester: 0x1::option::Option<address>,
        afsui_amount: u64,
        afsui_id: 0x2::object::ID,
    }

    public(friend) fun afsui_amount(arg0: &PendingUnstakeRecord) : u64 {
        arg0.afsui_amount
    }

    public(friend) fun afsui_id(arg0: &PendingUnstakeRecord) : 0x2::object::ID {
        arg0.afsui_id
    }

    public(friend) fun new(arg0: 0x1::option::Option<address>, arg1: u64, arg2: 0x2::object::ID) : PendingUnstakeRecord {
        PendingUnstakeRecord{
            requester    : arg0,
            afsui_amount : arg1,
            afsui_id     : arg2,
        }
    }

    public(friend) fun requester(arg0: &PendingUnstakeRecord) : 0x1::option::Option<address> {
        arg0.requester
    }

    // decompiled from Move bytecode v6
}

