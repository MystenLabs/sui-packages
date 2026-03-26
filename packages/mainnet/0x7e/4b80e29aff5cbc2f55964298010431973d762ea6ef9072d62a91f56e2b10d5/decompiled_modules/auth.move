module 0x7e4b80e29aff5cbc2f55964298010431973d762ea6ef9072d62a91f56e2b10d5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

