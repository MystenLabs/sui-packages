module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events {
    struct InvoiceCreated has copy, drop {
        invoice_id: 0x2::object::ID,
        payee: address,
        payer: 0x1::option::Option<address>,
        amount: u64,
        expires_at: u64,
        created_at: u64,
    }

    struct InvoicePaid has copy, drop {
        invoice_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        paid_at: u64,
    }

    struct InvoiceDisputed has copy, drop {
        invoice_id: 0x2::object::ID,
        disputed_by: address,
        reason: vector<u8>,
        disputed_at: u64,
    }

    struct InvoiceReleased has copy, drop {
        invoice_id: 0x2::object::ID,
        payee: address,
        amount: u64,
        released_at: u64,
    }

    struct InvoiceCancelled has copy, drop {
        invoice_id: 0x2::object::ID,
        cancelled_by: address,
        cancelled_at: u64,
    }

    struct InvoiceRefunded has copy, drop {
        invoice_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        refunded_at: u64,
    }

    struct ReleaseConditionAdded has copy, drop {
        invoice_id: 0x2::object::ID,
        condition_type: u8,
        condition_value: u64,
    }

    struct ReleaseConditionMet has copy, drop {
        invoice_id: 0x2::object::ID,
        condition_index: u64,
        met_at: u64,
    }

    struct ChannelOpened has copy, drop {
        channel_id: 0x2::object::ID,
        party_a: address,
        party_b: address,
        initial_balance_a: u64,
        challenge_period: u64,
        opened_at: u64,
    }

    struct ChannelDeposit has copy, drop {
        channel_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        new_balance: u64,
        deposited_at: u64,
    }

    struct ChannelUpdated has copy, drop {
        channel_id: 0x2::object::ID,
        nonce: u64,
        balance_a: u64,
        balance_b: u64,
        updated_at: u64,
    }

    struct ChannelCloseInitiated has copy, drop {
        channel_id: 0x2::object::ID,
        initiated_by: address,
        proposed_balance_a: u64,
        proposed_balance_b: u64,
        unlock_time: u64,
        initiated_at: u64,
    }

    struct ChannelCloseChallenged has copy, drop {
        channel_id: 0x2::object::ID,
        challenged_by: address,
        new_nonce: u64,
        new_balance_a: u64,
        new_balance_b: u64,
        challenged_at: u64,
    }

    struct ChannelClosed has copy, drop {
        channel_id: 0x2::object::ID,
        final_balance_a: u64,
        final_balance_b: u64,
        closed_at: u64,
    }

    struct ChannelDisputeRaised has copy, drop {
        channel_id: 0x2::object::ID,
        raised_by: address,
        reason: vector<u8>,
        raised_at: u64,
    }

    struct StreamCreated has copy, drop {
        stream_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        total_amount: u64,
        rate_per_second: u64,
        start_time: u64,
        end_time: u64,
        created_at: u64,
    }

    struct StreamWithdrawn has copy, drop {
        stream_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        remaining: u64,
        withdrawn_at: u64,
    }

    struct StreamToppedUp has copy, drop {
        stream_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        new_end_time: u64,
        topped_up_at: u64,
    }

    struct StreamPaused has copy, drop {
        stream_id: 0x2::object::ID,
        paused_by: address,
        paused_at: u64,
    }

    struct StreamResumed has copy, drop {
        stream_id: 0x2::object::ID,
        resumed_by: address,
        resumed_at: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        cancelled_by: address,
        refunded_to_sender: u64,
        paid_to_recipient: u64,
        cancelled_at: u64,
    }

    struct StreamCompleted has copy, drop {
        stream_id: 0x2::object::ID,
        total_streamed: u64,
        completed_at: u64,
    }

    struct ServiceRegistered has copy, drop {
        service_id: 0x2::object::ID,
        owner: address,
        name: vector<u8>,
        endpoint: vector<u8>,
        registered_at: u64,
    }

    struct ServiceEndpointUpdated has copy, drop {
        service_id: 0x2::object::ID,
        old_endpoint: vector<u8>,
        new_endpoint: vector<u8>,
        updated_at: u64,
    }

    struct ServicePricingUpdated has copy, drop {
        service_id: 0x2::object::ID,
        updated_at: u64,
    }

    struct ServiceCalled has copy, drop {
        service_id: 0x2::object::ID,
        caller: address,
        amount_paid: u64,
        tier_index: u64,
        called_at: u64,
    }

    struct ServiceRevenueSplitSet has copy, drop {
        service_id: 0x2::object::ID,
        revenue_split_id: 0x2::object::ID,
        set_at: u64,
    }

    struct RevenueSplitCreated has copy, drop {
        split_id: 0x2::object::ID,
        owner: address,
        num_recipients: u64,
        created_at: u64,
    }

    struct RevenueSplitReceived has copy, drop {
        split_id: 0x2::object::ID,
        amount: u64,
        received_at: u64,
    }

    struct RevenueSplitDistributed has copy, drop {
        split_id: 0x2::object::ID,
        total_distributed: u64,
        distributed_at: u64,
    }

    struct RevenueSplitRecipientsUpdated has copy, drop {
        split_id: 0x2::object::ID,
        num_recipients: u64,
        updated_at: u64,
    }

    public fun emit_channel_close_challenged(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ChannelCloseChallenged{
            channel_id    : arg0,
            challenged_by : arg1,
            new_nonce     : arg2,
            new_balance_a : arg3,
            new_balance_b : arg4,
            challenged_at : arg5,
        };
        0x2::event::emit<ChannelCloseChallenged>(v0);
    }

    public fun emit_channel_close_initiated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ChannelCloseInitiated{
            channel_id         : arg0,
            initiated_by       : arg1,
            proposed_balance_a : arg2,
            proposed_balance_b : arg3,
            unlock_time        : arg4,
            initiated_at       : arg5,
        };
        0x2::event::emit<ChannelCloseInitiated>(v0);
    }

    public fun emit_channel_closed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ChannelClosed{
            channel_id      : arg0,
            final_balance_a : arg1,
            final_balance_b : arg2,
            closed_at       : arg3,
        };
        0x2::event::emit<ChannelClosed>(v0);
    }

    public fun emit_channel_deposit(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ChannelDeposit{
            channel_id   : arg0,
            depositor    : arg1,
            amount       : arg2,
            new_balance  : arg3,
            deposited_at : arg4,
        };
        0x2::event::emit<ChannelDeposit>(v0);
    }

    public fun emit_channel_dispute_raised(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = ChannelDisputeRaised{
            channel_id : arg0,
            raised_by  : arg1,
            reason     : arg2,
            raised_at  : arg3,
        };
        0x2::event::emit<ChannelDisputeRaised>(v0);
    }

    public fun emit_channel_opened(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ChannelOpened{
            channel_id        : arg0,
            party_a           : arg1,
            party_b           : arg2,
            initial_balance_a : arg3,
            challenge_period  : arg4,
            opened_at         : arg5,
        };
        0x2::event::emit<ChannelOpened>(v0);
    }

    public fun emit_channel_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ChannelUpdated{
            channel_id : arg0,
            nonce      : arg1,
            balance_a  : arg2,
            balance_b  : arg3,
            updated_at : arg4,
        };
        0x2::event::emit<ChannelUpdated>(v0);
    }

    public fun emit_invoice_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = InvoiceCancelled{
            invoice_id   : arg0,
            cancelled_by : arg1,
            cancelled_at : arg2,
        };
        0x2::event::emit<InvoiceCancelled>(v0);
    }

    public fun emit_invoice_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = InvoiceCreated{
            invoice_id : arg0,
            payee      : arg1,
            payer      : arg2,
            amount     : arg3,
            expires_at : arg4,
            created_at : arg5,
        };
        0x2::event::emit<InvoiceCreated>(v0);
    }

    public fun emit_invoice_disputed(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = InvoiceDisputed{
            invoice_id  : arg0,
            disputed_by : arg1,
            reason      : arg2,
            disputed_at : arg3,
        };
        0x2::event::emit<InvoiceDisputed>(v0);
    }

    public fun emit_invoice_paid(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = InvoicePaid{
            invoice_id : arg0,
            payer      : arg1,
            amount     : arg2,
            paid_at    : arg3,
        };
        0x2::event::emit<InvoicePaid>(v0);
    }

    public fun emit_invoice_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = InvoiceRefunded{
            invoice_id  : arg0,
            payer       : arg1,
            amount      : arg2,
            refunded_at : arg3,
        };
        0x2::event::emit<InvoiceRefunded>(v0);
    }

    public fun emit_invoice_released(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = InvoiceReleased{
            invoice_id  : arg0,
            payee       : arg1,
            amount      : arg2,
            released_at : arg3,
        };
        0x2::event::emit<InvoiceReleased>(v0);
    }

    public fun emit_release_condition_added(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = ReleaseConditionAdded{
            invoice_id      : arg0,
            condition_type  : arg1,
            condition_value : arg2,
        };
        0x2::event::emit<ReleaseConditionAdded>(v0);
    }

    public fun emit_release_condition_met(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ReleaseConditionMet{
            invoice_id      : arg0,
            condition_index : arg1,
            met_at          : arg2,
        };
        0x2::event::emit<ReleaseConditionMet>(v0);
    }

    public fun emit_revenue_split_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RevenueSplitCreated{
            split_id       : arg0,
            owner          : arg1,
            num_recipients : arg2,
            created_at     : arg3,
        };
        0x2::event::emit<RevenueSplitCreated>(v0);
    }

    public fun emit_revenue_split_distributed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RevenueSplitDistributed{
            split_id          : arg0,
            total_distributed : arg1,
            distributed_at    : arg2,
        };
        0x2::event::emit<RevenueSplitDistributed>(v0);
    }

    public fun emit_revenue_split_received(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RevenueSplitReceived{
            split_id    : arg0,
            amount      : arg1,
            received_at : arg2,
        };
        0x2::event::emit<RevenueSplitReceived>(v0);
    }

    public fun emit_revenue_split_recipients_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RevenueSplitRecipientsUpdated{
            split_id       : arg0,
            num_recipients : arg1,
            updated_at     : arg2,
        };
        0x2::event::emit<RevenueSplitRecipientsUpdated>(v0);
    }

    public fun emit_service_called(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ServiceCalled{
            service_id  : arg0,
            caller      : arg1,
            amount_paid : arg2,
            tier_index  : arg3,
            called_at   : arg4,
        };
        0x2::event::emit<ServiceCalled>(v0);
    }

    public fun emit_service_endpoint_updated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = ServiceEndpointUpdated{
            service_id   : arg0,
            old_endpoint : arg1,
            new_endpoint : arg2,
            updated_at   : arg3,
        };
        0x2::event::emit<ServiceEndpointUpdated>(v0);
    }

    public fun emit_service_pricing_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ServicePricingUpdated{
            service_id : arg0,
            updated_at : arg1,
        };
        0x2::event::emit<ServicePricingUpdated>(v0);
    }

    public fun emit_service_registered(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        let v0 = ServiceRegistered{
            service_id    : arg0,
            owner         : arg1,
            name          : arg2,
            endpoint      : arg3,
            registered_at : arg4,
        };
        0x2::event::emit<ServiceRegistered>(v0);
    }

    public fun emit_service_revenue_split_set(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = ServiceRevenueSplitSet{
            service_id       : arg0,
            revenue_split_id : arg1,
            set_at           : arg2,
        };
        0x2::event::emit<ServiceRevenueSplitSet>(v0);
    }

    public fun emit_stream_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = StreamCancelled{
            stream_id          : arg0,
            cancelled_by       : arg1,
            refunded_to_sender : arg2,
            paid_to_recipient  : arg3,
            cancelled_at       : arg4,
        };
        0x2::event::emit<StreamCancelled>(v0);
    }

    public fun emit_stream_completed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StreamCompleted{
            stream_id      : arg0,
            total_streamed : arg1,
            completed_at   : arg2,
        };
        0x2::event::emit<StreamCompleted>(v0);
    }

    public fun emit_stream_created(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = StreamCreated{
            stream_id       : arg0,
            sender          : arg1,
            recipient       : arg2,
            total_amount    : arg3,
            rate_per_second : arg4,
            start_time      : arg5,
            end_time        : arg6,
            created_at      : arg7,
        };
        0x2::event::emit<StreamCreated>(v0);
    }

    public fun emit_stream_paused(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = StreamPaused{
            stream_id : arg0,
            paused_by : arg1,
            paused_at : arg2,
        };
        0x2::event::emit<StreamPaused>(v0);
    }

    public fun emit_stream_resumed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = StreamResumed{
            stream_id  : arg0,
            resumed_by : arg1,
            resumed_at : arg2,
        };
        0x2::event::emit<StreamResumed>(v0);
    }

    public fun emit_stream_topped_up(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = StreamToppedUp{
            stream_id    : arg0,
            sender       : arg1,
            amount       : arg2,
            new_end_time : arg3,
            topped_up_at : arg4,
        };
        0x2::event::emit<StreamToppedUp>(v0);
    }

    public fun emit_stream_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = StreamWithdrawn{
            stream_id    : arg0,
            recipient    : arg1,
            amount       : arg2,
            remaining    : arg3,
            withdrawn_at : arg4,
        };
        0x2::event::emit<StreamWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

