module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::collections {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        color: vector<u8>,
        description: vector<u8>,
        file_ids: vector<address>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct CollectionCreatedEvent has copy, drop {
        collection_id: address,
        owner: address,
        name: vector<u8>,
    }

    struct CollectionDeletedEvent has copy, drop {
        collection_id: address,
    }

    public fun add_file(arg0: &mut Collection, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<address>(&arg0.file_ids) < 500, 404);
        assert!(!0x1::vector::contains<address>(&arg0.file_ids, &arg1), 401);
        0x1::vector::push_back<address>(&mut arg0.file_ids, arg1);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun color(arg0: &Collection) : &vector<u8> {
        &arg0.color
    }

    public fun contains_file(arg0: &Collection, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.file_ids, &arg1)
    }

    public fun create_collection(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Collection {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::assert_active(arg1, arg5);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 403);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Collection{
            id            : 0x2::object::new(arg6),
            name          : arg2,
            color         : arg3,
            description   : arg4,
            file_ids      : 0x1::vector::empty<address>(),
            created_at_ms : v0,
            updated_at_ms : v0,
        };
        let v2 = CollectionCreatedEvent{
            collection_id : 0x2::object::id_address<Collection>(&v1),
            owner         : 0x2::tx_context::sender(arg6),
            name          : v1.name,
        };
        0x2::event::emit<CollectionCreatedEvent>(v2);
        v1
    }

    public fun delete_collection(arg0: Collection) {
        let Collection {
            id            : v0,
            name          : _,
            color         : _,
            description   : _,
            file_ids      : _,
            created_at_ms : _,
            updated_at_ms : _,
        } = arg0;
        let v7 = v0;
        let v8 = CollectionDeletedEvent{collection_id: 0x2::object::uid_to_address(&v7)};
        0x2::event::emit<CollectionDeletedEvent>(v8);
        0x2::object::delete(v7);
    }

    public fun file_count(arg0: &Collection) : u64 {
        0x1::vector::length<address>(&arg0.file_ids)
    }

    public fun name(arg0: &Collection) : &vector<u8> {
        &arg0.name
    }

    public fun remove_file(arg0: &mut Collection, arg1: address, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.file_ids, &arg1);
        assert!(v0, 402);
        0x1::vector::remove<address>(&mut arg0.file_ids, v1);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun rename(arg0: &mut Collection, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 403);
        arg0.name = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun update_color(arg0: &mut Collection, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.color = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun update_description(arg0: &mut Collection, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.description = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v7
}

