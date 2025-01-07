module 0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::profile::AdmincCap, arg1: &mut 0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    public fun send_add_point_req_with_owner(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0xe8dd6e808b5228cb2c43e6ca1b1bbda04f2ea64aa60116fae9c35375f1bb9fb8::point::send_add_point_req_with_owner<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

