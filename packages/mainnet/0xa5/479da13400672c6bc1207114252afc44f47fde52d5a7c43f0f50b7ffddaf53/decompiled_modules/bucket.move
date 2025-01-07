module 0xa5479da13400672c6bc1207114252afc44f47fde52d5a7c43f0f50b7ffddaf53::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public entry fun send_add_point_req(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::send_add_point_req<Bucket>(v0, arg0, arg1);
    }

    public entry fun send_stake_point_req<T0>(arg0: u256, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::send_stake_point_req<Bucket, T0>(v0, arg0, arg1, arg2, arg3);
    }

    public entry fun send_sub_point_req(arg0: u256, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::send_sub_point_req<Bucket>(v0, arg0, arg1);
    }

    public entry fun send_unstake_point_req<T0>(arg0: u256, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::send_unstake_point_req<Bucket, T0>(v0, arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

