module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::claim {
    struct ClaimRecord<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        draw_id: u64,
        tier: u8,
        recipient: address,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
        created_at_ms: u64,
    }

    struct ClaimRecordCreatedEvent has copy, drop {
        record_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        draw_id: u64,
        tier: u8,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ClaimedEvent has copy, drop {
        record_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        draw_id: u64,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun claim<T0>(arg0: ClaimRecord<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg2), 1);
        let ClaimRecord {
            id            : v0,
            pool_id       : v1,
            draw_id       : v2,
            tier          : _,
            recipient     : v4,
            amount        : v5,
            balance       : v6,
            created_at_ms : _,
        } = arg0;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = ClaimedEvent{
            record_id    : 0x2::object::uid_to_inner(&v8),
            pool_id      : v1,
            draw_id      : v2,
            recipient    : v4,
            amount       : v5,
            timestamp_ms : arg1,
        };
        0x2::event::emit<ClaimedEvent>(v9);
        0x2::coin::from_balance<T0>(v6, arg2)
    }

    public fun amount<T0>(arg0: &ClaimRecord<T0>) : u64 {
        arg0.amount
    }

    public(friend) fun create_record<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = ClaimRecord<T0>{
            id            : 0x2::object::new(arg6),
            pool_id       : arg0,
            draw_id       : arg1,
            tier          : arg2,
            recipient     : arg3,
            amount        : v0,
            balance       : arg4,
            created_at_ms : arg5,
        };
        let v2 = ClaimRecordCreatedEvent{
            record_id    : 0x2::object::uid_to_inner(&v1.id),
            pool_id      : arg0,
            draw_id      : arg1,
            tier         : arg2,
            recipient    : arg3,
            amount       : v0,
            timestamp_ms : arg5,
        };
        0x2::event::emit<ClaimRecordCreatedEvent>(v2);
        0x2::transfer::public_transfer<ClaimRecord<T0>>(v1, arg3);
    }

    public fun draw_id<T0>(arg0: &ClaimRecord<T0>) : u64 {
        arg0.draw_id
    }

    public fun pool_id<T0>(arg0: &ClaimRecord<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun recipient<T0>(arg0: &ClaimRecord<T0>) : address {
        arg0.recipient
    }

    public fun tier<T0>(arg0: &ClaimRecord<T0>) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v7
}

