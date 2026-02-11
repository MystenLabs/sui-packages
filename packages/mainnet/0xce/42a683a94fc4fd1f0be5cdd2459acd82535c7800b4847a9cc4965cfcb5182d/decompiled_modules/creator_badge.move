module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_badge {
    struct CreatorBadge has store, key {
        id: 0x2::object::UID,
        owner: address,
        handle: vector<u8>,
        issued_ms: u64,
    }

    struct BadgeIssued has copy, drop {
        owner: address,
        badge_id: address,
        handle: vector<u8>,
    }

    entry fun issue_badge(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = CreatorBadge{
            id        : 0x2::object::new(arg2),
            owner     : v0,
            handle    : arg0,
            issued_ms : arg1,
        };
        0x2::transfer::transfer<CreatorBadge>(v1, v0);
        let v2 = BadgeIssued{
            owner    : v0,
            badge_id : 0x2::object::uid_to_address(&v1.id),
            handle   : arg0,
        };
        0x2::event::emit<BadgeIssued>(v2);
    }

    // decompiled from Move bytecode v6
}

