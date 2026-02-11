module 0x39e56fc1b75b59bfa8e9043a26d77e158633a0aa2e8297d526721152ea03b1f1::creator_badge {
    struct CreatorBadge has store, key {
        id: 0x2::object::UID,
        owner: address,
        handle: vector<u8>,
        issued_ms: u64,
    }

    public fun get_handle(arg0: &CreatorBadge) : vector<u8> {
        arg0.handle
    }

    entry fun issue(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorBadge{
            id        : 0x2::object::new(arg2),
            owner     : 0x2::tx_context::sender(arg2),
            handle    : arg0,
            issued_ms : arg1,
        };
        0x2::transfer::transfer<CreatorBadge>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

