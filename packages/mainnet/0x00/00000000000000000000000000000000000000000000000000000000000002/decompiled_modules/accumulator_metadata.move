module 0x2::accumulator_metadata {
    struct OwnerKey has copy, drop, store {
        owner: address,
    }

    struct Owner has store {
        balances: 0x2::bag::Bag,
        owner: address,
    }

    struct MetadataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store {
        fields: 0x2::bag::Bag,
    }

    fun accumulator_owner_attach_metadata<T0>(arg0: &mut Owner, arg1: Metadata<T0>) {
        let v0 = MetadataKey<T0>{dummy_field: false};
        0x2::bag::add<MetadataKey<T0>, Metadata<T0>>(&mut arg0.balances, v0, arg1);
    }

    fun accumulator_owner_destroy(arg0: Owner) {
        let Owner {
            balances : v0,
            owner    : _,
        } = arg0;
        0x2::bag::destroy_empty(v0);
    }

    fun accumulator_owner_detach_metadata<T0>(arg0: &mut Owner) : Metadata<T0> {
        let v0 = MetadataKey<T0>{dummy_field: false};
        0x2::bag::remove<MetadataKey<T0>, Metadata<T0>>(&mut arg0.balances, v0)
    }

    fun accumulator_root_attach_owner(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: Owner) {
        let v0 = OwnerKey{owner: arg1.owner};
        0x2::dynamic_field::add<OwnerKey, Owner>(0x2::accumulator::root_id_mut(arg0), v0, arg1);
    }

    fun accumulator_root_borrow_owner_mut(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address) : &mut Owner {
        let v0 = OwnerKey{owner: arg1};
        0x2::dynamic_field::borrow_mut<OwnerKey, Owner>(0x2::accumulator::root_id_mut(arg0), v0)
    }

    fun accumulator_root_detach_owner(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address) : Owner {
        let v0 = OwnerKey{owner: arg1};
        0x2::dynamic_field::remove<OwnerKey, Owner>(0x2::accumulator::root_id_mut(arg0), v0)
    }

    fun accumulator_root_owner_exists(arg0: &0x2::accumulator::AccumulatorRoot, arg1: address) : bool {
        let v0 = OwnerKey{owner: arg1};
        0x2::dynamic_field::exists_with_type<OwnerKey, Owner>(0x2::accumulator::root_id(arg0), v0)
    }

    public(friend) fun create_accumulator_metadata<T0>(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Metadata<T0>{fields: 0x2::bag::new(arg2)};
        if (accumulator_root_owner_exists(arg0, arg1)) {
            let v1 = accumulator_root_borrow_owner_mut(arg0, arg1);
            assert!(v1.owner == arg1, 0);
            accumulator_owner_attach_metadata<T0>(v1, v0);
        } else {
            let v2 = Owner{
                balances : 0x2::bag::new(arg2),
                owner    : arg1,
            };
            let v3 = &mut v2;
            accumulator_owner_attach_metadata<T0>(v3, v0);
            accumulator_root_attach_owner(arg0, v2);
        };
    }

    public(friend) fun remove_accumulator_metadata<T0>(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address) {
        let v0 = accumulator_root_borrow_owner_mut(arg0, arg1);
        let v1 = accumulator_owner_detach_metadata<T0>(v0);
        let Metadata { fields: v2 } = v1;
        0x2::bag::destroy_empty(v2);
        if (0x2::bag::is_empty(&v0.balances)) {
            accumulator_owner_destroy(accumulator_root_detach_owner(arg0, arg1));
        };
    }

    // decompiled from Move bytecode v6
}

