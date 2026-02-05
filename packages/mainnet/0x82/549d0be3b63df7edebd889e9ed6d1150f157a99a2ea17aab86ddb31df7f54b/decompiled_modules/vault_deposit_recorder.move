module 0x905d2e52c061e4657cf416b231160a9c43e03cf22bec369a9ebfb317dd9c8e7c::vault_deposit_recorder {
    struct UserDepositRecorded has copy, drop {
        vault_id: address,
        user: address,
        source: 0x1::ascii::String,
        amount: u64,
    }

    struct UserWithdrawRecorded has copy, drop {
        vault_id: address,
        user: address,
        source: 0x1::ascii::String,
        shares: u256,
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

    public fun record_user_withdraw(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u256) {
        let v0 = UserWithdrawRecorded{
            vault_id : arg0,
            user     : arg1,
            source   : arg2,
            shares   : arg3,
        };
        0x2::event::emit<UserWithdrawRecorded>(v0);
    }

    // decompiled from Move bytecode v6
}

