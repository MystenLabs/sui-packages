module 0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::settle {
    struct DestCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct DestCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct SettleReceipt<phantom T0> {
        order_hash: address,
        addr_dest: address,
        funds: 0x2::balance::Balance<T0>,
        custom_payload: address,
    }

    public fun complete_settle<T0>(arg0: &DestCap, arg1: SettleReceipt<T0>) : (address, 0x2::balance::Balance<T0>, address) {
        let SettleReceipt {
            order_hash     : v0,
            addr_dest      : v1,
            funds          : v2,
            custom_payload : v3,
        } = arg1;
        let v4 = 0x2::object::id<DestCap>(arg0);
        assert!(0x2::object::id_to_address(&v4) == v1, 1);
        (v0, v2, v3)
    }

    public fun destroy_dest_cap(arg0: &0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::State, arg1: DestCap) {
        0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::assert_valid_version(arg0);
        let v0 = DestCapDestroyed{cap_id: 0x2::object::id<DestCap>(&arg1)};
        0x2::event::emit<DestCapDestroyed>(v0);
        let DestCap { id: v1 } = arg1;
        0x2::object::delete(v1);
    }

    public fun new_dest_cap(arg0: &0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::State, arg1: &mut 0x2::tx_context::TxContext) : DestCap {
        0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::assert_valid_version(arg0);
        let v0 = DestCap{id: 0x2::object::new(arg1)};
        let v1 = DestCapCreated{cap_id: 0x2::object::id<DestCap>(&v0)};
        0x2::event::emit<DestCapCreated>(v1);
        v0
    }

    public fun prepare_settle<T0>(arg0: &mut 0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::State, arg1: 0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::DestLockedFunds<T0>, arg2: address) : SettleReceipt<T0> {
        0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::assert_valid_version(arg0);
        assert!(0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::has_dest_order(arg0, arg2), 0);
        let (v0, v1, v2) = 0x974af8e76ab7655b142ac344ce550cfdf9a288f2d2b0e3deff46983c4d255954::state::settle_dest_order<T0>(arg0, arg2, arg1);
        SettleReceipt<T0>{
            order_hash     : arg2,
            addr_dest      : v0,
            funds          : v1,
            custom_payload : v2,
        }
    }

    // decompiled from Move bytecode v6
}

