module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::skip_list {
    struct SkipList<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        head: vector<0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::option_u64::OptionU64>,
        tail: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::option_u64::OptionU64,
        level: u64,
        max_level: u64,
        list_p: u64,
        size: u64,
        random: 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::random::Random,
    }

    // decompiled from Move bytecode v6
}

