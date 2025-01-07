module 0x52c2f7ff5443a1c20345117a96bbd2f1c74ad2d2bd969a2bcae230998b151c2::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0x52c2f7ff5443a1c20345117a96bbd2f1c74ad2d2bd969a2bcae230998b151c2::profile::AdmincCap, arg1: &mut 0x52c2f7ff5443a1c20345117a96bbd2f1c74ad2d2bd969a2bcae230998b151c2::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x52c2f7ff5443a1c20345117a96bbd2f1c74ad2d2bd969a2bcae230998b151c2::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    public fun send_add_point_req_with_owner(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x52c2f7ff5443a1c20345117a96bbd2f1c74ad2d2bd969a2bcae230998b151c2::point::send_add_point_req_with_owner<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

