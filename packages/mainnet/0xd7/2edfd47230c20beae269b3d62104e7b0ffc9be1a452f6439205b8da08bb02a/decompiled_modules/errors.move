module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors {
    public(friend) fun address_zero_not_allowed() : u64 {
        4007
    }

    public(friend) fun already_migrated() : u64 {
        1002
    }

    public(friend) fun cap_missing() : u64 {
        1005
    }

    public(friend) fun cap_slot_taken() : u64 {
        1004
    }

    public(friend) fun guardian_cannot_cancel() : u64 {
        3003
    }

    public(friend) fun guardian_reappointed() : u64 {
        3007
    }

    public(friend) fun guardian_update_adds_only() : u64 {
        3004
    }

    public(friend) fun invalid_role() : u64 {
        4006
    }

    public(friend) fun last_holder_not_removable() : u64 {
        4005
    }

    public(friend) fun no_pending_guardian_removal() : u64 {
        3006
    }

    public(friend) fun role_already_assigned() : u64 {
        4003
    }

    public(friend) fun role_conflict() : u64 {
        3008
    }

    public(friend) fun role_not_assigned() : u64 {
        4004
    }

    public(friend) fun role_without_holder() : u64 {
        3001
    }

    public(friend) fun roles_finalized() : u64 {
        4002
    }

    public(friend) fun roles_not_finalized() : u64 {
        4008
    }

    public(friend) fun target_mismatch() : u64 {
        2001
    }

    public(friend) fun timelock_cap_not_installed() : u64 {
        3005
    }

    public(friend) fun type_mismatch() : u64 {
        2002
    }

    public(friend) fun unauthorized() : u64 {
        4001
    }

    public(friend) fun upgrade_cap_missing() : u64 {
        1006
    }

    public(friend) fun use_remove_guardian() : u64 {
        3002
    }

    public(friend) fun wrong_timelock() : u64 {
        1003
    }

    public(friend) fun wrong_version() : u64 {
        1001
    }

    // decompiled from Move bytecode v7
}

