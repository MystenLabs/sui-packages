module 0xfa949b4f86a607b98dbd9580e1a798e37cbea5fca96d12e9c932ba7418bda494::escrow {
    struct Locked<T0: store + key> has store, key {
        id: 0x2::object::UID,
        locked_item: T0,
    }

    struct Key<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        locked_id: 0x2::object::ID,
    }

    struct EscrowedObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Escrow<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        key_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        item_id: 0x2::object::ID,
    }

    struct EscrowSwapped has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
    }

    public fun swap<T0: store + key, T1: store + key>(arg0: Escrow<T0>, arg1: Key<T1>, arg2: Locked<T1>, arg3: &0x2::tx_context::TxContext) : T0 {
        let v0 = EscrowedObjectKey{dummy_field: false};
        let Escrow {
            id           : v1,
            sender       : v2,
            recipient    : v3,
            exchange_key : v4,
        } = arg0;
        let v5 = v1;
        assert!(v3 == 0x2::tx_context::sender(arg3), 0);
        assert!(v4 == 0x2::object::id<Key<T1>>(&arg1), 1);
        0x2::transfer::public_transfer<T1>(unlock<T1>(arg2, arg1), v2);
        let v6 = EscrowSwapped{escrow_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<EscrowSwapped>(v6);
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<EscrowedObjectKey, T0>(&mut arg0.id, v0)
    }

    public fun sender<T0: store + key>(arg0: &Escrow<T0>) : address {
        arg0.sender
    }

    public fun create<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg3),
            sender       : 0x2::tx_context::sender(arg3),
            recipient    : arg2,
            exchange_key : arg1,
        };
        let v1 = EscrowCreated{
            escrow_id : 0x2::object::id<Escrow<T0>>(&v0),
            key_id    : arg1,
            sender    : v0.sender,
            recipient : arg2,
            item_id   : 0x2::object::id<T0>(&arg0),
        };
        0x2::event::emit<EscrowCreated>(v1);
        let v2 = EscrowedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<EscrowedObjectKey, T0>(&mut v0.id, v2, arg0);
        0x2::transfer::public_share_object<Escrow<T0>>(v0);
    }

    public fun exchange_key<T0: store + key>(arg0: &Escrow<T0>) : 0x2::object::ID {
        arg0.exchange_key
    }

    public fun has_escrowed_object<T0: store + key>(arg0: &Escrow<T0>) : bool {
        let v0 = EscrowedObjectKey{dummy_field: false};
        0x2::dynamic_object_field::exists_<EscrowedObjectKey>(&arg0.id, v0)
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Locked<T0>, Key<T0>) {
        let v0 = Locked<T0>{
            id          : 0x2::object::new(arg1),
            locked_item : arg0,
        };
        let v1 = Key<T0>{
            id        : 0x2::object::new(arg1),
            locked_id : 0x2::object::id<Locked<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun recipient<T0: store + key>(arg0: &Escrow<T0>) : address {
        arg0.recipient
    }

    public fun return_to_sender<T0: store + key>(arg0: Escrow<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        let v0 = EscrowCancelled{escrow_id: 0x2::object::id<Escrow<T0>>(&arg0)};
        0x2::event::emit<EscrowCancelled>(v0);
        let v1 = EscrowedObjectKey{dummy_field: false};
        let Escrow {
            id           : v2,
            sender       : v3,
            recipient    : _,
            exchange_key : _,
        } = arg0;
        assert!(v3 == 0x2::tx_context::sender(arg1), 0);
        0x2::object::delete(v2);
        0x2::dynamic_object_field::remove<EscrowedObjectKey, T0>(&mut arg0.id, v1)
    }

    public fun transfer_key<T0: store + key>(arg0: Key<T0>, arg1: address) {
        0x2::transfer::public_transfer<Key<T0>>(arg0, arg1);
    }

    public fun transfer_locked<T0: store + key>(arg0: Locked<T0>, arg1: address) {
        0x2::transfer::public_transfer<Locked<T0>>(arg0, arg1);
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key<T0>) : T0 {
        let Key {
            id        : v0,
            locked_id : v1,
        } = arg1;
        assert!(0x2::object::id<Locked<T0>>(&arg0) == v1, 1);
        0x2::object::delete(v0);
        let Locked {
            id          : v2,
            locked_item : v3,
        } = arg0;
        0x2::object::delete(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

