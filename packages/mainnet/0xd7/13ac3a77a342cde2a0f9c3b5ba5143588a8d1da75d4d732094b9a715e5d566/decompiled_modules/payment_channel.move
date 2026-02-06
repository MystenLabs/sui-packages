module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::payment_channel {
    struct PendingClose has copy, drop, store {
        proposed_by: address,
        balance_a: u64,
        balance_b: u64,
        unlock_time: u64,
        nonce: u64,
    }

    struct PaymentChannel<phantom T0> has store, key {
        id: 0x2::object::UID,
        party_a: address,
        party_b: address,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T0>,
        nonce: u64,
        challenge_period: u64,
        status: u8,
        last_update: u64,
        pending_close: 0x1::option::Option<PendingClose>,
    }

    struct ChannelCap has store, key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
        party: address,
    }

    public fun balance_a<T0>(arg0: &PaymentChannel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a)
    }

    public fun balance_b<T0>(arg0: &PaymentChannel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_b)
    }

    public fun cap_channel_id(arg0: &ChannelCap) : 0x2::object::ID {
        arg0.channel_id
    }

    public fun cap_party(arg0: &ChannelCap) : address {
        arg0.party
    }

    public fun challenge_close<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closing(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_not_closing());
        let v0 = arg1.party;
        assert!(v0 == arg0.party_a || v0 == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_channel_party());
        let v1 = 0x1::option::borrow<PendingClose>(&arg0.pending_close);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        assert!(v2 < v1.unlock_time, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::challenge_period_over());
        assert!(arg4 > v1.nonce, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_nonce());
        assert!(arg2 + arg3 == 0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        let v3 = PendingClose{
            proposed_by : v0,
            balance_a   : arg2,
            balance_b   : arg3,
            unlock_time : v2 + arg0.challenge_period,
            nonce       : arg4,
        };
        arg0.pending_close = 0x1::option::some<PendingClose>(v3);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_close_challenged(0x2::object::id<PaymentChannel<T0>>(arg0), v0, arg4, arg2, arg3, v2);
    }

    public fun challenge_period<T0>(arg0: &PaymentChannel<T0>) : u64 {
        arg0.challenge_period
    }

    public fun cooperative_close<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: &ChannelCap, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg2.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg1.party == arg0.party_a, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg2.party == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closing(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        assert!(arg3 + arg4 == 0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        if (arg3 > v0) {
            0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg0.balance_b, arg3 - v0));
        } else if (arg3 < v0) {
            0x2::balance::join<T0>(&mut arg0.balance_b, 0x2::balance::split<T0>(&mut arg0.balance_a, v0 - arg3));
        };
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::channel_status_closed();
        arg0.pending_close = 0x1::option::none<PendingClose>();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_closed(0x2::object::id<PaymentChannel<T0>>(arg0), arg3, arg4, 0x2::tx_context::epoch_timestamp_ms(arg5));
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a), arg5), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_b), arg5))
    }

    entry fun cooperative_close_and_distribute<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: &ChannelCap, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.party_a;
        let v1 = arg0.party_b;
        let (v2, v3) = cooperative_close<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
    }

    public fun deposit<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        let v0 = arg1.party;
        if (v0 == arg0.party_a) {
            0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg2));
            0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_deposit(0x2::object::id<PaymentChannel<T0>>(arg0), v0, 0x2::coin::value<T0>(&arg2), 0x2::balance::value<T0>(&arg0.balance_a), 0x2::tx_context::epoch_timestamp_ms(arg3));
        } else {
            assert!(v0 == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_channel_party());
            0x2::balance::join<T0>(&mut arg0.balance_b, 0x2::coin::into_balance<T0>(arg2));
            0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_deposit(0x2::object::id<PaymentChannel<T0>>(arg0), v0, 0x2::coin::value<T0>(&arg2), 0x2::balance::value<T0>(&arg0.balance_b), 0x2::tx_context::epoch_timestamp_ms(arg3));
        };
    }

    public fun destroy<T0>(arg0: PaymentChannel<T0>, arg1: ChannelCap, arg2: ChannelCap) {
        let PaymentChannel {
            id               : v0,
            party_a          : _,
            party_b          : _,
            balance_a        : v3,
            balance_b        : v4,
            nonce            : _,
            challenge_period : _,
            status           : v7,
            last_update      : _,
            pending_close    : _,
        } = arg0;
        let v10 = v4;
        let v11 = v3;
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closed(v7), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        assert!(0x2::balance::value<T0>(&v11) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        assert!(0x2::balance::value<T0>(&v10) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        0x2::balance::destroy_zero<T0>(v11);
        0x2::balance::destroy_zero<T0>(v10);
        0x2::object::delete(v0);
        let ChannelCap {
            id         : v12,
            channel_id : _,
            party      : _,
        } = arg1;
        let ChannelCap {
            id         : v15,
            channel_id : _,
            party      : _,
        } = arg2;
        0x2::object::delete(v12);
        0x2::object::delete(v15);
    }

    entry fun finalize_and_distribute<T0>(arg0: &mut PaymentChannel<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.party_a;
        let v1 = arg0.party_b;
        let (v2, v3) = finalize_close<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
    }

    public fun finalize_close<T0>(arg0: &mut PaymentChannel<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closing(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_not_closing());
        let v0 = 0x1::option::borrow<PendingClose>(&arg0.pending_close);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(v1 >= v0.unlock_time, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::challenge_period_not_over());
        let v2 = v0.balance_a;
        let v3 = v0.balance_b;
        let v4 = 0x2::balance::value<T0>(&arg0.balance_a);
        if (v2 > v4) {
            0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg0.balance_b, v2 - v4));
        } else if (v2 < v4) {
            0x2::balance::join<T0>(&mut arg0.balance_b, 0x2::balance::split<T0>(&mut arg0.balance_a, v4 - v2));
        };
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::channel_status_closed();
        arg0.pending_close = 0x1::option::none<PendingClose>();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_closed(0x2::object::id<PaymentChannel<T0>>(arg0), v2, v3, v1);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a), arg1), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_b), arg1))
    }

    public fun initiate_close<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        let v0 = arg1.party;
        assert!(v0 == arg0.party_a || v0 == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_channel_party());
        assert!(arg4 >= arg0.nonce, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_nonce());
        assert!(arg2 + arg3 == 0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v2 = v1 + arg0.challenge_period;
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::channel_status_closing();
        let v3 = PendingClose{
            proposed_by : v0,
            balance_a   : arg2,
            balance_b   : arg3,
            unlock_time : v2,
            nonce       : arg4,
        };
        arg0.pending_close = 0x1::option::some<PendingClose>(v3);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_close_initiated(0x2::object::id<PaymentChannel<T0>>(arg0), v0, arg2, arg3, v2, v1);
    }

    public fun is_closed<T0>(arg0: &PaymentChannel<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closed(arg0.status)
    }

    public fun is_closing<T0>(arg0: &PaymentChannel<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closing(arg0.status)
    }

    public fun is_open<T0>(arg0: &PaymentChannel<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status)
    }

    public fun last_update<T0>(arg0: &PaymentChannel<T0>) : u64 {
        arg0.last_update
    }

    public fun nonce<T0>(arg0: &PaymentChannel<T0>) : u64 {
        arg0.nonce
    }

    entry fun open_and_share<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = open_channel<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::share_object<PaymentChannel<T0>>(v0);
        0x2::transfer::transfer<ChannelCap>(v1, arg0);
        0x2::transfer::transfer<ChannelCap>(v2, arg1);
    }

    public fun open_channel<T0>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (PaymentChannel<T0>, ChannelCap, ChannelCap) {
        assert!(arg3 >= 3600000, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_timestamp());
        assert!(arg3 <= 604800000, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_timestamp());
        let v0 = PaymentChannel<T0>{
            id               : 0x2::object::new(arg4),
            party_a          : arg0,
            party_b          : arg1,
            balance_a        : 0x2::coin::into_balance<T0>(arg2),
            balance_b        : 0x2::balance::zero<T0>(),
            nonce            : 0,
            challenge_period : arg3,
            status           : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::channel_status_open(),
            last_update      : 0x2::tx_context::epoch_timestamp_ms(arg4),
            pending_close    : 0x1::option::none<PendingClose>(),
        };
        let v1 = 0x2::object::id<PaymentChannel<T0>>(&v0);
        let v2 = ChannelCap{
            id         : 0x2::object::new(arg4),
            channel_id : v1,
            party      : arg0,
        };
        let v3 = ChannelCap{
            id         : 0x2::object::new(arg4),
            channel_id : v1,
            party      : arg1,
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_opened(v1, arg0, arg1, 0x2::coin::value<T0>(&arg2), arg3, 0x2::tx_context::epoch_timestamp_ms(arg4));
        (v0, v2, v3)
    }

    public fun party_a<T0>(arg0: &PaymentChannel<T0>) : address {
        arg0.party_a
    }

    public fun party_b<T0>(arg0: &PaymentChannel<T0>) : address {
        arg0.party_b
    }

    public fun pending_close<T0>(arg0: &PaymentChannel<T0>) : 0x1::option::Option<PendingClose> {
        arg0.pending_close
    }

    public fun pending_close_balance_a(arg0: &PendingClose) : u64 {
        arg0.balance_a
    }

    public fun pending_close_balance_b(arg0: &PendingClose) : u64 {
        arg0.balance_b
    }

    public fun pending_close_nonce(arg0: &PendingClose) : u64 {
        arg0.nonce
    }

    public fun pending_close_proposed_by(arg0: &PendingClose) : address {
        arg0.proposed_by
    }

    public fun pending_close_unlock_time(arg0: &PendingClose) : u64 {
        arg0.unlock_time
    }

    public fun raise_dispute<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_closing(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        let v0 = arg1.party;
        assert!(v0 == arg0.party_a || v0 == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_channel_party());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::channel_status_disputed();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_dispute_raised(0x2::object::id<PaymentChannel<T0>>(arg0), v0, arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun status<T0>(arg0: &PaymentChannel<T0>) : u8 {
        arg0.status
    }

    public fun total_balance<T0>(arg0: &PaymentChannel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b)
    }

    public fun update_state<T0>(arg0: &mut PaymentChannel<T0>, arg1: &ChannelCap, arg2: &ChannelCap, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg2.channel_id == 0x2::object::id<PaymentChannel<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg1.party == arg0.party_a, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(arg2.party == arg0.party_b, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_channel_cap());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_channel_open(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::channel_closed());
        assert!(arg5 > arg0.nonce, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_nonce());
        assert!(arg3 + arg4 == 0x2::balance::value<T0>(&arg0.balance_a) + 0x2::balance::value<T0>(&arg0.balance_b), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::balance_mismatch());
        let v0 = 0x2::balance::value<T0>(&arg0.balance_a);
        if (arg3 > v0) {
            0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg0.balance_b, arg3 - v0));
        } else if (arg3 < v0) {
            0x2::balance::join<T0>(&mut arg0.balance_b, 0x2::balance::split<T0>(&mut arg0.balance_a, v0 - arg3));
        };
        arg0.nonce = arg5;
        arg0.last_update = 0x2::tx_context::epoch_timestamp_ms(arg6);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_channel_updated(0x2::object::id<PaymentChannel<T0>>(arg0), arg5, arg3, arg4, 0x2::tx_context::epoch_timestamp_ms(arg6));
    }

    // decompiled from Move bytecode v6
}

