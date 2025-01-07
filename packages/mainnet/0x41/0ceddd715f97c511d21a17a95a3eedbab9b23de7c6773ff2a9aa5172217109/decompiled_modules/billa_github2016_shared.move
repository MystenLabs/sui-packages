module 0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_shared {
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

    public fun swap<T0: store + key, T1: store + key>(arg0: Escrow<T0>, arg1: 0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_lock::Key, arg2: 0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_lock::Locked<T1>, arg3: &0x2::tx_context::TxContext) : T0 {
        let v0 = EscrowedObjectKey{dummy_field: false};
        let Escrow {
            id           : v1,
            sender       : v2,
            recipient    : v3,
            exchange_key : v4,
        } = arg0;
        let v5 = v1;
        assert!(v3 == 0x2::tx_context::sender(arg3), 0);
        assert!(v4 == 0x2::object::id<0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_lock::Key>(&arg1), 1);
        0x2::transfer::public_transfer<T1>(0x410ceddd715f97c511d21a17a95a3eedbab9b23de7c6773ff2a9aa5172217109::billa_github2016_lock::unlock<T1>(arg2, arg1), v2);
        let v6 = EscrowSwapped{escrow_id: 0x2::object::uid_to_inner(&v5)};
        0x2::event::emit<EscrowSwapped>(v6);
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<EscrowedObjectKey, T0>(&mut arg0.id, v0)
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

    // decompiled from Move bytecode v6
}

