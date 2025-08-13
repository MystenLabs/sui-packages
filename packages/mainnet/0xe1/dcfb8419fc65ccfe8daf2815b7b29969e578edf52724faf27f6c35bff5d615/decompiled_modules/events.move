module 0xe1dcfb8419fc65ccfe8daf2815b7b29969e578edf52724faf27f6c35bff5d615::events {
    struct InviteeAdded has copy, drop {
        invitee: address,
        inviter: address,
    }

    struct InviteeUpdated has copy, drop {
        invitee: address,
        inviter: address,
    }

    // decompiled from Move bytecode v6
}

