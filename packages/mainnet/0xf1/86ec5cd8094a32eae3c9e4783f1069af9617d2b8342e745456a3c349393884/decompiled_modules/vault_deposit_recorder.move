module 0x7f03332ce10d85053a14cc198ec4437312b2b880abd6550cae1757f192100f91::vault_deposit_recorder {
    struct UserDepositRecorded has copy, drop {
        vault_id: address,
        user: address,
        source: 0x1::ascii::String,
        amount: u64,
    }

    public fun record_user_deposit(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64) {
        let v0 = UserDepositRecorded{
            vault_id : arg0,
            user     : arg1,
            source   : arg2,
            amount   : arg3,
        };
        0x2::event::emit<UserDepositRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

