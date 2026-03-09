module 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::delayed_transfer {
    struct WrappedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DelayedTransferWrapper<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        min_delay_ms: u64,
        pending: 0x1::option::Option<PendingTransfer>,
    }

    struct PendingTransfer has drop, store {
        recipient: 0x1::option::Option<address>,
        execute_after_ms: u64,
    }

    struct Borrow {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
    }

    struct WrapExecuted<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct TransferScheduled<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        current_owner: address,
        new_owner: address,
        execute_after_ms: u64,
    }

    struct UnwrapScheduled<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        current_owner: address,
        execute_after_ms: u64,
    }

    struct OwnershipTransferred<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    struct PendingTransferCancelled<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
    }

    struct UnwrapExecuted<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        owner: address,
    }

    public fun borrow<T0: store + key>(arg0: &DelayedTransferWrapper<T0>) : &T0 {
        let v0 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<WrappedKey, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>) : &mut T0 {
        let v0 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<WrappedKey, T0>(&mut arg0.id, v0)
    }

    public fun borrow_val<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>) : (T0, Borrow) {
        let v0 = WrappedKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<WrappedKey, T0>(&mut arg0.id, v0);
        let v2 = Borrow{
            wrapper_id : 0x2::object::id<DelayedTransferWrapper<T0>>(arg0),
            object_id  : 0x2::object::id<T0>(&v1),
        };
        (v1, v2)
    }

    public fun cancel_schedule<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>) {
        let v0 = &mut arg0.pending;
        assert!(0x1::option::is_some<PendingTransfer>(v0), 13835341003432787971);
        let PendingTransfer {
            recipient        : _,
            execute_after_ms : _,
        } = 0x1::option::extract<PendingTransfer>(v0);
        let v3 = PendingTransferCancelled<T0>{wrapper_id: 0x2::object::id<DelayedTransferWrapper<T0>>(arg0)};
        0x2::event::emit<PendingTransferCancelled<T0>>(v3);
    }

    public fun execute_transfer<T0: store + key>(arg0: DelayedTransferWrapper<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.pending;
        assert!(0x1::option::is_some<PendingTransfer>(v0), 13835340732849848323);
        let PendingTransfer {
            recipient        : v1,
            execute_after_ms : v2,
        } = 0x1::option::extract<PendingTransfer>(v0);
        let v3 = v1;
        let v4 = &mut v3;
        assert!(0x1::option::is_some<address>(v4), 13835903691393466375);
        let v5 = 0x1::option::extract<address>(v4);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 13835622229301526533);
        let v6 = OwnershipTransferred<T0>{
            wrapper_id     : 0x2::object::id<DelayedTransferWrapper<T0>>(&arg0),
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : v5,
        };
        0x2::event::emit<OwnershipTransferred<T0>>(v6);
        0x2::transfer::transfer<DelayedTransferWrapper<T0>>(arg0, v5);
    }

    public fun return_val<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>, arg1: T0, arg2: Borrow) {
        let Borrow {
            wrapper_id : v0,
            object_id  : v1,
        } = arg2;
        assert!(0x2::object::id<DelayedTransferWrapper<T0>>(arg0) == v0, 13836184762643382281);
        assert!(0x2::object::id<T0>(&arg1) == v1, 13836466241915191307);
        let v2 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::add<WrappedKey, T0>(&mut arg0.id, v2, arg1);
    }

    public fun schedule_transfer<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<PendingTransfer>(&arg0.pending), 13835058970110197761);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.min_delay_ms;
        let v1 = PendingTransfer{
            recipient        : 0x1::option::some<address>(arg1),
            execute_after_ms : v0,
        };
        0x1::option::fill<PendingTransfer>(&mut arg0.pending, v1);
        let v2 = TransferScheduled<T0>{
            wrapper_id       : 0x2::object::id<DelayedTransferWrapper<T0>>(arg0),
            current_owner    : 0x2::tx_context::sender(arg3),
            new_owner        : arg1,
            execute_after_ms : v0,
        };
        0x2::event::emit<TransferScheduled<T0>>(v2);
    }

    public fun schedule_unwrap<T0: store + key>(arg0: &mut DelayedTransferWrapper<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<PendingTransfer>(&arg0.pending), 13835059107549151233);
        let v0 = 0x2::clock::timestamp_ms(arg1) + arg0.min_delay_ms;
        let v1 = PendingTransfer{
            recipient        : 0x1::option::none<address>(),
            execute_after_ms : v0,
        };
        0x1::option::fill<PendingTransfer>(&mut arg0.pending, v1);
        let v2 = UnwrapScheduled<T0>{
            wrapper_id       : 0x2::object::id<DelayedTransferWrapper<T0>>(arg0),
            current_owner    : 0x2::tx_context::sender(arg2),
            execute_after_ms : v0,
        };
        0x2::event::emit<UnwrapScheduled<T0>>(v2);
    }

    public fun unwrap<T0: store + key>(arg0: DelayedTransferWrapper<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = &mut arg0.pending;
        assert!(0x1::option::is_some<PendingTransfer>(v0), 13835340878878736387);
        let PendingTransfer {
            recipient        : v1,
            execute_after_ms : v2,
        } = 0x1::option::extract<PendingTransfer>(v0);
        let v3 = v1;
        assert!(0x1::option::is_none<address>(&v3), 13835903841717321735);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 13835622379625381893);
        let DelayedTransferWrapper {
            id           : v4,
            min_delay_ms : _,
            pending      : _,
        } = arg0;
        let v7 = v4;
        let v8 = WrappedKey{dummy_field: false};
        let v9 = 0x2::dynamic_object_field::remove<WrappedKey, T0>(&mut v7, v8);
        let v10 = UnwrapExecuted<T0>{
            wrapper_id : 0x2::object::uid_to_inner(&v7),
            object_id  : 0x2::object::id<T0>(&v9),
            owner      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UnwrapExecuted<T0>>(v10);
        0x2::object::delete(v7);
        v9
    }

    public fun wrap<T0: store + key>(arg0: T0, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DelayedTransferWrapper<T0>{
            id           : 0x2::object::new(arg3),
            min_delay_ms : arg1,
            pending      : 0x1::option::none<PendingTransfer>(),
        };
        let v1 = WrapExecuted<T0>{
            wrapper_id : 0x2::object::id<DelayedTransferWrapper<T0>>(&v0),
            object_id  : 0x2::object::id<T0>(&arg0),
            owner      : arg2,
        };
        0x2::event::emit<WrapExecuted<T0>>(v1);
        let v2 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::add<WrappedKey, T0>(&mut v0.id, v2, arg0);
        0x2::transfer::transfer<DelayedTransferWrapper<T0>>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

