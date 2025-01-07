module 0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::profile::AdmincCap, arg1: &mut 0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    public fun send_add_request(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x1c66c8835ab8e7abb292514eb1a9fff9082c1467f578f32f5ced0046f7184590::point::send_add_point_req_with_owner<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

