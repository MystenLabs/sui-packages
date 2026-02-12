module 0x7f03332ce10d85053a14cc198ec4437312b2b880abd6550cae1757f192100f91::vault_deposit_recorder {
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

    struct UserDepositRecordedV2 has copy, drop {
        vault_id: address,
        request_id: u64,
        user: address,
        source: 0x1::ascii::String,
        amount: u64,
    }

    struct UserWithdrawRecordedV2 has copy, drop {
        vault_id: address,
        request_id: u64,
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

    public fun record_user_deposit_v2(arg0: address, arg1: u64, arg2: address, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = UserDepositRecordedV2{
            vault_id   : arg0,
            request_id : arg1,
            user       : arg2,
            source     : arg3,
            amount     : arg4,
        };
        0x2::event::emit<UserDepositRecordedV2>(v0);
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

    public fun record_user_withdraw_v2(arg0: address, arg1: u64, arg2: address, arg3: 0x1::ascii::String, arg4: u256) {
        let v0 = UserWithdrawRecordedV2{
            vault_id   : arg0,
            request_id : arg1,
            user       : arg2,
            source     : arg3,
            shares     : arg4,
        };
        0x2::event::emit<UserWithdrawRecordedV2>(v0);
    }

    // decompiled from Move bytecode v6
}

