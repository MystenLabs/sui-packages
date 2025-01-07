module 0xff7733fe18fc30cfb60bada75fa756135c54ee8c6db50efd22f5a18ce5e43c21::event {
    struct MintEvent has copy, drop {
        global: 0x2::object::ID,
        input_amount: u64,
        vault_share: u64,
        sender: address,
        epoch: u64,
    }

    struct RequestRedeemEvent has copy, drop {
        global: 0x2::object::ID,
        vault_amount: u64,
        withdraw_amount: u64,
        sender: address,
        epoch: u64,
    }

    struct RedeemEvent has copy, drop {
        global: 0x2::object::ID,
        withdraw_amount: u64,
        sender: address,
        epoch: u64,
    }

    public(friend) fun mint_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = MintEvent{
            global       : arg0,
            input_amount : arg1,
            vault_share  : arg2,
            sender       : arg3,
            epoch        : arg4,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public(friend) fun redeem_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = RedeemEvent{
            global          : arg0,
            withdraw_amount : arg1,
            sender          : arg2,
            epoch           : arg3,
        };
        0x2::event::emit<RedeemEvent>(v0);
    }

    public(friend) fun request_redeem_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64) {
        let v0 = RequestRedeemEvent{
            global          : arg0,
            vault_amount    : arg1,
            withdraw_amount : arg2,
            sender          : arg3,
            epoch           : arg4,
        };
        0x2::event::emit<RequestRedeemEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

