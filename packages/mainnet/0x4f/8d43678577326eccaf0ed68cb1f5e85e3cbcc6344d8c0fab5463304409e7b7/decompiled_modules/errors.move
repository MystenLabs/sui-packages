module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::errors {
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

