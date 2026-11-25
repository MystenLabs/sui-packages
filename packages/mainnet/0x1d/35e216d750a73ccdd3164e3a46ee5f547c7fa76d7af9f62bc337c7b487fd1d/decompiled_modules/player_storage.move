module 0x1d35e216d750a73ccdd3164e3a46ee5f547c7fa76d7af9f62bc337c7b487fd1d::player_storage {
    struct StorageSlot<T0: store + key> has store {
        item: 0x2::borrow::Referent<T0>,
        locks: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Lock<phantom T0, phantom T1> has store {
        dummy_field: bool,
    }

    struct SlotKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct ItemStoredEvent<phantom T0> has copy, drop {
        player_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemWithdrawnEvent<phantom T0> has copy, drop {
        player_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemLockedEvent<phantom T0, phantom T1> has copy, drop {
        player_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemUnlockedEvent<phantom T0, phantom T1> has copy, drop {
        player_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID) : (T0, 0x2::borrow::Borrow) {
        let v0 = SlotKey{pos0: arg1};
        0x2::borrow::borrow<T0>(&mut 0x2::dynamic_field::borrow_mut<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v0).item)
    }

    public fun put_back<T0: store + key>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: T0, arg2: 0x2::borrow::Borrow) {
        let v0 = SlotKey{pos0: 0x2::object::id<T0>(&arg1)};
        0x2::borrow::put_back<T0>(&mut 0x2::dynamic_field::borrow_mut<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v0).item, arg1, arg2);
    }

    public fun has_item(arg0: &0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID) : bool {
        let v0 = SlotKey{pos0: arg1};
        0x2::dynamic_field::exists<SlotKey>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid(arg0), v0)
    }

    public fun lock<T0: store + key, T1: drop>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID, arg2: T1) : Lock<T0, T1> {
        let v0 = SlotKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v0);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.locks, &v2), 1);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&v1.locks) < 8, 2);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1.locks, v2);
        let v3 = ItemLockedEvent<T0, T1>{
            player_id : 0x2::object::id<0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player>(arg0),
            item_id   : arg1,
        };
        0x2::event::emit<ItemLockedEvent<T0, T1>>(v3);
        Lock<T0, T1>{dummy_field: false}
    }

    public fun locks<T0: store + key>(arg0: &0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let v0 = SlotKey{pos0: arg1};
        &0x2::dynamic_field::borrow<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid(arg0), v0).locks
    }

    public fun max_locks() : u64 {
        8
    }

    public fun store<T0: store + key>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = StorageSlot<T0>{
            item  : 0x2::borrow::new<T0>(arg1, arg2),
            locks : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v2 = SlotKey{pos0: v0};
        0x2::dynamic_field::add<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v2, v1);
        let v3 = ItemStoredEvent<T0>{
            player_id : 0x2::object::id<0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player>(arg0),
            item_id   : v0,
        };
        0x2::event::emit<ItemStoredEvent<T0>>(v3);
    }

    public fun unlock<T0: store + key, T1>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID, arg2: Lock<T0, T1>) {
        let Lock {  } = arg2;
        let v0 = SlotKey{pos0: arg1};
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut 0x2::dynamic_field::borrow_mut<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v0).locks, &v1);
        let v2 = ItemUnlockedEvent<T0, T1>{
            player_id : 0x2::object::id<0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player>(arg0),
            item_id   : arg1,
        };
        0x2::event::emit<ItemUnlockedEvent<T0, T1>>(v2);
    }

    public fun withdraw<T0: store + key>(arg0: &mut 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player, arg1: 0x2::object::ID) : T0 {
        let v0 = SlotKey{pos0: arg1};
        let StorageSlot {
            item  : v1,
            locks : v2,
        } = 0x2::dynamic_field::remove<SlotKey, StorageSlot<T0>>(0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::uid_mut(arg0), v0);
        let v3 = v2;
        assert!(0x2::vec_set::is_empty<0x1::type_name::TypeName>(&v3), 0);
        let v4 = ItemWithdrawnEvent<T0>{
            player_id : 0x2::object::id<0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player::Player>(arg0),
            item_id   : arg1,
        };
        0x2::event::emit<ItemWithdrawnEvent<T0>>(v4);
        0x2::borrow::destroy<T0>(v1)
    }

    // decompiled from Move bytecode v7
}

