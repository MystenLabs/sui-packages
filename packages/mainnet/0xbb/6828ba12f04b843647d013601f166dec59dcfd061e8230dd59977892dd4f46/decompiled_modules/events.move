module 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::events {
    struct LuckyMoneyCreated has copy, drop {
        lucky_money_id: 0x2::object::ID,
        creator: address,
        mode: u8,
        total_amount: u64,
        total_count: u64,
        expire_time: u64,
        secret_commitment: vector<u8>,
    }

    struct LuckyMoneyClaimed has copy, drop {
        lucky_money_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        nullifier: vector<u8>,
        remaining_amount: u64,
        remaining_count: u64,
    }

    struct LuckyMoneyRefunded has copy, drop {
        lucky_money_id: 0x2::object::ID,
        owner: address,
        refunded_amount: u64,
    }

    struct LuckyMoneyExpired has copy, drop {
        lucky_money_id: 0x2::object::ID,
        expired_at_ms: u64,
    }

    public fun emit_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64) {
        let v0 = LuckyMoneyClaimed{
            lucky_money_id   : arg0,
            claimer          : arg1,
            amount           : arg2,
            nullifier        : arg3,
            remaining_amount : arg4,
            remaining_count  : arg5,
        };
        0x2::event::emit<LuckyMoneyClaimed>(v0);
    }

    public fun emit_created(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>) {
        let v0 = LuckyMoneyCreated{
            lucky_money_id    : arg0,
            creator           : arg1,
            mode              : arg2,
            total_amount      : arg3,
            total_count       : arg4,
            expire_time       : arg5,
            secret_commitment : arg6,
        };
        0x2::event::emit<LuckyMoneyCreated>(v0);
    }

    public fun emit_expired(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LuckyMoneyExpired{
            lucky_money_id : arg0,
            expired_at_ms  : arg1,
        };
        0x2::event::emit<LuckyMoneyExpired>(v0);
    }

    public fun emit_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = LuckyMoneyRefunded{
            lucky_money_id  : arg0,
            owner           : arg1,
            refunded_amount : arg2,
        };
        0x2::event::emit<LuckyMoneyRefunded>(v0);
    }

    // decompiled from Move bytecode v6
}

