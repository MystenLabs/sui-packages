module 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::validation {
    public fun validate_borrow(arg0: &mut 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_index(arg0, arg1);
        let v4 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v0, v2);
        let v5 = 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_mul(v1, v3);
        assert!(v5 + (arg2 as u256) < v4, 44006);
        assert!(0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v5 + (arg2 as u256), v4), 44005);
    }

    public fun validate_deposit(arg0: &mut 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_total_supply(arg0, arg1);
        assert!(0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray(), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_withdraw(arg0: &mut 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xe05504e91d30616d7e2a29e43454601a2ab69988fc259314b513a9e6d22f51d9::storage::get_total_supply(arg0, arg1);
        assert!(v0 >= v1 + (arg2 as u256), 44006);
    }

    // decompiled from Move bytecode v6
}

