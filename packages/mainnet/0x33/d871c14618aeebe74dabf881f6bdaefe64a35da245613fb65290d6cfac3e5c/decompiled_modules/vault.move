module 0x33d871c14618aeebe74dabf881f6bdaefe64a35da245613fb65290d6cfac3e5c::vault {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        manager: address,
        max_receivers: u64,
    }

    struct CoinAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        coin_value: u64,
    }

    struct CoinWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        coin_value: u64,
    }

    struct CoinGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        receiver: address,
        received_count: u64,
        remaining_count: u64,
        coin_value: u64,
    }

    struct NumberOfReceiversUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_number_of_receivers: u64,
        new_number_of_receivers: u64,
    }

    struct VaultDestroyedEvent has copy, drop {
        is_by_creator: bool,
        vault_id: 0x2::object::ID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        max_receivers: u64,
        received_count: u64,
        contents: 0x2::object_bag::ObjectBag,
        creator: address,
        manager: address,
    }

    struct VaultManager has key {
        id: 0x2::object::UID,
        manager: address,
        vaults: 0x2::object_table::ObjectTable<0x2::object::ID, Vault>,
    }

    fun assert_sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(0x2::tx_context::sender(arg0) == arg1.creator, 0);
    }

    fun assert_sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(0x2::tx_context::sender(arg0) == arg1.manager, 1);
    }

    public fun create_giveaway<T0>(arg0: &mut VaultManager, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Vault{
            id             : 0x2::object::new(arg3),
            max_receivers  : arg2,
            received_count : 0,
            contents       : 0x2::object_bag::new(arg3),
            creator        : v0,
            manager        : arg0.manager,
        };
        let v2 = 0;
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut v1.contents, v2, arg1);
        let v3 = VaultCreatedEvent{
            vault_id      : 0x2::object::uid_to_inner(&v1.id),
            creator       : v0,
            manager       : arg0.manager,
            max_receivers : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        let v4 = CoinAddedEvent<T0>{
            vault_id   : 0x2::object::uid_to_inner(&v1.id),
            index      : v2,
            coin_value : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CoinAddedEvent<T0>>(v4);
        0x2::object_table::add<0x2::object::ID, Vault>(&mut arg0.vaults, 0x2::object::id<Vault>(&v1), v1);
    }

    public fun create_vault_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultManager{
            id      : 0x2::object::new(arg0),
            manager : @0x4fb6bb32eb3f5e495430e00233d3f21354088eee6e2b2e0c25c11815f90eea53,
            vaults  : 0x2::object_table::new<0x2::object::ID, Vault>(arg0),
        };
        0x2::transfer::share_object<VaultManager>(v0);
    }

    public fun destroy_empty_vault(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id             : v0,
            max_receivers  : _,
            received_count : _,
            contents       : v3,
            creator        : v4,
            manager        : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::object_bag::length(&v6) == 0, 2);
        let v8 = VaultDestroyedEvent{
            is_by_creator : 0x2::tx_context::sender(arg1) == v4,
            vault_id      : 0x2::object::uid_to_inner(&v7),
        };
        0x2::event::emit<VaultDestroyedEvent>(v8);
        0x2::object::delete(v7);
        0x2::object_bag::destroy_empty(v6);
    }

    public fun destroy_vault_in_manager(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_empty_vault(0x2::object_table::remove<0x2::object::ID, Vault>(&mut arg0.vaults, arg1), arg2);
    }

    public fun give_coin_to_receiver<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg3, arg0);
        let v0 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
        let v1 = 0x2::coin::value<T0>(v0) / arg0.max_receivers;
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v0, v1, arg3), arg2);
        arg0.received_count = arg0.received_count + 1;
        let v2 = CoinGivenEvent<T0>{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            index           : arg1,
            receiver        : arg2,
            received_count  : arg0.received_count,
            remaining_count : arg0.max_receivers - arg0.received_count,
            coin_value      : v1,
        };
        0x2::event::emit<CoinGivenEvent<T0>>(v2);
    }

    public fun give_coin_to_receiver_in_manager<T0>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        give_coin_to_receiver<T0>(v0, arg2, arg3, arg4);
    }

    public fun increase_received_count(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.received_count = arg0.received_count + 1;
        let v0 = NumberOfReceiversUpdatedEvent{
            vault_id                : 0x2::object::uid_to_inner(&arg0.id),
            old_number_of_receivers : arg0.received_count - 1,
            new_number_of_receivers : arg0.received_count,
        };
        0x2::event::emit<NumberOfReceiversUpdatedEvent>(v0);
    }

    public fun increase_received_count_in_manager(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        increase_received_count(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_vault_manager(arg0);
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
        let v1 = CoinWithdrawnEvent<T0>{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            index      : arg1,
            coin_value : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<CoinWithdrawnEvent<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.creator);
    }

    public fun withdraw_coin_from_manager<T0>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        withdraw_coin<T0>(v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

