module 0x43e99dc83d4c41b8db7ae4610f232d59389dc70ec9faadbcd810fc284b4bd561::event {
    struct ProfileCreated has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    struct ProfileDestroyed has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    struct ShareInvitation has copy, drop {
        invitee: address,
        inviter: address,
        amount: u256,
        action: 0x1::ascii::String,
    }

    public fun profile_created(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileCreated{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun profile_destroyed(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileDestroyed{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileDestroyed>(v0);
    }

    public fun share_invitation(arg0: address, arg1: address, arg2: u256, arg3: 0x1::ascii::String) {
        let v0 = ShareInvitation{
            invitee : arg0,
            inviter : arg1,
            amount  : arg2,
            action  : arg3,
        };
        0x2::event::emit<ShareInvitation>(v0);
    }

    // decompiled from Move bytecode v6
}

