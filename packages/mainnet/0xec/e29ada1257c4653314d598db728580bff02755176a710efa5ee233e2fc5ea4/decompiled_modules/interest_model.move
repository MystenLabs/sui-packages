module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::interest_model {
    struct UtilizationZone has store {
        next_zone_value: u128,
        k: u128,
        is_k_negative: bool,
        c: u128,
        is_c_negative: bool,
    }

    struct UtilizationZoneStore has store {
        zones: vector<UtilizationZone>,
    }

    public entry fun add_zone(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u128, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<UtilizationZoneStore>(arg0, v0), 3);
        let v1 = UtilizationZone{
            next_zone_value : arg1,
            k               : arg2,
            is_k_negative   : arg3,
            c               : arg4,
            is_c_negative   : arg5,
        };
        0x1::vector::push_back<UtilizationZone>(&mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<UtilizationZoneStore>(arg0, v0).zones, v1);
    }

    public fun get_interest_rate(arg0: &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: address, arg2: u64, arg3: u64) : u64 {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        if (0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<UtilizationZoneStore>(arg0, arg1)) {
            if (arg2 == 0 && arg3 == 0) {
                return 0
            };
            let v0 = (arg2 as u128) * (1000000000000000000 as u128) / ((arg2 as u128) + (arg3 as u128));
            let v1 = &0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow<UtilizationZoneStore>(arg0, arg1).zones;
            let v2 = 0;
            while (v2 < 0x1::vector::length<UtilizationZone>(v1)) {
                let v3 = 0x1::vector::borrow<UtilizationZone>(v1, v2);
                if (v0 < v3.next_zone_value) {
                    let v4 = v3.is_k_negative && v3.is_c_negative;
                    assert!(!v4, 2);
                    if (v3.is_k_negative) {
                        return (((v3.c - v0 * v3.k / 1000000000000) / (31536000 as u128)) as u64)
                    };
                    if (v3.is_c_negative) {
                        return (((v0 * v3.k / 1000000000000 - v3.c) / (31536000 as u128)) as u64)
                    };
                    return (((v0 * v3.k / 1000000000000 + v3.c) / (31536000 as u128)) as u64)
                };
                v2 = v2 + 1;
            };
        };
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::triple_slope_model::get_interest_rate(arg1, arg2, arg3)
    }

    public fun get_interest_rate_scale() : u64 {
        1000000000000000000
    }

    public fun register(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        assert!(!0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<UtilizationZoneStore>(arg0, 0x2::tx_context::sender(arg1)), 1);
        let v0 = UtilizationZoneStore{zones: 0x1::vector::empty<UtilizationZone>()};
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::add<UtilizationZoneStore>(arg0, v0, arg1);
    }

    public entry fun remove_zone(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<UtilizationZoneStore>(arg0, v0), 3);
        let v1 = &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<UtilizationZoneStore>(arg0, v0).zones;
        assert!(0x1::vector::length<UtilizationZone>(v1) > arg1, 5);
        let UtilizationZone {
            next_zone_value : _,
            k               : _,
            is_k_negative   : _,
            c               : _,
            is_c_negative   : _,
        } = 0x1::vector::remove<UtilizationZone>(v1, arg1);
    }

    public entry fun set_zone(arg0: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg1: u64, arg2: u128, arg3: u128, arg4: bool, arg5: u128, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::contains<UtilizationZoneStore>(arg0, v0), 3);
        let v1 = &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::borrow_mut<UtilizationZoneStore>(arg0, v0).zones;
        assert!(0x1::vector::length<UtilizationZone>(v1) > arg1, 5);
        let v2 = 0x1::vector::borrow_mut<UtilizationZone>(v1, arg1);
        v2.next_zone_value = arg2;
        v2.k = arg3;
        v2.is_k_negative = arg4;
        v2.c = arg5;
        v2.is_c_negative = arg6;
    }

    // decompiled from Move bytecode v6
}

