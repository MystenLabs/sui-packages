module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::pool {
    struct CoordinationPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        offer_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        creator: address,
    }

    public fun contains<T0, T1>(arg0: &CoordinationPool<T0, T1>, arg1: &0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.offer_ids, arg1)
    }

    public fun add_offer<T0, T1>(arg0: &mut CoordinationPool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_pool_creator());
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.offer_ids, &arg1), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_already_in_pool());
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.offer_ids, arg1);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_added_to_pool(0x2::object::uid_to_inner(&arg0.id), arg1, 0x2::tx_context::sender(arg2));
    }

    public fun create<T0, T1>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::empty_pool_name());
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = CoordinationPool<T0, T1>{
            id        : 0x2::object::new(arg1),
            name      : arg0,
            offer_ids : 0x2::vec_set::empty<0x2::object::ID>(),
            creator   : v0,
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_pool_created(0x2::object::uid_to_inner(&v1.id), v0, v1.name);
        0x2::transfer::public_share_object<CoordinationPool<T0, T1>>(v1);
    }

    public fun creator<T0, T1>(arg0: &CoordinationPool<T0, T1>) : address {
        arg0.creator
    }

    public fun name<T0, T1>(arg0: &CoordinationPool<T0, T1>) : vector<u8> {
        arg0.name
    }

    public fun offer_ids<T0, T1>(arg0: &CoordinationPool<T0, T1>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.offer_ids
    }

    public fun pool_id<T0, T1>(arg0: &CoordinationPool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun remove_offer<T0, T1>(arg0: &mut CoordinationPool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_pool_creator());
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.offer_ids, &arg1), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_not_in_pool());
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.offer_ids, &arg1);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_offer_removed_from_pool(0x2::object::uid_to_inner(&arg0.id), arg1, 0x2::tx_context::sender(arg2));
    }

    public fun size<T0, T1>(arg0: &CoordinationPool<T0, T1>) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.offer_ids)
    }

    // decompiled from Move bytecode v6
}

