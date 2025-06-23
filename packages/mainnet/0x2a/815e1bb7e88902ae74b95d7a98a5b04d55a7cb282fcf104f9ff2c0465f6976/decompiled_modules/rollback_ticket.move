module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket {
    struct RollbackTicket has drop {
        rollback: vector<u8>,
        sn: u128,
        dapp_id: 0x2::object::ID,
    }

    public(friend) fun consume(arg0: RollbackTicket) {
        let RollbackTicket {
            rollback : _,
            sn       : _,
            dapp_id  : _,
        } = arg0;
    }

    public fun dapp_id(arg0: &RollbackTicket) : 0x2::object::ID {
        arg0.dapp_id
    }

    public(friend) fun new(arg0: u128, arg1: vector<u8>, arg2: 0x2::object::ID) : RollbackTicket {
        RollbackTicket{
            rollback : arg1,
            sn       : arg0,
            dapp_id  : arg2,
        }
    }

    public fun rollback(arg0: &RollbackTicket) : vector<u8> {
        arg0.rollback
    }

    public fun sn(arg0: &RollbackTicket) : u128 {
        arg0.sn
    }

    // decompiled from Move bytecode v6
}

