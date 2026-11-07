module 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position {
    struct JewelMagmaPosition has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        share: u128,
        name: 0x1::string::String,
    }

    public(friend) fun destroy_empty(arg0: JewelMagmaPosition) {
        assert!(arg0.share == 0, 201);
        let JewelMagmaPosition {
            id      : v0,
            farm_id : _,
            share   : _,
            name    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : JewelMagmaPosition {
        JewelMagmaPosition{
            id      : 0x2::object::new(arg1),
            farm_id : arg0,
            share   : 0,
            name    : 0x1::string::utf8(b"JewelSwap Magma Farm Position"),
        }
    }

    public(friend) fun decrease(arg0: &mut JewelMagmaPosition, arg1: u128) {
        assert!(arg1 <= arg0.share, 203);
        arg0.share = arg0.share - arg1;
    }

    public fun farm_id(arg0: &JewelMagmaPosition) : 0x2::object::ID {
        arg0.farm_id
    }

    public(friend) fun increase(arg0: &mut JewelMagmaPosition, arg1: u128) {
        arg0.share = arg0.share + arg1;
    }

    public(friend) fun merge(arg0: &mut JewelMagmaPosition, arg1: JewelMagmaPosition) {
        assert!(arg0.farm_id == arg1.farm_id, 202);
        let JewelMagmaPosition {
            id      : v0,
            farm_id : _,
            share   : v2,
            name    : _,
        } = arg1;
        0x2::object::delete(v0);
        arg0.share = arg0.share + v2;
    }

    public fun share(arg0: &JewelMagmaPosition) : u128 {
        arg0.share
    }

    // decompiled from Move bytecode v7
}

