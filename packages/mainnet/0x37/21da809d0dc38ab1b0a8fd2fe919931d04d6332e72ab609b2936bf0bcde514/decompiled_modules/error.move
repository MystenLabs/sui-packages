module 0x3721da809d0dc38ab1b0a8fd2fe919931d04d6332e72ab609b2936bf0bcde514::error {
    public fun address_has_linked_error() : u64 {
        10
    }

    public fun address_not_belong_to_same_profile_error() : u64 {
        8
    }

    public fun address_not_linked_error() : u64 {
        9
    }

    public fun duplicated_error() : u64 {
        3
    }

    public fun duplicated_user_dapp_score_object_error() : u64 {
        2
    }

    public fun has_exist_error() : u64 {
        11
    }

    public fun not_authorized_error() : u64 {
        1
    }

    public fun not_exist_error() : u64 {
        4
    }

    public fun score_under_zero_error() : u64 {
        7
    }

    public fun target_not_exist_error() : u64 {
        6
    }

    public fun updater_expired_error() : u64 {
        5
    }

    public fun wrong_version_error() : u64 {
        12
    }

    // decompiled from Move bytecode v6
}

