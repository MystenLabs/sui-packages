module 0xd10f2b8b7338e0790e654f43d78f4ed82eb1603b4700e214b2c9a6f81d392cc6::vault {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        number_of_receivers: u64,
    }

    struct CoinAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        index: u64,
    }

    struct ObjectsAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        objects_count: u64,
        index: u64,
    }

    struct CoinWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        index: u64,
    }

    struct ObjectsWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        objects_count: u64,
        index: u64,
    }

    struct ObjectsGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        objects_count: u64,
        index: u64,
        receiver: address,
        receiver_index: u64,
    }

    struct VaultDestroyedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
    }

    struct ObjectsWrapper<T0: store + key> has store, key {
        id: 0x2::object::UID,
        objects: vector<T0>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        creator: address,
        number_of_receivers: u64,
        contents: 0x2::object_bag::ObjectBag,
        received_count: u64,
    }

    struct VaultManager has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::object_table::ObjectTable<0x2::object::ID, Vault>,
    }

    public fun add_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::length(&arg0.contents);
        let v1 = CoinAddedEvent<T0>{
            vault_id : 0x2::object::id<Vault>(arg0),
            amount   : 0x2::coin::value<T0>(&arg1),
            index    : v0,
        };
        0x2::event::emit<CoinAddedEvent<T0>>(v1);
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, v0, arg1);
    }

    public fun add_objects<T0: store + key>(arg0: &mut Vault, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x1::vector::length<T0>(&arg1);
        assert!(v0 < arg0.number_of_receivers, 9223372994632876039);
        let v1 = 0x2::object_bag::length(&arg0.contents);
        let v2 = ObjectsWrapper<T0>{
            id      : 0x2::object::new(arg2),
            objects : arg1,
        };
        0x2::object_bag::add<u64, ObjectsWrapper<T0>>(&mut arg0.contents, v1, v2);
        let v3 = ObjectsAddedEvent<T0>{
            vault_id      : 0x2::object::id<Vault>(arg0),
            objects_count : v0,
            index         : v1,
        };
        0x2::event::emit<ObjectsAddedEvent<T0>>(v3);
    }

    fun assert_sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_creator(arg0, arg1), 9223372612380655620);
    }

    fun assert_sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) {
        assert!(sender_is_vault_manager(arg0, arg1), 9223372612380655621);
    }

    public fun create_vault(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = Vault{
            id                  : 0x2::object::new(arg2),
            creator             : arg0,
            number_of_receivers : arg1,
            contents            : 0x2::object_bag::new(arg2),
            received_count      : 0,
        };
        let v1 = VaultCreatedEvent{
            vault_id            : 0x2::object::id<Vault>(&v0),
            creator             : arg0,
            number_of_receivers : arg1,
        };
        0x2::event::emit<VaultCreatedEvent>(v1);
        v0
    }

    public fun create_vault_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultManager{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::object_table::new<0x2::object::ID, Vault>(arg0),
        };
        0x2::transfer::share_object<VaultManager>(v0);
    }

    public fun destroy_empty_vault(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id                  : v0,
            creator             : _,
            number_of_receivers : _,
            contents            : v3,
            received_count      : _,
        } = arg0;
        let v5 = v3;
        assert!(0x2::object_bag::length(&v5) == 0, 9223373681827250177);
        0x2::object_bag::destroy_empty(v5);
        let v6 = VaultDestroyedEvent{
            vault_id : 0x2::object::id<Vault>(&arg0),
            creator  : arg0.creator,
        };
        0x2::event::emit<VaultDestroyedEvent>(v6);
        0x2::object::delete(v0);
    }

    public fun destroy_vault_in_manager(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_empty_vault(0x2::object_table::remove<0x2::object::ID, Vault>(&mut arg0.vaults, arg1), arg2);
    }

    public fun give_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg4, arg0);
        let v0 = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v1 = ObjectsGivenEvent<T0>{
            vault_id       : 0x2::object::id<Vault>(arg0),
            objects_count  : 0x1::vector::length<T0>(&v0.objects),
            index          : arg1,
            receiver       : arg2,
            receiver_index : arg3,
        };
        0x2::event::emit<ObjectsGivenEvent<T0>>(v1);
        while (!0x1::vector::is_empty<T0>(&v0.objects)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v0.objects), arg2);
        };
        let ObjectsWrapper {
            id      : v2,
            objects : v3,
        } = v0;
        0x2::object::delete(v2);
        0x1::vector::destroy_empty<T0>(v3);
    }

    public fun give_objects_from_manager<T0: store + key>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        give_objects<T0>(v0, arg2, arg3, arg4, arg5);
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
        0x2::object_table::add<0x2::object::ID, Vault>(&mut arg0.vaults, 0x2::object::id<Vault>(&arg1), arg1);
    }

    fun sender_is_vault_creator(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.creator
    }

    fun sender_is_vault_manager(arg0: &0x2::tx_context::TxContext, arg1: &Vault) : bool {
        0x2::tx_context::sender(arg0) == arg1.creator
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg2, arg0);
        let v0 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
        let v1 = CoinWithdrawnEvent<T0>{
            vault_id : 0x2::object::id<Vault>(arg0),
            amount   : 0x2::coin::value<T0>(&v0),
            index    : arg1,
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
        let v1 = ObjectsWithdrawnEvent<T0>{
            vault_id      : 0x2::object::id<Vault>(arg0),
            objects_count : 0x1::vector::length<T0>(&v0.objects),
            index         : arg1,
        };
        0x2::event::emit<ObjectsWithdrawnEvent<T0>>(v1);
        while (!0x1::vector::is_empty<T0>(&v0.objects)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v0.objects), 0x2::tx_context::sender(arg2));
        };
        let ObjectsWrapper {
            id      : v2,
            objects : v3,
        } = v0;
        0x2::object::delete(v2);
        0x1::vector::destroy_empty<T0>(v3);
    }

    public fun withdraw_objects_from_manager<T0: store + key>(arg0: &mut VaultManager, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Vault>(&mut arg0.vaults, arg1);
        withdraw_objects<T0>(v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

