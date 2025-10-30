module 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::acl {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has store, key {
        id: 0x2::object::UID,
    }

    struct RewardAdminKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun assert_reward_admin(arg0: &Acl, arg1: &0x2::tx_context::TxContext) {
        let v0 = RewardAdminKey{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(get_acl_<RewardAdminKey>(arg0, v0) == &v1, 0xb62bbdb7bfe17327c03882b13ec0b3a29a455f737b60c3b583745349117e9104::error::e_not_reward_admin());
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (AdminCap, Acl) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Acl{id: 0x2::object::new(arg0)};
        let v2 = RewardAdminKey{dummy_field: false};
        0x2::dynamic_field::add<RewardAdminKey, address>(&mut v1.id, v2, 0x2::tx_context::sender(arg0));
        (v0, v1)
    }

    fun get_acl_<T0: copy + drop + store>(arg0: &Acl, arg1: T0) : &address {
        0x2::dynamic_field::borrow<T0, address>(&arg0.id, arg1)
    }

    public(friend) fun get_reward_admin(arg0: &Acl) : address {
        let v0 = RewardAdminKey{dummy_field: false};
        *get_acl_<RewardAdminKey>(arg0, v0)
    }

    fun set_acl_<T0: copy + drop + store>(arg0: &mut Acl, arg1: T0, arg2: address) : 0x1::option::Option<address> {
        0x2::dynamic_field::add<T0, address>(&mut arg0.id, arg1, arg2);
        0x2::dynamic_field::remove_if_exists<T0, address>(&mut arg0.id, arg1)
    }

    public(friend) fun set_reward_admin(arg0: &mut Acl, arg1: address) : 0x1::option::Option<address> {
        let v0 = RewardAdminKey{dummy_field: false};
        set_acl_<RewardAdminKey>(arg0, v0, arg1)
    }

    // decompiled from Move bytecode v6
}

