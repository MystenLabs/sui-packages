module 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::navi_operator {
    struct NaviOperator has key {
        id: 0x2::object::UID,
        account_cap_id: address,
        vault_id: address,
        active: bool,
        version: u64,
    }

    struct NaviCapRegistered has copy, drop {
        account_cap_id: address,
        vault_id: address,
    }

    struct NaviCapUpdated has copy, drop {
        old_cap_id: address,
        new_cap_id: address,
    }

    public fun account_cap_id(arg0: &NaviOperator) : address {
        assert!(arg0.active, 800);
        arg0.account_cap_id
    }

    public fun create(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviOperator{
            id             : 0x2::object::new(arg2),
            account_cap_id : arg0,
            vault_id       : arg1,
            active         : true,
            version        : 1,
        };
        let v1 = NaviCapRegistered{
            account_cap_id : arg0,
            vault_id       : arg1,
        };
        0x2::event::emit<NaviCapRegistered>(v1);
        0x2::transfer::share_object<NaviOperator>(v0);
    }

    public fun is_active(arg0: &NaviOperator) : bool {
        arg0.active
    }

    public(friend) fun set_active(arg0: &mut NaviOperator, arg1: bool) {
        arg0.active = arg1;
    }

    public(friend) fun update_cap_id(arg0: &mut NaviOperator, arg1: address) {
        arg0.account_cap_id = arg1;
        let v0 = NaviCapUpdated{
            old_cap_id : arg0.account_cap_id,
            new_cap_id : arg1,
        };
        0x2::event::emit<NaviCapUpdated>(v0);
    }

    public fun vault_id(arg0: &NaviOperator) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

