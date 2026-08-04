module 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::deal {
    struct Deal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        track_split_bps: 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::BPS,
    }

    struct DealCreatedEvent<phantom T0, phantom T1> has copy, drop {
        deal_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        track_split_bps_value: u16,
    }

    struct DealAcceptedEvent<phantom T0, phantom T1> has copy, drop {
        deal_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
    }

    struct DealRejectedEvent<phantom T0, phantom T1> has copy, drop {
        deal_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
    }

    public fun new<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg2: 0x2::object::ID, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : Deal<T0, T1> {
        let v0 = Deal<T0, T1>{
            id              : 0x2::object::new(arg4),
            release_id      : arg2,
            track_split_bps : 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::new(arg3),
        };
        let v1 = DealCreatedEvent<T0, T1>{
            deal_id               : id<T0, T1>(&v0),
            release_id            : arg2,
            track_split_bps_value : arg3,
        };
        0x2::event::emit<DealCreatedEvent<T0, T1>>(v1);
        v0
    }

    public(friend) fun accept<T0, T1>(arg0: Deal<T0, T1>) {
        let v0 = DealAcceptedEvent<T0, T1>{
            deal_id    : id<T0, T1>(&arg0),
            release_id : arg0.release_id,
        };
        0x2::event::emit<DealAcceptedEvent<T0, T1>>(v0);
        destroy_internal<T0, T1>(arg0);
    }

    fun destroy_internal<T0, T1>(arg0: Deal<T0, T1>) {
        let Deal {
            id              : v0,
            release_id      : _,
            track_split_bps : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id<T0, T1>(arg0: &Deal<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun reject<T0, T1>(arg0: Deal<T0, T1>) {
        let v0 = DealRejectedEvent<T0, T1>{
            deal_id    : id<T0, T1>(&arg0),
            release_id : arg0.release_id,
        };
        0x2::event::emit<DealRejectedEvent<T0, T1>>(v0);
        destroy_internal<T0, T1>(arg0);
    }

    public fun release_id<T0, T1>(arg0: &Deal<T0, T1>) : 0x2::object::ID {
        arg0.release_id
    }

    public fun track_split_bps<T0, T1>(arg0: &Deal<T0, T1>) : 0xdb58d86a55daa5bc436f0f6056a651c9859da1b4f5785f9688b4c3e72ae1cfe0::bps::BPS {
        arg0.track_split_bps
    }

    // decompiled from Move bytecode v7
}

