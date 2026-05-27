module 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct PcrUpdateCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        minted_at_ms: u64,
        minted_by: address,
    }

    public fun assert_controls<T0>(arg0: &PcrUpdateCap<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.config_id == arg1, 0);
    }

    public(friend) fun mint_admin<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        AdminCap<T0>{id: 0x2::object::new(arg0)}
    }

    public entry fun mint_and_transfer_pcu<T0>(arg0: &AdminCap<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PcrUpdateCap<T0>{
            id           : 0x2::object::new(arg4),
            config_id    : arg1,
            minted_at_ms : 0x2::clock::timestamp_ms(arg3),
            minted_by    : arg2,
        };
        0x2::transfer::public_transfer<PcrUpdateCap<T0>>(v0, arg2);
    }

    public fun mint_pcr_update_cap<T0>(arg0: &AdminCap<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PcrUpdateCap<T0> {
        PcrUpdateCap<T0>{
            id           : 0x2::object::new(arg3),
            config_id    : arg1,
            minted_at_ms : 0,
            minted_by    : arg2,
        }
    }

    public fun pcu_config_id<T0>(arg0: &PcrUpdateCap<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun pcu_minted_by<T0>(arg0: &PcrUpdateCap<T0>) : address {
        arg0.minted_by
    }

    public entry fun revoke<T0>(arg0: &AdminCap<T0>, arg1: PcrUpdateCap<T0>) {
        let PcrUpdateCap {
            id           : v0,
            config_id    : _,
            minted_at_ms : _,
            minted_by    : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

