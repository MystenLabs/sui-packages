module 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::core {
    struct PaymentBook has key {
        id: 0x2::object::UID,
        payments: 0x2::table::Table<vector<u8>, PaymentRecord>,
    }

    struct PaymentRecord has drop, store {
        link_hash: vector<u8>,
        sender: address,
        amount: u64,
        position_id: 0x2::object::ID,
        protocol: u8,
        created_at: u64,
        expiry: u64,
        state: u8,
        note_blob_id: 0x1::option::Option<vector<u8>>,
        recipient: 0x1::option::Option<address>,
    }

    struct PaymentVoucher has store, key {
        id: 0x2::object::UID,
        sender: address,
        link_hash: vector<u8>,
    }

    struct ClaimReceipt has store, key {
        id: 0x2::object::UID,
        payment_link_hash: vector<u8>,
        original_amount: u64,
        yield_earned: u64,
        total_claimed: u64,
        claimed_at: u64,
        recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RefundAgentCap has store, key {
        id: 0x2::object::UID,
        agent: address,
    }

    struct YieldRouterCap has store, key {
        id: 0x2::object::UID,
        agent: address,
    }

    struct PaymentCreatedEvent has copy, drop {
        link_hash: vector<u8>,
        sender: address,
        amount: u64,
        protocol: u8,
        created_at: u64,
        expiry: u64,
    }

    struct PaymentClaimedEvent has copy, drop {
        link_hash: vector<u8>,
        recipient: address,
        amount: u64,
        yield_earned: u64,
        claimed_at: u64,
    }

    struct PaymentRefundedEvent has copy, drop {
        link_hash: vector<u8>,
        sender: address,
        amount: u64,
        yield_earned: u64,
        refunded_at: u64,
        initiator: vector<u8>,
    }

    public fun active_payment_count(arg0: &PaymentBook) : u64 {
        0x2::table::length<vector<u8>, PaymentRecord>(&arg0.payments)
    }

    public entry fun claim_payment(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::YieldVault, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, arg2);
        assert!(v0.state == 0, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::withdraw(arg1, v0.position_id, arg3, arg4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 - v0.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v1);
        let v5 = ClaimReceipt{
            id                : 0x2::object::new(arg4),
            payment_link_hash : arg2,
            original_amount   : v0.amount,
            yield_earned      : v4,
            total_claimed     : v3,
            claimed_at        : 0x2::clock::timestamp_ms(arg3),
            recipient         : v1,
        };
        0x2::transfer::public_transfer<ClaimReceipt>(v5, v1);
        let v6 = PaymentClaimedEvent{
            link_hash    : arg2,
            recipient    : v1,
            amount       : v0.amount,
            yield_earned : v4,
            claimed_at   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PaymentClaimedEvent>(v6);
    }

    public entry fun claim_payment_scallop(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::ScallopYieldVault, arg2: vector<u8>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, arg2);
        assert!(v0.state == 0, 2);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::withdraw_scallop(arg1, v0.position_id, arg3, arg4, arg5, arg6);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 - v0.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v1);
        let v5 = ClaimReceipt{
            id                : 0x2::object::new(arg6),
            payment_link_hash : arg2,
            original_amount   : v0.amount,
            yield_earned      : v4,
            total_claimed     : v3,
            claimed_at        : 0x2::clock::timestamp_ms(arg5),
            recipient         : v1,
        };
        0x2::transfer::public_transfer<ClaimReceipt>(v5, v1);
        let v6 = PaymentClaimedEvent{
            link_hash    : arg2,
            recipient    : v1,
            amount       : v0.amount,
            yield_earned : v4,
            claimed_at   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PaymentClaimedEvent>(v6);
    }

    public entry fun create_payment(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::YieldVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg3), 5);
        assert!(arg5 >= 60000, 6);
        let v0 = if (arg5 > 2592000000) {
            2592000000
        } else {
            arg5
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = PaymentRecord{
            link_hash    : arg3,
            sender       : 0x2::tx_context::sender(arg8),
            amount       : v1,
            position_id  : 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::deposit(arg1, arg2, arg6, arg7, arg8),
            protocol     : arg6,
            created_at   : v2,
            expiry       : v2 + v0,
            state        : 0,
            note_blob_id : arg4,
            recipient    : 0x1::option::none<address>(),
        };
        0x2::table::add<vector<u8>, PaymentRecord>(&mut arg0.payments, arg3, v3);
        let v4 = PaymentVoucher{
            id        : 0x2::object::new(arg8),
            sender    : 0x2::tx_context::sender(arg8),
            link_hash : arg3,
        };
        0x2::transfer::public_transfer<PaymentVoucher>(v4, 0x2::tx_context::sender(arg8));
        let v5 = PaymentCreatedEvent{
            link_hash  : arg3,
            sender     : 0x2::tx_context::sender(arg8),
            amount     : v1,
            protocol   : arg6,
            created_at : v2,
            expiry     : v2 + v0,
        };
        0x2::event::emit<PaymentCreatedEvent>(v5);
    }

    public entry fun create_payment_scallop(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::ScallopYieldVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg3), 5);
        assert!(arg5 >= 60000, 6);
        let v0 = if (arg5 > 2592000000) {
            2592000000
        } else {
            arg5
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let v3 = PaymentRecord{
            link_hash    : arg3,
            sender       : 0x2::tx_context::sender(arg9),
            amount       : v1,
            position_id  : 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::deposit_scallop(arg1, arg2, arg6, arg7, arg8, arg9),
            protocol     : 1,
            created_at   : v2,
            expiry       : v2 + v0,
            state        : 0,
            note_blob_id : arg4,
            recipient    : 0x1::option::none<address>(),
        };
        0x2::table::add<vector<u8>, PaymentRecord>(&mut arg0.payments, arg3, v3);
        let v4 = PaymentVoucher{
            id        : 0x2::object::new(arg9),
            sender    : 0x2::tx_context::sender(arg9),
            link_hash : arg3,
        };
        0x2::transfer::public_transfer<PaymentVoucher>(v4, 0x2::tx_context::sender(arg9));
        let v5 = PaymentCreatedEvent{
            link_hash  : arg3,
            sender     : 0x2::tx_context::sender(arg9),
            amount     : v1,
            protocol   : 1,
            created_at : v2,
            expiry     : v2 + v0,
        };
        0x2::event::emit<PaymentCreatedEvent>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentBook{
            id       : 0x2::object::new(arg0),
            payments : 0x2::table::new<vector<u8>, PaymentRecord>(arg0),
        };
        0x2::transfer::share_object<PaymentBook>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = RefundAgentCap{
            id    : 0x2::object::new(arg0),
            agent : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<RefundAgentCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = YieldRouterCap{
            id    : 0x2::object::new(arg0),
            agent : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<YieldRouterCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun payment_amount(arg0: &PaymentBook, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)) {
            0x2::table::borrow<vector<u8>, PaymentRecord>(&arg0.payments, arg1).amount
        } else {
            0
        }
    }

    public fun payment_exists(arg0: &PaymentBook, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)
    }

    public fun payment_expiry(arg0: &PaymentBook, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)) {
            0x2::table::borrow<vector<u8>, PaymentRecord>(&arg0.payments, arg1).expiry
        } else {
            0
        }
    }

    public fun payment_sender(arg0: &PaymentBook, arg1: vector<u8>) : address {
        if (0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)) {
            0x2::table::borrow<vector<u8>, PaymentRecord>(&arg0.payments, arg1).sender
        } else {
            @0x0
        }
    }

    public fun payment_state(arg0: &PaymentBook, arg1: vector<u8>) : u8 {
        if (0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)) {
            0x2::table::borrow<vector<u8>, PaymentRecord>(&arg0.payments, arg1).state
        } else {
            1
        }
    }

    public entry fun refund_expired(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::YieldVault, arg2: vector<u8>, arg3: &RefundAgentCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.agent == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, arg2);
        assert!(v0.state == 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= v0.expiry, 3);
        let v2 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::withdraw(arg1, v0.position_id, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0.sender);
        let v3 = PaymentRefundedEvent{
            link_hash    : arg2,
            sender       : v0.sender,
            amount       : v0.amount,
            yield_earned : 0x2::coin::value<0x2::sui::SUI>(&v2) - v0.amount,
            refunded_at  : v1,
            initiator    : b"agent",
        };
        0x2::event::emit<PaymentRefundedEvent>(v3);
    }

    public entry fun refund_expired_scallop(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::ScallopYieldVault, arg2: vector<u8>, arg3: &RefundAgentCap, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.agent == 0x2::tx_context::sender(arg7), 1);
        let v0 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, arg2);
        assert!(v0.state == 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 >= v0.expiry, 3);
        let v2 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::withdraw_scallop(arg1, v0.position_id, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0.sender);
        let v3 = PaymentRefundedEvent{
            link_hash    : arg2,
            sender       : v0.sender,
            amount       : v0.amount,
            yield_earned : 0x2::coin::value<0x2::sui::SUI>(&v2) - v0.amount,
            refunded_at  : v1,
            initiator    : b"agent",
        };
        0x2::event::emit<PaymentRefundedEvent>(v3);
    }

    public entry fun refund_sender(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::YieldVault, arg2: PaymentVoucher, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.sender == 0x2::tx_context::sender(arg4), 1);
        let v0 = arg2.link_hash;
        let PaymentVoucher {
            id        : v1,
            sender    : _,
            link_hash : _,
        } = arg2;
        0x2::object::delete(v1);
        let v4 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, v0);
        assert!(v4.state == 0, 2);
        let v5 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield::withdraw(arg1, v4.position_id, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v4.sender);
        let v6 = PaymentRefundedEvent{
            link_hash    : v0,
            sender       : v4.sender,
            amount       : v4.amount,
            yield_earned : 0x2::coin::value<0x2::sui::SUI>(&v5) - v4.amount,
            refunded_at  : 0x2::clock::timestamp_ms(arg3),
            initiator    : b"sender",
        };
        0x2::event::emit<PaymentRefundedEvent>(v6);
    }

    public entry fun refund_sender_scallop(arg0: &mut PaymentBook, arg1: &mut 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::ScallopYieldVault, arg2: PaymentVoucher, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.sender == 0x2::tx_context::sender(arg6), 1);
        let v0 = arg2.link_hash;
        let PaymentVoucher {
            id        : v1,
            sender    : _,
            link_hash : _,
        } = arg2;
        0x2::object::delete(v1);
        let v4 = 0x2::table::remove<vector<u8>, PaymentRecord>(&mut arg0.payments, v0);
        assert!(v4.state == 0, 2);
        let v5 = 0x265592b44a27a7a22fdcd83339cfe14a683e7adf960bc7ebe2d294430bc4be61::yield_scallop::withdraw_scallop(arg1, v4.position_id, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, v4.sender);
        let v6 = PaymentRefundedEvent{
            link_hash    : v0,
            sender       : v4.sender,
            amount       : v4.amount,
            yield_earned : 0x2::coin::value<0x2::sui::SUI>(&v5) - v4.amount,
            refunded_at  : 0x2::clock::timestamp_ms(arg5),
            initiator    : b"sender",
        };
        0x2::event::emit<PaymentRefundedEvent>(v6);
    }

    public entry fun rotate_refund_agent(arg0: &AdminCap, arg1: &mut RefundAgentCap, arg2: address) {
        arg1.agent = arg2;
    }

    public entry fun rotate_yield_router(arg0: &AdminCap, arg1: &mut YieldRouterCap, arg2: address) {
        arg1.agent = arg2;
    }

    // decompiled from Move bytecode v7
}

