module 0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist {
    struct WhitelistKey has copy, drop, store {
        address: address,
    }

    struct AllowAllKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RejectAllKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_whitelist_address(arg0: &mut 0x2::object::UID, arg1: address) {
        let v0 = WhitelistKey{address: arg1};
        0x2::dynamic_field::add<WhitelistKey, bool>(arg0, v0, true);
    }

    public fun allow_all(arg0: &mut 0x2::object::UID) {
        let v0 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<RejectAllKey, bool>(arg0, v0);
        let v1 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::add<AllowAllKey, bool>(arg0, v1, true);
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
    }

    public fun remove_whitelist_address(arg0: &mut 0x2::object::UID, arg1: address) {
        let v0 = WhitelistKey{address: arg1};
        0x2::dynamic_field::remove_if_exists<WhitelistKey, bool>(arg0, v0);
    }

    public fun switch_to_whitelist_mode(arg0: &mut 0x2::object::UID) {
        let v0 = AllowAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<AllowAllKey, bool>(arg0, v0);
        let v1 = RejectAllKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<RejectAllKey, bool>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

