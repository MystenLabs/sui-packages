module 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer {
    struct WrappedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TwoStepTransferWrapper<phantom T0: store + key> has key {
        id: 0x2::object::UID,
    }

    struct PendingOwnershipTransfer<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        wrapper_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct Borrow {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
    }

    struct RequestBorrow {
        wrapper_id: 0x2::object::ID,
    }

    struct WrapExecuted<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct UnwrapExecuted<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct TransferInitiated<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        current_owner: address,
        new_owner: address,
    }

    struct TransferAccepted<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    struct TransferCancelled<phantom T0> has copy, drop {
        wrapper_id: 0x2::object::ID,
        current_owner: address,
        new_owner: address,
    }

    public fun borrow<T0: store + key>(arg0: &TwoStepTransferWrapper<T0>) : &T0 {
        let v0 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<WrappedKey, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut TwoStepTransferWrapper<T0>) : &mut T0 {
        let v0 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<WrappedKey, T0>(&mut arg0.id, v0)
    }

    public fun accept_transfer<T0: store + key>(arg0: PendingOwnershipTransfer<T0>, arg1: 0x2::transfer::Receiving<TwoStepTransferWrapper<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.to, 13836185187845144585);
        let PendingOwnershipTransfer {
            id         : v0,
            wrapper_id : v1,
            from       : v2,
            to         : v3,
        } = arg0;
        let v4 = v0;
        let v5 = 0x2::transfer::receive<TwoStepTransferWrapper<T0>>(&mut v4, arg1);
        assert!(0x2::object::id<TwoStepTransferWrapper<T0>>(&v5) == v1, 13835059300822679553);
        0x2::object::delete(v4);
        let v6 = TransferAccepted<T0>{
            wrapper_id     : v1,
            previous_owner : v2,
            new_owner      : v3,
        };
        0x2::event::emit<TransferAccepted<T0>>(v6);
        0x2::transfer::transfer<TwoStepTransferWrapper<T0>>(v5, v3);
    }

    public fun borrow_val<T0: store + key>(arg0: &mut TwoStepTransferWrapper<T0>) : (T0, Borrow) {
        let v0 = WrappedKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<WrappedKey, T0>(&mut arg0.id, v0);
        let v2 = Borrow{
            wrapper_id : 0x2::object::id<TwoStepTransferWrapper<T0>>(arg0),
            object_id  : 0x2::object::id<T0>(&v1),
        };
        (v1, v2)
    }

    public fun cancel_transfer<T0: store + key>(arg0: PendingOwnershipTransfer<T0>, arg1: 0x2::transfer::Receiving<TwoStepTransferWrapper<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.from, 13835903867487125511);
        let PendingOwnershipTransfer {
            id         : v0,
            wrapper_id : v1,
            from       : v2,
            to         : v3,
        } = arg0;
        let v4 = v0;
        let v5 = 0x2::transfer::receive<TwoStepTransferWrapper<T0>>(&mut v4, arg1);
        assert!(0x2::object::id<TwoStepTransferWrapper<T0>>(&v5) == v1, 13835059455441502209);
        let v6 = TransferCancelled<T0>{
            wrapper_id    : v1,
            current_owner : v2,
            new_owner     : v3,
        };
        0x2::event::emit<TransferCancelled<T0>>(v6);
        0x2::object::delete(v4);
        0x2::transfer::transfer<TwoStepTransferWrapper<T0>>(v5, v2);
    }

    public fun initiate_transfer<T0: store + key>(arg0: TwoStepTransferWrapper<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<TwoStepTransferWrapper<T0>>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = PendingOwnershipTransfer<T0>{
            id         : 0x2::object::new(arg2),
            wrapper_id : v0,
            from       : v1,
            to         : arg1,
        };
        let v3 = TransferInitiated<T0>{
            wrapper_id    : v0,
            current_owner : v1,
            new_owner     : arg1,
        };
        0x2::event::emit<TransferInitiated<T0>>(v3);
        0x2::transfer::share_object<PendingOwnershipTransfer<T0>>(v2);
        0x2::transfer::transfer<TwoStepTransferWrapper<T0>>(arg0, 0x2::object::id_address<PendingOwnershipTransfer<T0>>(&v2));
    }

    public fun request_borrow_val<T0: store + key>(arg0: &mut PendingOwnershipTransfer<T0>, arg1: 0x2::transfer::Receiving<TwoStepTransferWrapper<T0>>, arg2: &mut 0x2::tx_context::TxContext) : (TwoStepTransferWrapper<T0>, RequestBorrow) {
        assert!(0x2::tx_context::sender(arg2) == arg0.from, 13835904017810980871);
        let v0 = 0x2::transfer::receive<TwoStepTransferWrapper<T0>>(&mut arg0.id, arg1);
        assert!(0x2::object::id<TwoStepTransferWrapper<T0>>(&v0) == arg0.wrapper_id, 13835059601470390273);
        let v1 = RequestBorrow{wrapper_id: 0x2::object::id<TwoStepTransferWrapper<T0>>(&v0)};
        (v0, v1)
    }

    public fun request_return_val<T0: store + key>(arg0: &PendingOwnershipTransfer<T0>, arg1: TwoStepTransferWrapper<T0>, arg2: RequestBorrow) {
        let RequestBorrow { wrapper_id: v0 } = arg2;
        assert!(0x2::object::id<TwoStepTransferWrapper<T0>>(&arg1) == v0, 13835059691664703489);
        assert!(v0 == arg0.wrapper_id, 13835059695959670785);
        0x2::transfer::transfer<TwoStepTransferWrapper<T0>>(arg1, 0x2::object::id_address<PendingOwnershipTransfer<T0>>(arg0));
    }

    public fun return_val<T0: store + key>(arg0: &mut TwoStepTransferWrapper<T0>, arg1: T0, arg2: Borrow) {
        let Borrow {
            wrapper_id : v0,
            object_id  : v1,
        } = arg2;
        assert!(0x2::object::id<TwoStepTransferWrapper<T0>>(arg0) == v0, 13835340406432333827);
        assert!(0x2::object::id<T0>(&arg1) == v1, 13835621885704142853);
        let v2 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::add<WrappedKey, T0>(&mut arg0.id, v2, arg1);
    }

    public fun unwrap<T0: store + key>(arg0: TwoStepTransferWrapper<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        let TwoStepTransferWrapper { id: v0 } = arg0;
        let v1 = WrappedKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<WrappedKey, T0>(&mut v0, v1);
        let v3 = UnwrapExecuted<T0>{
            wrapper_id : 0x2::object::uid_to_inner(&v0),
            object_id  : 0x2::object::id<T0>(&v2),
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<UnwrapExecuted<T0>>(v3);
        0x2::object::delete(v0);
        v2
    }

    public fun wrap<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : TwoStepTransferWrapper<T0> {
        let v0 = TwoStepTransferWrapper<T0>{id: 0x2::object::new(arg1)};
        let v1 = WrapExecuted<T0>{
            wrapper_id : 0x2::object::id<TwoStepTransferWrapper<T0>>(&v0),
            object_id  : 0x2::object::id<T0>(&arg0),
            owner      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<WrapExecuted<T0>>(v1);
        let v2 = WrappedKey{dummy_field: false};
        0x2::dynamic_object_field::add<WrappedKey, T0>(&mut v0.id, v2, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

