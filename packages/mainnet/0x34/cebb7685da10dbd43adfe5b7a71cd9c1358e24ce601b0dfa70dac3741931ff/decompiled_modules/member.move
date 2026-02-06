module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member {
    struct MemberCap has store, key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
        agent_id: vector<u8>,
        member: address,
        role: u8,
        joined_at: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : MemberCap {
        assert!(arg3 <= 2, 2);
        MemberCap{
            id         : 0x2::object::new(arg5),
            channel_id : arg0,
            agent_id   : arg1,
            member     : arg2,
            role       : arg3,
            joined_at  : arg4,
        }
    }

    public fun member(arg0: &MemberCap) : address {
        arg0.member
    }

    public fun agent_id(arg0: &MemberCap) : vector<u8> {
        arg0.agent_id
    }

    public(friend) fun burn(arg0: MemberCap) {
        let MemberCap {
            id         : v0,
            channel_id : _,
            agent_id   : _,
            member     : _,
            role       : _,
            joined_at  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun channel_id(arg0: &MemberCap) : 0x2::object::ID {
        arg0.channel_id
    }

    public fun id(arg0: &MemberCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_admin(arg0: &MemberCap) : bool {
        arg0.role >= 1
    }

    public fun is_creator(arg0: &MemberCap) : bool {
        arg0.role == 2
    }

    public fun is_member(arg0: &MemberCap) : bool {
        arg0.role >= 0
    }

    public fun joined_at(arg0: &MemberCap) : u64 {
        arg0.joined_at
    }

    public(friend) fun new_creator(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MemberCap {
        new(arg0, arg1, arg2, 2, arg3, arg4)
    }

    public(friend) fun new_member(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MemberCap {
        new(arg0, arg1, arg2, 0, arg3, arg4)
    }

    public fun role(arg0: &MemberCap) : u8 {
        arg0.role
    }

    public fun role_admin() : u8 {
        1
    }

    public fun role_creator() : u8 {
        2
    }

    public fun role_member() : u8 {
        0
    }

    public(friend) fun set_role(arg0: &mut MemberCap, arg1: u8) {
        assert!(arg1 <= 2, 2);
        arg0.role = arg1;
    }

    public(friend) fun transfer_to(arg0: MemberCap, arg1: address) {
        0x2::transfer::transfer<MemberCap>(arg0, arg1);
    }

    public fun verify_channel(arg0: &MemberCap, arg1: 0x2::object::ID) : bool {
        arg0.channel_id == arg1
    }

    // decompiled from Move bytecode v6
}

