module 0x68b281436fdb7620e4770f7319fbc0b3f77c43cbe5ed8078096e1f6ccfa219cb::vault {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        manager: address,
        max_receivers: u64,
        end_time: u64,
        distribution_type: u8,
    }

    struct CoinAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        coin_value: u64,
    }

    struct ParticipantRegisteredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        participant: address,
        registration_time: u64,
    }

    struct TokensDistributedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        distribution_type: u8,
        receivers: vector<address>,
        amount_per_receiver: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        max_receivers: u64,
        received_count: u64,
        contents: 0x2::object_bag::ObjectBag,
        creator: address,
        manager: address,
        end_time: u64,
        participants: vector<address>,
        distribution_type: u8,
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

    public fun create_giveaway<T0>(arg0: &mut VaultManager, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 0 || arg4 == 1, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg3;
        let v2 = Vault{
            id                : 0x2::object::new(arg6),
            max_receivers     : arg2,
            received_count    : 0,
            contents          : 0x2::object_bag::new(arg6),
            creator           : v0,
            manager           : arg0.manager,
            end_time          : v1,
            participants      : 0x1::vector::empty<address>(),
            distribution_type : arg4,
        };
        let v3 = 0;
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut v2.contents, v3, arg1);
        let v4 = VaultCreatedEvent{
            vault_id          : 0x2::object::uid_to_inner(&v2.id),
            creator           : v0,
            manager           : arg0.manager,
            max_receivers     : arg2,
            end_time          : v1,
            distribution_type : arg4,
        };
        0x2::event::emit<VaultCreatedEvent>(v4);
        let v5 = CoinAddedEvent<T0>{
            vault_id   : 0x2::object::uid_to_inner(&v2.id),
            index      : v3,
            coin_value : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CoinAddedEvent<T0>>(v5);
        0x2::object_table::add<0x2::object::ID, Vault>(&mut arg0.vaults, 0x2::object::id<Vault>(&v2), v2);
    }

    public fun distribute_fcfs<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg2, arg0);
        assert!(arg0.distribution_type == 0, 7);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_time, 5);
        let v0 = 0x1::vector::length<address>(&arg0.participants);
        assert!(v0 > 0, 3);
        let v1 = if (v0 < arg0.max_receivers) {
            v0
        } else {
            arg0.max_receivers
        };
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, 0);
        let v4 = 0x2::coin::value<T0>(v3) / v1;
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<address>(&arg0.participants, v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v3, v4, arg2), v6);
            0x1::vector::push_back<address>(&mut v2, v6);
            arg0.received_count = arg0.received_count + 1;
            v5 = v5 + 1;
        };
        while (!0x1::vector::is_empty<address>(&arg0.participants)) {
            0x1::vector::pop_back<address>(&mut arg0.participants);
        };
        let v7 = TokensDistributedEvent<T0>{
            vault_id            : 0x2::object::uid_to_inner(&arg0.id),
            distribution_type   : 0,
            receivers           : v2,
            amount_per_receiver : v4,
        };
        0x2::event::emit<TokensDistributedEvent<T0>>(v7);
    }

    public fun execute_raffle<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_manager(arg2, arg0);
        assert!(arg0.distribution_type == 1, 7);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.end_time, 4);
        let v1 = 0x1::vector::length<address>(&arg0.participants);
        assert!(v1 > 0, 3);
        let v2 = if (v1 < arg0.max_receivers) {
            v1
        } else {
            arg0.max_receivers
        };
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x2::object_bag::borrow_mut<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, 0);
        let v5 = 0x2::coin::value<T0>(v4) / v2;
        let v6 = v0 ^ (0x2::tx_context::epoch(arg2) as u64);
        let v7 = 0;
        while (v7 < v2) {
            v6 = v6 + v7;
            let v8 = v6 % 0x1::vector::length<address>(&arg0.participants);
            let v9 = *0x1::vector::borrow<address>(&arg0.participants, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v4, v5, arg2), v9);
            0x1::vector::push_back<address>(&mut v3, v9);
            0x1::vector::swap_remove<address>(&mut arg0.participants, v8);
            arg0.received_count = arg0.received_count + 1;
            v7 = v7 + 1;
        };
        while (!0x1::vector::is_empty<address>(&arg0.participants)) {
            0x1::vector::pop_back<address>(&mut arg0.participants);
        };
        let v10 = TokensDistributedEvent<T0>{
            vault_id            : 0x2::object::uid_to_inner(&arg0.id),
            distribution_type   : 1,
            receivers           : v3,
            amount_per_receiver : v5,
        };
        0x2::event::emit<TokensDistributedEvent<T0>>(v10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultManager{
            id      : 0x2::object::new(arg0),
            manager : @0x518a3d64516564dbc54bd1363985b502b4860f0a28a5b7ab531a1e1bc94604d9,
            vaults  : 0x2::object_table::new<0x2::object::ID, Vault>(arg0),
        };
        0x2::transfer::share_object<VaultManager>(v0);
    }

    public fun register_participant(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < arg0.end_time, 5);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.participants)) {
            assert!(*0x1::vector::borrow<address>(&arg0.participants, v2) != v1, 8);
            v2 = v2 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.participants, v1);
        let v3 = ParticipantRegisteredEvent{
            vault_id          : 0x2::object::uid_to_inner(&arg0.id),
            participant       : v1,
            registration_time : v0,
        };
        0x2::event::emit<ParticipantRegisteredEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

