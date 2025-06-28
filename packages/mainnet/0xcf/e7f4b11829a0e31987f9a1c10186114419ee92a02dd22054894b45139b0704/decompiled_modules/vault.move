module 0xcfe7f4b11829a0e31987f9a1c10186114419ee92a02dd22054894b45139b0704::vault {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        max_receivers: u64,
    }

    struct CoinAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        coin_value: u64,
    }

    struct ObjectsAddedEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        total_items: u64,
        items_per_receiver: u64,
    }

    struct CoinWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        coin_value: u64,
    }

    struct ObjectsWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        total_items: u64,
    }

    struct CoinGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        receiver: address,
        received_count: u64,
        remaining_count: u64,
        coin_value: u64,
    }

    struct ObjectsGivenEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        index: u64,
        receiver: address,
        received_count: u64,
        remaining_count: u64,
        amount: u64,
    }

    struct NumberOfReceiversUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_number_of_receivers: u64,
        new_number_of_receivers: u64,
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
        manager_public_key: vector<u8>,
    }

    struct ClaimPass {
        vault_id: 0x2::object::ID,
        index: u64,
        receiver: address,
    }

    struct ClaimPassVerifyMessage has drop {
        vault_id: 0x2::object::ID,
        receiver: address,
    }

    public fun add_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg0, arg2);
        let v0 = 0x2::object_bag::length(&arg0.contents);
        let v1 = CoinAddedEvent<T0>{
            vault_id   : 0x2::object::id<Vault>(arg0),
            index      : v0,
            coin_value : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CoinAddedEvent<T0>>(v1);
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, v0, arg1);
    }

    public fun add_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg0, arg3);
        let v0 = 0x1::vector::length<T0>(&arg2);
        assert!(v0 < arg1 * arg0.max_receivers, 13906834938847821829);
        let v1 = 0x2::object_bag::length(&arg0.contents);
        let v2 = ObjectsWrapper<T0>{
            id                 : 0x2::object::new(arg3),
            items_per_receiver : arg1,
            objects            : arg2,
        };
        0x2::object_bag::add<u64, ObjectsWrapper<T0>>(&mut arg0.contents, v1, v2);
        let v3 = ObjectsAddedEvent<T0>{
            vault_id           : 0x2::object::id<Vault>(arg0),
            index              : v1,
            total_items        : v0,
            items_per_receiver : arg1,
        };
        0x2::event::emit<ObjectsAddedEvent<T0>>(v3);
    }

    fun assert_sender_is_vault_creator(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(sender_is_vault_creator(arg0, arg1), 13906834633905012739);
    }

    public fun claim_coins_with_pass<T0>(arg0: &mut Vault, arg1: &mut ClaimPass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13906835325395140617);
        internal_give_coin_to_receiver<T0>(arg0, arg1.index, arg1.receiver, arg2);
        arg1.index = arg1.index + 1;
    }

    public fun claim_objects_with_pass<T0: store + key>(arg0: &mut Vault, arg1: &mut ClaimPass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13906835368344813577);
        internal_give_object_to_receiver<T0>(arg0, arg1.index, arg1.receiver, arg2);
        arg1.index = arg1.index + 1;
    }

    public fun create_vault(arg0: u64, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Vault {
        let v0 = Vault{
            id                 : 0x2::object::new(arg3),
            max_receivers      : arg0,
            received_count     : 0,
            contents           : 0x2::object_bag::new(arg3),
            creator            : 0x2::tx_context::sender(arg3),
            manager            : arg2,
            manager_public_key : arg1,
        };
        let v1 = VaultCreatedEvent{
            vault_id      : 0x2::object::id<Vault>(&v0),
            creator       : 0x2::tx_context::sender(arg3),
            max_receivers : arg0,
        };
        0x2::event::emit<VaultCreatedEvent>(v1);
        v0
    }

    public fun destroy_empty_vault(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id                 : v0,
            max_receivers      : _,
            received_count     : _,
            contents           : v3,
            creator            : _,
            manager            : _,
            manager_public_key : _,
        } = arg0;
        let v7 = v3;
        let v8 = v0;
        assert!(0x2::object_bag::length(&v7) == 0, 13906835845085659137);
        let v9 = VaultDestroyedEvent{vault_id: 0x2::object::uid_to_inner(&v8)};
        0x2::event::emit<VaultDestroyedEvent>(v9);
        0x2::object::delete(v8);
        0x2::object_bag::destroy_empty(v7);
    }

    public fun get_claim_pass_verify_message(arg0: &Vault, arg1: address) : ClaimPassVerifyMessage {
        ClaimPassVerifyMessage{
            vault_id : 0x2::object::id<Vault>(arg0),
            receiver : arg1,
        }
    }

    public fun get_claim_pass_with_signature(arg0: &Vault, arg1: address, arg2: vector<u8>) : ClaimPass {
        let v0 = get_claim_pass_verify_message(arg0, arg1);
        let v1 = 0x2::bcs::to_bytes<ClaimPassVerifyMessage>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.manager_public_key, &v1), 13906835265265467399);
        ClaimPass{
            vault_id : 0x2::object::id<Vault>(arg0),
            index    : 0,
            receiver : arg1,
        }
    }

    public fun increase_received_count_with_pass(arg0: &mut Vault, arg1: ClaimPass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13906835411294486537);
        internal_increase_received_count(arg0, arg2);
        let ClaimPass {
            vault_id : _,
            index    : _,
            receiver : _,
        } = arg1;
    }

    fun internal_give_coin_to_receiver<T0>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
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
            index           : arg1,
            receiver        : arg2,
            received_count  : arg0.received_count,
            remaining_count : v0,
            coin_value      : v1,
        };
        0x2::event::emit<CoinGivenEvent<T0>>(v5);
    }

    fun internal_give_object_to_receiver<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.max_receivers - arg0.received_count;
        let v1 = 0x2::object_bag::borrow_mut<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
        let v2 = v1.items_per_receiver;
        let v3 = ObjectsGivenEvent<T0>{
            vault_id        : 0x2::object::id<Vault>(arg0),
            index           : arg1,
            receiver        : arg2,
            received_count  : arg0.received_count,
            remaining_count : v0,
            amount          : v2,
        };
        0x2::event::emit<ObjectsGivenEvent<T0>>(v3);
        let v4 = 0;
        while (v4 < v2) {
            if (0x1::vector::length<T0>(&v1.objects) > 0) {
                0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v1.objects), arg2);
            };
            v4 = v4 + 1;
        };
        if (v0 == 1 && 0x1::vector::length<T0>(&v1.objects) == 0) {
            let ObjectsWrapper {
                id                 : v5,
                items_per_receiver : _,
                objects            : v7,
            } = 0x2::object_bag::remove<u64, ObjectsWrapper<T0>>(&mut arg0.contents, arg1);
            0x2::object::delete(v5);
            0x1::vector::destroy_empty<T0>(v7);
        };
    }

    fun internal_increase_received_count(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.received_count = arg0.received_count + 1;
        let v0 = NumberOfReceiversUpdatedEvent{
            vault_id                : 0x2::object::id<Vault>(arg0),
            old_number_of_receivers : arg0.received_count - 1,
            new_number_of_receivers : arg0.received_count,
        };
        0x2::event::emit<NumberOfReceiversUpdatedEvent>(v0);
    }

    public fun put_vault_as_shared_object(arg0: Vault, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Vault>(arg0);
    }

    fun sender_is_vault_creator(arg0: &Vault, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == arg0.creator
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg0, arg2);
        let v0 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(&mut arg0.contents, arg1);
        let v1 = CoinWithdrawnEvent<T0>{
            vault_id   : 0x2::object::id<Vault>(arg0),
            index      : arg1,
            coin_value : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<CoinWithdrawnEvent<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.creator);
    }

    public fun withdraw_objects<T0: store + key>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_vault_creator(arg0, arg2);
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
            index       : arg1,
            total_items : v2,
        };
        0x2::event::emit<ObjectsWithdrawnEvent<T0>>(v7);
    }

    // decompiled from Move bytecode v6
}

