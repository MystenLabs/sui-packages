module 0xb5860e8340c6536a9924ed0939368f703300a8156976072a74b85f3b4cbb8d02::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public entry fun send_add_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::point::send_add_point_req<Bucket>(v0, arg0, arg1, arg2);
    }

    public entry fun send_stake_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::point::send_stake_point_req<Bucket>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun send_sub_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::point::send_sub_point_req<Bucket>(v0, arg0, arg1, arg2);
    }

    public entry fun send_unstake_point_req(arg0: 0x1::ascii::String, arg1: u256, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Bucket{dummy_field: false};
        0xed8e8894181fbcda554bea8adb062b9f9b8556f78e8e10dbd21cda6ca8b7a86b::point::send_unstake_point_req<Bucket>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

