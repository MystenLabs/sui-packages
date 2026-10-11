module 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::owner {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        recipient: address,
    }

    struct PayoutEvent has copy, drop {
        coin_type: vector<u8>,
        amount: u64,
        to: address,
    }

    public fun assert_is_recipient(arg0: &OwnerCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::not_owner());
    }

    public(friend) fun emit_payout(arg0: vector<u8>, arg1: u64, arg2: address) {
        let v0 = PayoutEvent{
            coin_type : arg0,
            amount    : arg1,
            to        : arg2,
        };
        0x2::event::emit<PayoutEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{
            id        : 0x2::object::new(arg0),
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun recipient(arg0: &OwnerCap) : address {
        arg0.recipient
    }

    public fun set_recipient(arg0: &mut OwnerCap, arg1: address) {
        arg0.recipient = arg1;
    }

    // decompiled from Move bytecode v7
}

