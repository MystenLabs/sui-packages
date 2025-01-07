module 0x78334396e159bd9a1393da1185dfe34f6ebfa8bd9e68987220a60393586ddcaf::whitelist {
    struct WhitelistKey has copy, drop, store {
        address: address,
    }

    struct AllowAllKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RejectAllKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WhitelistAddEvent has copy, drop {
        id: 0x2::object::ID,
        address: address,
    }

    struct WhitelistRemoveEvent has copy, drop {
        id: 0x2::object::ID,
        address: address,
    }

    struct AllowAllEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct RejectAllEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct SwitchToWhitelistModeEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_whitelist_address(arg0: &mut 0x2::object::UID, arg1: address) {
        let v0 = WhitelistKey{address: arg1};
        0x2::dynamic_field::add<WhitelistKey, bool>(arg0, v0, true);
        let v1 = WhitelistAddEvent{
            id      : 0x2::object::uid_to_inner(arg0),
            address : arg1,
        };
        0x2::event::emit<WhitelistAddEvent>(v1);
    }

    public fun allow_all(arg0: &mut 0x2::object::UID) {
        let v0 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<RejectAllKey, bool>(arg0, v0);
        let v1 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::add<AllowAllKey, bool>(arg0, v1, true);
        let v2 = AllowAllEvent{id: 0x2::object::uid_to_inner(arg0)};
        0x2::event::emit<AllowAllEvent>(v2);
    }

    public fun in_whitelist(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = WhitelistKey{address: arg1};
        0x2::dynamic_field::exists_<WhitelistKey>(arg0, v0)
    }

    public fun is_address_allowed(arg0: &0x2::object::UID, arg1: address) : bool {
        is_reject_all(arg0) && false || is_allow_all(arg0) || in_whitelist(arg0, arg1)
    }

    public fun is_allow_all(arg0: &0x2::object::UID) : bool {
        let v0 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::exists_<AllowAllKey>(arg0, v0)
    }

    public fun is_reject_all(arg0: &0x2::object::UID) : bool {
        let v0 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::exists_<RejectAllKey>(arg0, v0)
    }

    public fun reject_all(arg0: &mut 0x2::object::UID) {
        let v0 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<AllowAllKey, bool>(arg0, v0);
        let v1 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::add<RejectAllKey, bool>(arg0, v1, true);
        let v2 = RejectAllEvent{id: 0x2::object::uid_to_inner(arg0)};
        0x2::event::emit<RejectAllEvent>(v2);
    }

    public fun remove_whitelist_address(arg0: &mut 0x2::object::UID, arg1: address) {
        let v0 = WhitelistKey{address: arg1};
        0x2::dynamic_field::remove_if_exists<WhitelistKey, bool>(arg0, v0);
        let v1 = WhitelistRemoveEvent{
            id      : 0x2::object::uid_to_inner(arg0),
            address : arg1,
        };
        0x2::event::emit<WhitelistRemoveEvent>(v1);
    }

    public fun switch_to_whitelist_mode(arg0: &mut 0x2::object::UID) {
        let v0 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<AllowAllKey, bool>(arg0, v0);
        let v1 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<RejectAllKey, bool>(arg0, v1);
        let v2 = SwitchToWhitelistModeEvent{id: 0x2::object::uid_to_inner(arg0)};
        0x2::event::emit<SwitchToWhitelistModeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

