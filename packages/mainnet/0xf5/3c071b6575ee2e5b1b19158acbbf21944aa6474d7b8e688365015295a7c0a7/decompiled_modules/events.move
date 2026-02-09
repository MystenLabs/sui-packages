module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events {
    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        initial_offer_amount: u64,
        min_price: u64,
        max_price: u64,
        expiry_timestamp_ms: u64,
        fill_policy: u8,
        min_fill_amount: u64,
    }

    struct OfferFilled has copy, drop {
        offer_id: 0x2::object::ID,
        taker: address,
        fill_amount: u64,
        payment_amount: u64,
        price: u64,
        is_full: bool,
        remaining: u64,
    }

    struct OfferWithdrawn has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        withdrawn_amount: u64,
        total_filled: u64,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        remaining: u64,
        total_filled: u64,
    }

    struct IntentSubmitted has copy, drop {
        intent_id: 0x2::object::ID,
        creator: address,
        receive_amount: u64,
        max_pay_amount: u64,
        escrowed_amount: u64,
        min_price: u64,
        max_price: u64,
        expiry_timestamp_ms: u64,
    }

    struct IntentExecuted has copy, drop {
        intent_id: 0x2::object::ID,
        executor: address,
        offer_used: 0x2::object::ID,
        amount_received: u64,
        amount_paid: u64,
        price: u64,
        refund_amount: u64,
    }

    struct IntentCancelled has copy, drop {
        intent_id: 0x2::object::ID,
        creator: address,
        refund_amount: u64,
    }

    struct IntentExpired has copy, drop {
        intent_id: 0x2::object::ID,
        creator: address,
        refund_amount: u64,
    }

    struct AdminCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        owner: address,
    }

    struct ExecutorCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        label: vector<u8>,
        minted_by: address,
    }

    struct ExecutorCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct PartialFillCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        label: vector<u8>,
        minted_by: address,
    }

    struct PartialFillCapDestroyed has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        name: vector<u8>,
    }

    struct OfferAddedToPool has copy, drop {
        pool_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        added_by: address,
    }

    struct OfferRemovedFromPool has copy, drop {
        pool_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        removed_by: address,
    }

    public fun emit_admin_cap_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminCapCreated{
            cap_id : arg0,
            owner  : arg1,
        };
        0x2::event::emit<AdminCapCreated>(v0);
    }

    public fun emit_executor_cap_destroyed(arg0: 0x2::object::ID) {
        let v0 = ExecutorCapDestroyed{cap_id: arg0};
        0x2::event::emit<ExecutorCapDestroyed>(v0);
    }

    public fun emit_executor_cap_minted(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: address) {
        let v0 = ExecutorCapMinted{
            cap_id    : arg0,
            recipient : arg1,
            label     : arg2,
            minted_by : arg3,
        };
        0x2::event::emit<ExecutorCapMinted>(v0);
    }

    public fun emit_intent_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = IntentCancelled{
            intent_id     : arg0,
            creator       : arg1,
            refund_amount : arg2,
        };
        0x2::event::emit<IntentCancelled>(v0);
    }

    public fun emit_intent_executed(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = IntentExecuted{
            intent_id       : arg0,
            executor        : arg1,
            offer_used      : arg2,
            amount_received : arg3,
            amount_paid     : arg4,
            price           : arg5,
            refund_amount   : arg6,
        };
        0x2::event::emit<IntentExecuted>(v0);
    }

    public fun emit_intent_expired(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = IntentExpired{
            intent_id     : arg0,
            creator       : arg1,
            refund_amount : arg2,
        };
        0x2::event::emit<IntentExpired>(v0);
    }

    public fun emit_intent_submitted(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = IntentSubmitted{
            intent_id           : arg0,
            creator             : arg1,
            receive_amount      : arg2,
            max_pay_amount      : arg3,
            escrowed_amount     : arg4,
            min_price           : arg5,
            max_price           : arg6,
            expiry_timestamp_ms : arg7,
        };
        0x2::event::emit<IntentSubmitted>(v0);
    }

    public fun emit_offer_added_to_pool(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = OfferAddedToPool{
            pool_id  : arg0,
            offer_id : arg1,
            added_by : arg2,
        };
        0x2::event::emit<OfferAddedToPool>(v0);
    }

    public fun emit_offer_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64) {
        let v0 = OfferCreated{
            offer_id             : arg0,
            maker                : arg1,
            initial_offer_amount : arg2,
            min_price            : arg3,
            max_price            : arg4,
            expiry_timestamp_ms  : arg5,
            fill_policy          : arg6,
            min_fill_amount      : arg7,
        };
        0x2::event::emit<OfferCreated>(v0);
    }

    public fun emit_offer_expired(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OfferExpired{
            offer_id     : arg0,
            remaining    : arg1,
            total_filled : arg2,
        };
        0x2::event::emit<OfferExpired>(v0);
    }

    public fun emit_offer_filled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64) {
        let v0 = OfferFilled{
            offer_id       : arg0,
            taker          : arg1,
            fill_amount    : arg2,
            payment_amount : arg3,
            price          : arg4,
            is_full        : arg5,
            remaining      : arg6,
        };
        0x2::event::emit<OfferFilled>(v0);
    }

    public fun emit_offer_removed_from_pool(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = OfferRemovedFromPool{
            pool_id    : arg0,
            offer_id   : arg1,
            removed_by : arg2,
        };
        0x2::event::emit<OfferRemovedFromPool>(v0);
    }

    public fun emit_offer_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = OfferWithdrawn{
            offer_id         : arg0,
            maker            : arg1,
            withdrawn_amount : arg2,
            total_filled     : arg3,
        };
        0x2::event::emit<OfferWithdrawn>(v0);
    }

    public fun emit_partial_fill_cap_destroyed(arg0: 0x2::object::ID) {
        let v0 = PartialFillCapDestroyed{cap_id: arg0};
        0x2::event::emit<PartialFillCapDestroyed>(v0);
    }

    public fun emit_partial_fill_cap_minted(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: address) {
        let v0 = PartialFillCapMinted{
            cap_id    : arg0,
            recipient : arg1,
            label     : arg2,
            minted_by : arg3,
        };
        0x2::event::emit<PartialFillCapMinted>(v0);
    }

    public fun emit_pool_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>) {
        let v0 = PoolCreated{
            pool_id : arg0,
            creator : arg1,
            name    : arg2,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

