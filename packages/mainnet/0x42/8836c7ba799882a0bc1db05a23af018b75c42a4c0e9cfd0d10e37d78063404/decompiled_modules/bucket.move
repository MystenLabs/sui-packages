module 0x428836c7ba799882a0bc1db05a23af018b75c42a4c0e9cfd0d10e37d78063404::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public entry fun send_add_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x8964e8085911f1e1bd0e807cc756bea77d4bf11de4b475142ad536951d9e7db5::point::send_add_point_req<Bucket>(v0, arg0, arg1, arg2);
    }

    public entry fun send_stake_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x8964e8085911f1e1bd0e807cc756bea77d4bf11de4b475142ad536951d9e7db5::point::send_stake_point_req<Bucket>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun send_sub_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x8964e8085911f1e1bd0e807cc756bea77d4bf11de4b475142ad536951d9e7db5::point::send_sub_point_req<Bucket>(v0, arg0, arg1, arg2);
    }

    public entry fun send_unstake_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0x8964e8085911f1e1bd0e807cc756bea77d4bf11de4b475142ad536951d9e7db5::point::send_unstake_point_req<Bucket>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

