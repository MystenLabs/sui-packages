module 0xee4a5a00dec8ddd944676bf72f57bdad418bddd0dada93c14fd0092d4881e76b::safe_transfer {
    struct SAFE_TRANSFER has drop {
        dummy_field: bool,
    }

    struct TransferRequest has drop, store {
        recipient: address,
        recipient_ack: bool,
        object_id: 0x2::object::ID,
    }

    struct SafeTransfer has key {
        id: 0x2::object::UID,
        requests: 0x2::table::Table<address, TransferRequest>,
    }

    struct TransferRequested has copy, drop {
        sender: address,
        recipient: address,
        object_id: 0x2::object::ID,
    }

    struct TransferAcked has copy, drop {
        sender: address,
        recipient: address,
        object_id: 0x2::object::ID,
    }

    struct TransferExecuted has copy, drop {
        sender: address,
        recipient: address,
        object_id: 0x2::object::ID,
    }

    struct TransferCancelled has copy, drop {
        sender: address,
        recipient: address,
        object_id: 0x2::object::ID,
    }

    public fun ack_transfer(arg0: &mut SafeTransfer, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, TransferRequest>(&mut arg0.requests, arg2);
        assert!(v1.recipient == v0, 1);
        assert!(v1.object_id == arg1, 2);
        v1.recipient_ack = true;
        let v2 = TransferAcked{
            sender    : arg2,
            recipient : v0,
            object_id : arg1,
        };
        0x2::event::emit<TransferAcked>(v2);
    }

    public fun cancel_request(arg0: &mut SafeTransfer, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let TransferRequest {
            recipient     : v1,
            recipient_ack : _,
            object_id     : v3,
        } = 0x2::table::remove<address, TransferRequest>(&mut arg0.requests, v0);
        let v4 = TransferCancelled{
            sender    : v0,
            recipient : v1,
            object_id : v3,
        };
        0x2::event::emit<TransferCancelled>(v4);
    }

    public fun exec_transfer<T0: store + key>(arg0: &mut SafeTransfer, arg1: T0, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let TransferRequest {
            recipient     : v1,
            recipient_ack : v2,
            object_id     : v3,
        } = 0x2::table::remove<address, TransferRequest>(&mut arg0.requests, v0);
        assert!(v3 == 0x2::object::id<T0>(&arg1), 2);
        assert!(v2, 3);
        0x2::transfer::public_transfer<T0>(arg1, v1);
        let v4 = TransferExecuted{
            sender    : v0,
            recipient : v1,
            object_id : v3,
        };
        0x2::event::emit<TransferExecuted>(v4);
    }

    fun init(arg0: SAFE_TRANSFER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SAFE_TRANSFER>(arg0, arg1);
        let v0 = SafeTransfer{
            id       : 0x2::object::new(arg1),
            requests : 0x2::table::new<address, TransferRequest>(arg1),
        };
        0x2::transfer::share_object<SafeTransfer>(v0);
    }

    public fun request_transfer<T0: store + key>(arg0: &mut SafeTransfer, arg1: &T0, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(arg1);
        let v2 = TransferRequest{
            recipient     : arg2,
            recipient_ack : false,
            object_id     : v1,
        };
        0x2::table::add<address, TransferRequest>(&mut arg0.requests, v0, v2);
        let v3 = TransferRequested{
            sender    : v0,
            recipient : arg2,
            object_id : v1,
        };
        0x2::event::emit<TransferRequested>(v3);
    }

    // decompiled from Move bytecode v7
}

