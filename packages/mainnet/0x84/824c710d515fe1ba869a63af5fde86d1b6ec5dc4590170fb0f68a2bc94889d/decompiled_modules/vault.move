module 0x84824c710d515fe1ba869a63af5fde86d1b6ec5dc4590170fb0f68a2bc94889d::vault {
    struct ObjectsWrapper<T0: store + key> has store, key {
        id: 0x2::object::UID,
        how_many_each: u64,
        objects: vector<T0>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        max_receivers: u64,
        received_count: u64,
        contents: 0x2::object_bag::ObjectBag,
        creator: address,
        manager: address,
    }

    public fun add_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, 0x2::object_bag::length(&arg0.contents), arg1);
    }

    public fun add_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg3, arg0);
        assert!(0x1::vector::length<T0>(&arg2) < arg1 * arg0.max_receivers, 9223372466351898631);
        let v0 = ObjectsWrapper<T0>{
            id            : 0x2::object::new(arg3),
            how_many_each : arg1,
            objects       : arg2,
        };
        0x2::object_bag::add<u64, ObjectsWrapper<T0>>(&mut arg0.contents, 0x2::object_bag::length(&arg0.contents), v0);
    }

    fun assert_sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_creator(arg0, arg1), 9223372255898238979);
    }

    fun assert_sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_manager(arg0, arg1), 9223372303143010309);
    }

    public fun create_vault(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id             : 0x2::object::new(arg2),
            max_receivers  : arg1,
            received_count : 0,
            contents       : 0x2::object_bag::new(arg2),
            creator        : 0x2::tx_context::sender(arg2),
            manager        : arg0,
        }
    }

    public fun destroy_empty_vault(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id             : v0,
            max_receivers  : v1,
            received_count : v2,
            contents       : v3,
            creator        : _,
            manager        : _,
        } = arg0;
        let v6 = v3;
        assert!(0x2::object_bag::length(&v6) == 0, 9223372934502940673);
        assert!(v1 == v2, 9223372951682809857);
        0x2::object::delete(v0);
        0x2::object_bag::destroy_empty(v6);
    }

    public fun give_coin_to_receiver<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg3, arg0);
        let v0 = arg0.max_receivers - arg0.received_count;
        if (v0 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1), arg2);
        } else {
            let v1 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, 0x2::coin::value<T0>(v1) / v0, arg3), arg2);
        };
    }

    public fun give_object_to_receiver<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg3, arg0);
        let v0 = 0x2::object_bag::borrow_mut<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v1 = 0;
        while (v1 < v0.how_many_each) {
            if (0x1::vector::length<T0>(&v0.objects) >= 0) {
                0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v0.objects), arg2);
            };
            v1 = v1 + 1;
        };
        if (arg0.max_receivers - arg0.received_count == 1 && 0x1::vector::length<T0>(&v0.objects) == 0) {
            let ObjectsWrapper {
                id            : v2,
                how_many_each : _,
                objects       : v4,
            } = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, v1);
            0x2::object::delete(v2);
            0x1::vector::destroy_empty<T0>(v4);
        };
    }

    public fun increase_received_count(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.received_count = arg0.received_count + 1;
    }

    fun sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.creator
    }

    fun sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.manager
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1), arg0.creator);
    }

    public fun withdraw_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v1 = &mut v0.objects;
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(v1)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(v1), arg0.creator);
            v2 = v2 + 1;
        };
        let ObjectsWrapper {
            id            : v3,
            how_many_each : _,
            objects       : v5,
        } = v0;
        0x2::object::delete(v3);
        0x1::vector::destroy_empty<T0>(v5);
    }

    // decompiled from Move bytecode v6
}

