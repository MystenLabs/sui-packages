module 0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::profile::AdmincCap, arg1: &mut 0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    public fun send_add_point_req_with_owner(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x189202e2b5e60999f85ba7c3ea2be513a1e586d402fbfdb5ead97f77f0373968::point::send_add_point_req_with_owner<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

