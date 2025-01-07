module 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::stream {
    struct StreamConfig has copy, drop, store {
        metadata: 0x1::ascii::String,
        creator: address,
        recipient: address,
        time_start: u64,
        cliff: u64,
        epoch_interval: u64,
        total_epoch: u64,
        amount_per_epoch: u64,
        cancelable: bool,
    }

    struct StreamStatus has copy, drop, store {
        status: u8,
        epoch_claimed: u64,
        epoch_canceled: u64,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        balance: u64,
        config: StreamConfig,
        status: StreamStatus,
    }

    struct CancelEvent has copy, drop {
        id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        withdraw_amount: u64,
        balance: u64,
        config: StreamConfig,
        status: StreamStatus,
        pre_status: StreamStatus,
    }

    struct ClaimEvent has copy, drop {
        id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        claim_amount: u64,
        balance: u64,
        config: StreamConfig,
        status: StreamStatus,
        pre_status: StreamStatus,
    }

    struct SetAutoClaimEvent has copy, drop {
        id: 0x2::object::ID,
        coin: 0x1::ascii::String,
        balance: u64,
        enabled: bool,
    }

    struct Stream<phantom T0> has key {
        id: 0x2::object::UID,
        config: StreamConfig,
        status: StreamStatus,
        auto_claim: bool,
        balance: 0x2::coin::Coin<T0>,
    }

    public entry fun cancel_stream<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config.creator == 0x2::tx_context::sender(arg2), 12);
        assert!(arg0.config.cancelable, 9);
        assert!(!creation_status_is_canceled(arg0.status), 7);
        let v0 = arg0.status;
        let v1 = current_epoch(&arg0.config, arg1);
        let v2 = unreleased_amount(v1, &arg0.config, arg0.status);
        assert!(v2 > 0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v2, arg2), arg0.config.creator);
        set_stream_canceled<T0>(arg0, arg1);
        if (unreleased_amount(v1, &arg0.config, arg0.status) == 0) {
            set_stream_completed<T0>(arg0);
            arg0.status.epoch_claimed = v1;
        };
        verify_stream<T0>(arg0, arg1);
        let v3 = CancelEvent{
            id              : 0x2::object::uid_to_inner(&arg0.id),
            coin            : 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::coin_key<T0>(),
            withdraw_amount : v2,
            balance         : 0x2::coin::value<T0>(&arg0.balance),
            config          : arg0.config,
            status          : arg0.status,
            pre_status      : v0,
        };
        0x2::event::emit<CancelEvent>(v3);
    }

    fun claim_status_is_completed(arg0: StreamStatus) : bool {
        arg0.status & 15 == 1
    }

    public entry fun claim_stream<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config.recipient == 0x2::tx_context::sender(arg2), 13);
        let v0 = claim_stream_internal<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.config.recipient);
    }

    public entry fun claim_stream_by_proxy<T0>(arg0: &mut Stream<T0>, arg1: &mut 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::Vault, arg2: &0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::fee_module::Fee, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.auto_claim, 14);
        let v0 = claim_stream_internal<T0>(arg0, arg3, arg4);
        0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::collect_fee<T0>(arg1, 0x2::coin::split<T0>(&mut v0, 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::fee_module::claim_fee(arg2, 0x2::coin::value<T0>(&v0)), arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.config.recipient);
    }

    fun claim_stream_internal<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.status;
        let v1 = if (creation_status_is_canceled(arg0.status)) {
            arg0.status.epoch_canceled
        } else {
            current_epoch(&arg0.config, arg1)
        };
        let v2 = unclaimed_amount(v1, &arg0.status, &arg0.config);
        assert!(v2 > 0, 8);
        let v3 = 0x2::coin::split<T0>(&mut arg0.balance, v2, arg2);
        arg0.status.epoch_claimed = v1;
        if (0x2::coin::value<T0>(&arg0.balance) == 0) {
            set_stream_completed<T0>(arg0);
        };
        verify_stream<T0>(arg0, arg1);
        let v4 = ClaimEvent{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            coin         : 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::coin_key<T0>(),
            claim_amount : v2,
            balance      : 0x2::coin::value<T0>(&arg0.balance),
            config       : arg0.config,
            status       : arg0.status,
            pre_status   : v0,
        };
        0x2::event::emit<ClaimEvent>(v4);
        v3
    }

    fun claimed_amount(arg0: &StreamStatus, arg1: &StreamConfig) : u64 {
        if (arg0.epoch_claimed == 18446744073709551615) {
            0
        } else {
            arg0.epoch_claimed * arg1.amount_per_epoch + arg1.cliff
        }
    }

    public entry fun create_stream<T0>(arg0: &0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::fee_module::Fee, arg1: &mut 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::Vault, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::ascii::String, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = arg10 * arg9 + arg7;
        0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::collect_fee<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::fee_module::streaming_fee(arg0, v0), arg13));
        assert!(0x2::coin::value<T0>(&arg2) == v0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::fee_module::streaming_flat_fee(arg0), 16);
        0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::collect_fee<0x2::sui::SUI>(arg1, arg3);
        let v1 = StreamConfig{
            metadata         : arg4,
            creator          : 0x2::tx_context::sender(arg13),
            recipient        : arg5,
            time_start       : arg6,
            cliff            : arg7,
            epoch_interval   : arg8,
            total_epoch      : arg9,
            amount_per_epoch : arg10,
            cancelable       : arg11,
        };
        let v2 = new_stream<T0>(v1, arg2, arg12, arg13);
        let v3 = CreateEvent{
            id      : 0x2::object::uid_to_inner(&v2.id),
            coin    : 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::coin_key<T0>(),
            balance : 0x2::coin::value<T0>(&v2.balance),
            config  : v2.config,
            status  : v2.status,
        };
        0x2::event::emit<CreateEvent>(v3);
        0x2::transfer::share_object<Stream<T0>>(v2);
    }

    fun creation_status_is_canceled(arg0: StreamStatus) : bool {
        arg0.status & 240 == 16
    }

    fun current_epoch(arg0: &StreamConfig, arg1: &0x2::clock::Clock) : u64 {
        let v0 = now(arg1);
        if (v0 < arg0.time_start) {
            return 18446744073709551615
        };
        let v1 = (v0 - arg0.time_start) / arg0.epoch_interval;
        if (v1 > arg0.total_epoch) {
            arg0.total_epoch
        } else {
            v1
        }
    }

    fun epoch_lte(arg0: u64, arg1: u64) : bool {
        arg0 == 18446744073709551615 || arg1 == 18446744073709551615 && false || arg0 <= arg1
    }

    public fun min_epoch_interval() : u64 {
        1000 / 1
    }

    fun new_stream<T0>(arg0: StreamConfig, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Stream<T0> {
        let v0 = StreamStatus{
            status         : 0,
            epoch_claimed  : 18446744073709551615,
            epoch_canceled : 18446744073709551615,
        };
        let v1 = Stream<T0>{
            id         : 0x2::object::new(arg3),
            config     : arg0,
            status     : v0,
            auto_claim : false,
            balance    : arg1,
        };
        verify_stream<T0>(&v1, arg2);
        v1
    }

    fun now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1
    }

    fun released_amount(arg0: u64, arg1: &StreamConfig) : u64 {
        if (arg0 == 18446744073709551615) {
            0
        } else {
            arg0 * arg1.amount_per_epoch + arg1.cliff
        }
    }

    public entry fun set_auto_claim<T0>(arg0: &mut Stream<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.config.recipient == 0x2::tx_context::sender(arg2), 13);
        arg0.auto_claim = arg1;
        let v0 = SetAutoClaimEvent{
            id      : 0x2::object::uid_to_inner(&arg0.id),
            coin    : 0xdadc65d397f2d18a1d0349db0e6e5a86ef846e80dea01971a0c0487f95cae1ad::vault::coin_key<T0>(),
            balance : 0x2::coin::value<T0>(&arg0.balance),
            enabled : arg1,
        };
        0x2::event::emit<SetAutoClaimEvent>(v0);
    }

    fun set_claim_status_completed(arg0: &mut StreamStatus) {
        arg0.status = arg0.status | 1;
    }

    fun set_creation_status_canceled(arg0: &mut StreamStatus) {
        arg0.status = arg0.status | 16;
    }

    fun set_stream_canceled<T0>(arg0: &mut Stream<T0>, arg1: &0x2::clock::Clock) {
        arg0.status.epoch_canceled = current_epoch(&arg0.config, arg1);
        let v0 = &mut arg0.status;
        set_creation_status_canceled(v0);
    }

    fun set_stream_completed<T0>(arg0: &mut Stream<T0>) {
        assert!(!claim_status_is_completed(arg0.status), 11);
        let v0 = &mut arg0.status;
        set_claim_status_completed(v0);
    }

    public fun start_time_range() : (u64, u64) {
        (1000000000000 / 1, 10000000000000 / 1)
    }

    fun unclaimed_amount(arg0: u64, arg1: &StreamStatus, arg2: &StreamConfig) : u64 {
        released_amount(arg0, arg2) - claimed_amount(arg1, arg2)
    }

    fun unreleased_amount(arg0: u64, arg1: &StreamConfig, arg2: StreamStatus) : u64 {
        if (creation_status_is_canceled(arg2)) {
            released_amount(arg2.epoch_canceled, arg1) - released_amount(arg2.epoch_claimed, arg1)
        } else {
            arg1.total_epoch * arg1.amount_per_epoch + arg1.cliff - released_amount(arg0, arg1)
        }
    }

    fun verify_stream<T0>(arg0: &Stream<T0>, arg1: &0x2::clock::Clock) {
        let (v0, v1) = start_time_range();
        assert!(arg0.config.time_start >= v0 && arg0.config.time_start <= v1, 4);
        assert!(arg0.config.epoch_interval >= min_epoch_interval(), 2);
        assert!(arg0.config.amount_per_epoch > 0, 5);
        assert!(arg0.config.total_epoch > 0, 3);
        let v2 = current_epoch(&arg0.config, arg1);
        assert!(epoch_lte(arg0.status.epoch_claimed, v2), 6);
        assert!(epoch_lte(arg0.status.epoch_canceled, v2), 6);
        assert!(epoch_lte(arg0.status.epoch_claimed, arg0.config.total_epoch), 6);
        assert!(epoch_lte(arg0.status.epoch_canceled, arg0.config.total_epoch), 6);
        let v3 = 0x2::coin::value<T0>(&arg0.balance);
        let v4 = claim_status_is_completed(arg0.status);
        if (v3 == 0) {
            assert!(v4, 17);
        };
        if (creation_status_is_canceled(arg0.status)) {
            assert!(arg0.config.cancelable, 9);
            assert!(epoch_lte(arg0.status.epoch_claimed, arg0.status.epoch_canceled), 6);
            if (v4) {
                assert!(arg0.status.epoch_claimed == arg0.status.epoch_canceled, 6);
                assert!(v3 == 0, 1);
            } else {
                assert!(v3 == unclaimed_amount(arg0.status.epoch_canceled, &arg0.status, &arg0.config), 1);
            };
        } else {
            assert!(arg0.status.epoch_canceled == 18446744073709551615, 6);
            if (v4) {
                assert!(arg0.status.epoch_claimed == arg0.config.total_epoch, 6);
                assert!(v3 == 0, 1);
            } else {
                assert!(v3 == unreleased_amount(v2, &arg0.config, arg0.status) + unclaimed_amount(v2, &arg0.status, &arg0.config), 1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

