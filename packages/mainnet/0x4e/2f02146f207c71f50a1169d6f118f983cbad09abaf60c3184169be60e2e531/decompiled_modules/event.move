module 0x4e2f02146f207c71f50a1169d6f118f983cbad09abaf60c3184169be60e2e531::event {
    struct ProfileManagerAdminRemoved has copy, drop {
        removed_admin: address,
        owner: address,
    }

    struct ProfileCreated has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    struct ProfileDestroyed has copy, drop {
        owner: address,
        profile: 0x2::object::ID,
    }

    struct LinkAddressRequestCreated has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        profile_owner: address,
        by: address,
    }

    struct LinkAddressRequestAccepted has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        profile_owner: address,
        by: address,
    }

    struct LinkAddressRequestDeclined has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        by: address,
    }

    struct LinkAddressRequestDeleted has copy, drop {
        link_address_request_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        requester: address,
        by: address,
    }

    struct LinkedAddressRemoved has copy, drop {
        profile_id: 0x2::object::ID,
        linked_address: address,
        by: address,
    }

    public fun profile_created(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileCreated{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun profile_destroyed(arg0: address, arg1: 0x2::object::ID) {
        let v0 = ProfileCreated{
            owner   : arg0,
            profile : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

