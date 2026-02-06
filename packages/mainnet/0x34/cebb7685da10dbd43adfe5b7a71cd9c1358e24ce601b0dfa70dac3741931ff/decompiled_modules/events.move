module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events {
    struct ChannelCreated has copy, drop {
        channel_id: 0x2::object::ID,
        creator: address,
        name: vector<u8>,
        agent_id: vector<u8>,
    }

    struct MemberJoined has copy, drop {
        channel_id: 0x2::object::ID,
        member: address,
        agent_id: vector<u8>,
        via_invite: bool,
    }

    struct MemberLeft has copy, drop {
        channel_id: 0x2::object::ID,
        member: address,
    }

    struct MessageSent has copy, drop {
        channel_id: 0x2::object::ID,
        message_index: u64,
        sender: address,
        sender_agent_id: vector<u8>,
        message_type: u8,
        ciphertext: vector<u8>,
        nonce: vector<u8>,
        dek_version: u64,
    }

    struct InviteCreated has copy, drop {
        invite_id: 0x2::object::ID,
        channel_id: 0x2::object::ID,
        creator: address,
        max_uses: u64,
        expires_at: u64,
    }

    struct InviteUsed has copy, drop {
        invite_id: 0x2::object::ID,
        channel_id: 0x2::object::ID,
        user: address,
        uses_remaining: u64,
    }

    struct DEKRotated has copy, drop {
        channel_id: 0x2::object::ID,
        new_version: u64,
        rotated_by: address,
    }

    public(friend) fun emit_channel_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = ChannelCreated{
            channel_id : arg0,
            creator    : arg1,
            name       : arg2,
            agent_id   : arg3,
        };
        0x2::event::emit<ChannelCreated>(v0);
    }

    public(friend) fun emit_dek_rotated(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = DEKRotated{
            channel_id  : arg0,
            new_version : arg1,
            rotated_by  : arg2,
        };
        0x2::event::emit<DEKRotated>(v0);
    }

    public(friend) fun emit_invite_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = InviteCreated{
            invite_id  : arg0,
            channel_id : arg1,
            creator    : arg2,
            max_uses   : arg3,
            expires_at : arg4,
        };
        0x2::event::emit<InviteCreated>(v0);
    }

    public(friend) fun emit_invite_used(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = InviteUsed{
            invite_id      : arg0,
            channel_id     : arg1,
            user           : arg2,
            uses_remaining : arg3,
        };
        0x2::event::emit<InviteUsed>(v0);
    }

    public(friend) fun emit_member_joined(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: bool) {
        let v0 = MemberJoined{
            channel_id : arg0,
            member     : arg1,
            agent_id   : arg2,
            via_invite : arg3,
        };
        0x2::event::emit<MemberJoined>(v0);
    }

    public(friend) fun emit_member_left(arg0: 0x2::object::ID, arg1: address) {
        let v0 = MemberLeft{
            channel_id : arg0,
            member     : arg1,
        };
        0x2::event::emit<MemberLeft>(v0);
    }

    public(friend) fun emit_message_sent(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: u64) {
        let v0 = MessageSent{
            channel_id      : arg0,
            message_index   : arg1,
            sender          : arg2,
            sender_agent_id : arg3,
            message_type    : arg4,
            ciphertext      : arg5,
            nonce           : arg6,
            dek_version     : arg7,
        };
        0x2::event::emit<MessageSent>(v0);
    }

    // decompiled from Move bytecode v6
}

