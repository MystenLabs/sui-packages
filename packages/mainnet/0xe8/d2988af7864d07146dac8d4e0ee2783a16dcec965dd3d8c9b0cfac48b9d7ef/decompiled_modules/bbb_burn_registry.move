module 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn_registry {
    struct BurnRegistry has key {
        id: 0x2::object::UID,
        burns: vector<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>,
    }

    struct BBB_BURN_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get<T0>(arg0: &BurnRegistry) : 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.burns;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v1)) {
            if (0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::coin_type(0x1::vector::borrow<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v1, v2)) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 1001);
                return *0x1::vector::borrow<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(&arg0.burns, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : BurnRegistry {
        BurnRegistry{
            id    : 0x2::object::new(arg0),
            burns : 0x1::vector::empty<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(),
        }
    }

    public fun add(arg0: &mut BurnRegistry, arg1: &0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_admin::BBBAdminCap, arg2: 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v0)) {
            if (0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::coin_type(0x1::vector::borrow<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v0, v1)) == 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::coin_type(&arg2)) {
                v2 = true;
                /* label 6 */
                assert!(!v2, 1000);
                0x1::vector::push_back<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(&mut arg0.burns, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun burns(arg0: &BurnRegistry) : &vector<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn> {
        &arg0.burns
    }

    public fun id(arg0: &BurnRegistry) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: BBB_BURN_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BurnRegistry>(new(arg1));
    }

    public fun remove<T0>(arg0: &mut BurnRegistry, arg1: &0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v0)) {
            let v3 = 0x1::type_name::get<T0>();
            if (0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::coin_type(0x1::vector::borrow<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(v0, v1)) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                0x1::vector::swap_remove<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(&mut arg0.burns, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun remove_all(arg0: &mut BurnRegistry, arg1: &0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(&arg0.burns)) {
            0x1::vector::pop_back<0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_burn::Burn>(&mut arg0.burns);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

