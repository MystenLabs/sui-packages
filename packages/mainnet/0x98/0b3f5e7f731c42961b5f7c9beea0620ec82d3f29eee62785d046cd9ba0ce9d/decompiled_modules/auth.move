module 0x980b3f5e7f731c42961b5f7c9beea0620ec82d3f29eee62785d046cd9ba0ce9d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

