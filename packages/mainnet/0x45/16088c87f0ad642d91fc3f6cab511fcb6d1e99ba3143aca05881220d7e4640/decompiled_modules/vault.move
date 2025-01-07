module 0x4516088c87f0ad642d91fc3f6cab511fcb6d1e99ba3143aca05881220d7e4640::vault {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        manager: address,
        max_receivers: u64,
    }

    struct CoinAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        coin_value: u64,
    }

    struct ObjectsAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        total_items: u64,
        items_per_receiver: u64,
    }

    struct CoinWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        coin_value: u64,
    }

    struct ObjectsWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        total_items: u64,
    }

    struct CoinGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        received_count: u64,
        remaining_count: u64,
        coin_value: u64,
    }

    struct ObjectsGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        receiver: address,
        received_count: u64,
        remaining_count: u64,
        amount: u64,
    }

    struct VaultDestroyedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct ObjectsWrapper<T0: store + key> has store, key {
        id: 0x2::object::UID,
        items_per_receiver: u64,
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

    struct VaultManager has store, key {
        id: 0x2::object::UID,
        manager: address,
        vaults: 0x2::object_table::ObjectTable<0x2::object::ID, Vault>,
    }

    public fun add_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = CoinAddedEvent<T0>{
            vault_id   : 0x2::object::id<Vault>(arg0),
            coin_value : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CoinAddedEvent<T0>>(v0);
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, 0x2::object_bag::length(&arg0.contents), arg1);
    }

    public fun add_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg3, arg0);
        let v0 = 0x1::vector::length<T0>(&arg2);
        assert!(v0 < arg1 * arg0.max_receivers, 9223372930208366599);
        let v1 = ObjectsWrapper<T0>{
            id                 : 0x2::object::new(arg3),
            items_per_receiver : arg1,
            objects            : arg2,
        };
        0x2::object_bag::add<u64, ObjectsWrapper<T0>>(&mut arg0.contents, 0x2::object_bag::length(&arg0.contents), v1);
        let v2 = ObjectsAddedEvent<T0>{
            vault_id           : 0x2::object::id<Vault>(arg0),
            total_items        : v0,
            items_per_receiver : arg1,
        };
        0x2::event::emit<ObjectsAddedEvent<T0>>(v2);
    }

    fun assert_sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_creator(arg0, arg1), 9223372466351636483);
    }

    fun assert_sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_manager(arg0, arg1), 9223372513596407813);
    }

    fun assert_vault_manager_is_the_same(arg0: &VaultManager, arg1: &Vault) {
        assert!(arg0.manager == arg1.manager, 9223372556546080773);
    }

    public fun create_vault(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = Vault{
            id             : 0x2::object::new(arg2),
            max_receivers  : arg1,
            received_count : 0,
            contents       : 0x2::object_bag::new(arg2),
            creator        : 0x2::tx_context::sender(arg2),
            manager        : arg0,
        };
        let v1 = VaultCreatedEvent{
            vault_id      : 0x2::object::id<Vault>(&v0),
            creator       : 0x2::tx_context::sender(arg2),
            manager       : arg0,
            max_receivers : arg1,
        };
        0x2::event::emit<VaultCreatedEvent>(v1);
        v0
    }

    public fun create_vault_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultManager{
            id      : 0x2::object::new(arg0),
            manager : 0x2::tx_context::sender(arg0),
            vaults  : 0x2::object_table::new<0x2::object::ID, Vault>(arg0),
        };
        0x2::transfer::share_object<VaultManager>(v0);
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
        let v7 = v0;
        assert!(0x2::object_bag::length(&v6) == 0, 9223373570158100481);
        assert!(v1 == v2, 9223373587337969665);
        let v8 = VaultDestroyedEvent{vault_id: 0x2::object::uid_to_inner(&v7)};
        0x2::event::emit<VaultDestroyedEvent>(v8);
        0x2::object::delete(v7);
        0x2::object_bag::destroy_empty(v6);
    }

    public fun destroy_vault_in_manager(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_empty_vault(0x2::object_table::remove<0x2::object::ID, Vault>(&mut arg0.vaults, arg1), arg2);
    }

    public fun give_coin_to_receiver<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg3, arg0);
        let v0 = arg0.max_receivers - arg0.received_count;
        let v1 = if (v0 == 1) {
            let v2 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg2);
            0x2::coin::value<T0>(&v2)
        } else {
            let v3 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
            let v4 = 0x2::coin::value<T0>(v3) / v0;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, v4, arg3), arg2);
            v4
        };
        let v5 = CoinGivenEvent<T0>{
            vault_id        : 0x2::object::id<Vault>(arg0),
            receiver        : arg2,
            received_count  : arg0.received_count,
            remaining_count : v0,
            coin_value      : v1,
        };
        0x2::event::emit<CoinGivenEvent<T0>>(v5);
    }

    public fun give_coin_to_receiver_in_manager<T0>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        give_coin_to_receiver<T0>(v0, arg2, arg3, arg4);
    }

    public fun give_object_to_receiver<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg3, arg0);
        let v0 = arg0.max_receivers - arg0.received_count;
        let v1 = 0x2::object_bag::borrow_mut<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v2 = v1.items_per_receiver;
        let v3 = ObjectsGivenEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            receiver        : arg2,
            received_count  : arg0.received_count,
            remaining_count : v0,
            amount          : v2,
        };
        0x2::event::emit<ObjectsGivenEvent<T0>>(v3);
        let v4 = 0;
        while (v4 < v2) {
            if (0x1::vector::length<T0>(&v1.objects) >= 0) {
                0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v1.objects), arg2);
            };
            v4 = v4 + 1;
        };
        if (v0 == 1 && 0x1::vector::length<T0>(&v1.objects) == 0) {
            let ObjectsWrapper {
                id                 : v5,
                items_per_receiver : _,
                objects            : v7,
            } = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, v4);
            0x2::object::delete(v5);
            0x1::vector::destroy_empty<T0>(v7);
        };
    }

    public fun give_object_to_receiver_in_manager<T0: store + key>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        give_object_to_receiver<T0>(v0, arg2, arg3, arg4);
    }

    public fun increase_received_count(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.received_count = arg0.received_count + 1;
    }

    public fun increase_received_count_in_manager(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        increase_received_count(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_vault_manager(arg0);
    }

    public fun put_vault_in_manager(arg0: &mut VaultManager, arg1: Vault) {
        assert_vault_manager_is_the_same(arg0, &arg1);
        0x2::object_table::add<0x2::object::ID, Vault>(&mut arg0.vaults, 0x2::object::id<Vault>(&arg1), arg1);
    }

    fun sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.creator
    }

    fun sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.manager
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
        let v1 = CoinWithdrawnEvent<T0>{
            vault_id   : 0x2::object::id<Vault>(arg0),
            coin_value : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<CoinWithdrawnEvent<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.creator);
    }

    public fun withdraw_coin_from_manager<T0>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        withdraw_coin<T0>(v0, arg2, arg3);
    }

    public fun withdraw_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v1 = &mut v0.objects;
        let v2 = 0x1::vector::length<T0>(v1);
        let v3 = 0;
        while (v3 < v2) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(v1), arg0.creator);
            v3 = v3 + 1;
        };
        let ObjectsWrapper {
            id                 : v4,
            items_per_receiver : _,
            objects            : v6,
        } = v0;
        0x2::object::delete(v4);
        0x1::vector::destroy_empty<T0>(v6);
        let v7 = ObjectsWithdrawnEvent<T0>{
            vault_id    : 0x2::object::id<Vault>(arg0),
            total_items : v2,
        };
        0x2::event::emit<ObjectsWithdrawnEvent<T0>>(v7);
    }

    public fun withdraw_objects_from_manager<T0: store + key>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        withdraw_objects<T0>(v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

