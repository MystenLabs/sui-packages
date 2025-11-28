module 0x79023ea6284a29d1bb690069e534b67bca7815a4125f295bbd6589347c446a6e::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

