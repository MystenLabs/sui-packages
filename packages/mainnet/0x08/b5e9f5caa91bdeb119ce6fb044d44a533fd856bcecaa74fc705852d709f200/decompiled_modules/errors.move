module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::errors {
    public(friend) fun e_admin_required() : u64 {
        5
    }

    public(friend) fun e_insufficient_amount() : u64 {
        2
    }

    public(friend) fun e_invalid_root_version() : u64 {
        4
    }

    public(friend) fun e_receipt_already_used() : u64 {
        1
    }

    public(friend) fun e_redemption_request_exists() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

