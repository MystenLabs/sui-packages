module 0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::profile::AdmincCap, arg1: &mut 0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    public fun send_add_point_req_with_owner(arg0: address, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x84028aa46fd78f8f1079deb7fc11a874d5331cd3b676efd82eb597d0534eb10e::point::send_add_point_req_with_owner<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

