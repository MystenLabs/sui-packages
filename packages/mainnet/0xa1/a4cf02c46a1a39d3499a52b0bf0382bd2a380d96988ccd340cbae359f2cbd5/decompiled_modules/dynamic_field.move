module 0x1139e423b2ecefaf1fe80629f74a23f21e59f03d1618acfc4899adf0fac5ff1f::dynamic_field {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Child has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct LpCoin has drop {
        dummy_field: bool,
    }

    struct ObjectWithSameSizeAsTreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    struct ComplexChild<phantom T0> has store, key {
        id: 0x2::object::UID,
        id_1: 0x2::object::ID,
        treasury: ObjectWithSameSizeAsTreasuryCap<T0>,
        number_1: u64,
        vector_1: vector<0x1::type_name::TypeName>,
        vector_2: vector<u64>,
        vector_3: vector<u64>,
        vector_4: vector<u64>,
        vector_5: vector<u64>,
        vector_6: vector<0x2::object::ID>,
        vector_7: vector<u64>,
        number_2: u64,
        number_3: u64,
        number_4: u64,
        vector_8: vector<0x1::type_name::TypeName>,
        vector_9: vector<0x1::type_name::TypeName>,
        number_5: u64,
        number_6: u64,
        id_2: 0x2::object::ID,
    }

    struct Parent has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow(arg0: &Parent) : &Child {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v0)
    }

    public fun borrow_mut(arg0: &mut Parent) : &mut Child {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, Child>(&mut arg0.id, v0)
    }

    public fun add_complex_child(arg0: &mut Parent, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Key{dummy_field: false};
        let Child {
            id    : v1,
            value : _,
        } = 0x2::dynamic_field::remove<Key, Child>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        let v3 = 0x2::object::uid_to_inner(&arg0.id);
        let v4 = LpCoin{dummy_field: false};
        let v5 = ObjectWithSameSizeAsTreasuryCap<LpCoin>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::balance::create_supply<LpCoin>(v4),
        };
        let v6 = ComplexChild<LpCoin>{
            id       : 0x2::object::new(arg1),
            id_1     : v3,
            treasury : v5,
            number_1 : 1,
            vector_1 : 0x1::vector::empty<0x1::type_name::TypeName>(),
            vector_2 : vector[],
            vector_3 : vector[],
            vector_4 : vector[],
            vector_5 : vector[],
            vector_6 : 0x1::vector::empty<0x2::object::ID>(),
            vector_7 : vector[],
            number_2 : 2,
            number_3 : 3,
            number_4 : 4,
            vector_8 : 0x1::vector::empty<0x1::type_name::TypeName>(),
            vector_9 : 0x1::vector::empty<0x1::type_name::TypeName>(),
            number_5 : 5,
            number_6 : 6,
            id_2     : v3,
        };
        let v7 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, ComplexChild<LpCoin>>(&mut arg0.id, v7, v6);
    }

    public fun borrow_mut_n_times(arg0: &mut Parent, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::borrow_mut<Key, Child>(&mut arg0.id, v1);
            v0 = v0 + 1;
        };
    }

    public fun borrow_n_times(arg0: &Parent, arg1: u64) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = Key{dummy_field: false};
            0x2::dynamic_field::borrow<Key, Child>(&arg0.id, v1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun create_parent_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Parent{id: 0x2::object::new(arg0)};
        let v1 = Child{
            id    : 0x2::object::new(arg0),
            value : 42,
        };
        let v2 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, Child>(&mut v0.id, v2, v1);
        0x2::transfer::share_object<Parent>(v0);
    }

    // decompiled from Move bytecode v6
}

