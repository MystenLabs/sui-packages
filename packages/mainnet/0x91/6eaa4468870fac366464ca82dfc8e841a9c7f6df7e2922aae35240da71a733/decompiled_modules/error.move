module 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::error {
    public fun account_already_exists(arg0: u64) : u64 {
        abort arg0
    }

    public fun account_not_found(arg0: u64) : u64 {
        abort arg0
    }

    // decompiled from Move bytecode v6
}

