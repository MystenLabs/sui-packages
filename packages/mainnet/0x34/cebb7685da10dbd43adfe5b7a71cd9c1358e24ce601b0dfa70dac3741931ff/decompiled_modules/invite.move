module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite {
    struct Invite has store, key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
        creator: address,
        encrypted_data: vector<u8>,
        expires_at: u64,
        max_uses: u64,
        uses: u64,
        created_at: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Invite {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 == 0 || arg3 > v0, 4);
        let v1 = Invite{
            id             : 0x2::object::new(arg6),
            channel_id     : arg0,
            creator        : arg1,
            encrypted_data : arg2,
            expires_at     : arg3,
            max_uses       : arg4,
            uses           : 0,
            created_at     : v0,
        };
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_invite_created(0x2::object::uid_to_inner(&v1.id), arg0, arg1, arg4, arg3);
        v1
    }

    public(friend) fun burn(arg0: Invite) {
        let Invite {
            id             : v0,
            channel_id     : _,
            creator        : _,
            encrypted_data : _,
            expires_at     : _,
            max_uses       : _,
            uses           : _,
            created_at     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun channel_id(arg0: &Invite) : 0x2::object::ID {
        arg0.channel_id
    }

    public fun created_at(arg0: &Invite) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &Invite) : address {
        arg0.creator
    }

    public fun encrypted_data(arg0: &Invite) : vector<u8> {
        arg0.encrypted_data
    }

    public fun expires_at(arg0: &Invite) : u64 {
        arg0.expires_at
    }

    public fun id(arg0: &Invite) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_valid(arg0: &Invite, arg1: &0x2::clock::Clock) : bool {
        let v0 = arg0.expires_at == 0 || 0x2::clock::timestamp_ms(arg1) < arg0.expires_at;
        let v1 = arg0.max_uses == 0 || arg0.uses < arg0.max_uses;
        v0 && v1
    }

    public fun max_uses(arg0: &Invite) : u64 {
        arg0.max_uses
    }

    public(friend) fun share(arg0: Invite) {
        0x2::transfer::share_object<Invite>(arg0);
    }

    public(friend) fun use_invite(arg0: &mut Invite, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(arg0.expires_at == 0 || 0x2::clock::timestamp_ms(arg2) < arg0.expires_at, 1);
        assert!(arg0.max_uses == 0 || arg0.uses < arg0.max_uses, 2);
        arg0.uses = arg0.uses + 1;
        let v0 = if (arg0.max_uses == 0) {
            18446744073709551615
        } else {
            arg0.max_uses - arg0.uses
        };
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_invite_used(0x2::object::uid_to_inner(&arg0.id), arg0.channel_id, arg1, v0);
    }

    public fun uses(arg0: &Invite) : u64 {
        arg0.uses
    }

    public fun uses_remaining(arg0: &Invite) : u64 {
        if (arg0.max_uses == 0) {
            18446744073709551615
        } else if (arg0.uses >= arg0.max_uses) {
            0
        } else {
            arg0.max_uses - arg0.uses
        }
    }

    // decompiled from Move bytecode v6
}

