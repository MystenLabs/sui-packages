module 0x92831e29808a47a7206e4a4bf12a82706c2ca2e81c6be3129fb2e9d8a4a56a56::tunnel {
    struct ReceiverConfig has copy, drop, store {
        _type: u64,
        fee_bps: u64,
        _address: address,
    }

    struct CreatorConfig has store, key {
        id: 0x2::object::UID,
        creator: address,
        operator: address,
        receiver_configs: vector<ReceiverConfig>,
        operator_public_key: vector<u8>,
        metadata: 0x1::string::String,
        grace_period_ms: u64,
    }

    struct Tunnel<phantom T0> has store, key {
        id: 0x2::object::UID,
        payer: address,
        creator: address,
        operator: address,
        receiver_configs: vector<ReceiverConfig>,
        payer_public_key: vector<u8>,
        operator_public_key: vector<u8>,
        credential: vector<u8>,
        grace_period_ms: u64,
        total_deposit: u64,
        claimed_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        is_closed: bool,
        close_initiated_at: 0x1::option::Option<u64>,
        close_initiated_by: 0x1::option::Option<address>,
    }

    struct ClaimReceipt has drop {
        tunnel_id: 0x2::object::ID,
    }

    struct CreatorConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        creator: address,
        operator_public_key: vector<u8>,
    }

    struct TunnelOpened has copy, drop {
        tunnel_id: 0x2::object::ID,
        payer: address,
        creator: address,
        deposit: u64,
    }

    struct FundsClaimed has copy, drop {
        tunnel_id: 0x2::object::ID,
        amount: u64,
        total_claimed: u64,
        claimed_by: address,
    }

    struct CloseInitiated has copy, drop {
        tunnel_id: 0x2::object::ID,
        initiated_by: address,
        initiated_at: u64,
    }

    struct TunnelClosed has copy, drop {
        tunnel_id: 0x2::object::ID,
        payer: address,
        creator: address,
        payer_refund: u64,
        creator_payout: u64,
        closed_by: address,
    }

    struct PaymentProcessed has copy, drop {
        config_id: 0x2::object::ID,
        payer: address,
        referrer: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun claim<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : ClaimReceipt {
        let v0 = 0x2::object::uid_to_bytes(&arg0.id);
        let v1 = construct_claim_message(&v0, arg1, arg2);
        verify_ed25519_signature(&arg3, &arg0.payer_public_key, &v1);
        let v2 = 0x2::tx_context::sender(arg4);
        claim_internal<T0>(arg0, arg1, v2, arg4)
    }

    fun claim_internal<T0>(arg0: &mut Tunnel<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ClaimReceipt {
        assert!(arg2 == arg0.creator || arg2 == arg0.operator, 4);
        assert!(!arg0.is_closed, 1);
        assert!(arg1 > arg0.claimed_amount, 8);
        assert!(arg1 <= arg0.total_deposit, 2);
        let v0 = arg1 - arg0.claimed_amount;
        arg0.claimed_amount = arg1;
        let v1 = FundsClaimed{
            tunnel_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount        : v0,
            total_claimed : arg0.claimed_amount,
            claimed_by    : arg2,
        };
        0x2::event::emit<FundsClaimed>(v1);
        distribute_fees<T0>(&arg0.receiver_configs, v0, 0x2::balance::split<T0>(&mut arg0.balance, v0), arg2, arg3);
        ClaimReceipt{tunnel_id: 0x2::object::uid_to_inner(&arg0.id)}
    }

    public fun claimed_amount<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.claimed_amount
    }

    fun close_tunnel_and_refund<T0>(arg0: Tunnel<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.payer;
        let v1 = TunnelClosed{
            tunnel_id      : 0x2::object::id<Tunnel<T0>>(&arg0),
            payer          : v0,
            creator        : arg0.creator,
            payer_refund   : arg1,
            creator_payout : 0,
            closed_by      : arg2,
        };
        0x2::event::emit<TunnelClosed>(v1);
        let Tunnel {
            id                  : v2,
            payer               : _,
            creator             : _,
            operator            : _,
            receiver_configs    : _,
            payer_public_key    : _,
            operator_public_key : _,
            credential          : _,
            grace_period_ms     : _,
            total_deposit       : _,
            claimed_amount      : _,
            balance             : v13,
            is_closed           : _,
            close_initiated_at  : _,
            close_initiated_by  : _,
        } = arg0;
        0x2::object::delete(v2);
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg3), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v13);
        };
    }

    public fun close_with_receipt<T0>(arg0: Tunnel<T0>, arg1: ClaimReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.tunnel_id == 0x2::object::uid_to_inner(&arg0.id), 10);
        assert!(!arg0.is_closed, 1);
        let ClaimReceipt {  } = arg1;
        let v0 = 0x2::tx_context::sender(arg2);
        close_tunnel_and_refund<T0>(arg0, 0x2::balance::value<T0>(&arg0.balance), v0, arg2);
    }

    fun construct_claim_message(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun create_creator_config(arg0: address, arg1: vector<u8>, arg2: 0x1::string::String, arg3: vector<ReceiverConfig>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<ReceiverConfig>(&arg3)) {
            v0 = v0 + 0x1::vector::borrow<ReceiverConfig>(&arg3, v1).fee_bps;
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 9);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = CreatorConfig{
            id                  : 0x2::object::new(arg5),
            creator             : v2,
            operator            : arg0,
            receiver_configs    : arg3,
            operator_public_key : arg1,
            metadata            : arg2,
            grace_period_ms     : arg4,
        };
        let v4 = CreatorConfigCreated{
            config_id           : 0x2::object::id<CreatorConfig>(&v3),
            creator             : v2,
            operator_public_key : arg1,
        };
        0x2::event::emit<CreatorConfigCreated>(v4);
        0x2::transfer::share_object<CreatorConfig>(v3);
    }

    public fun create_receiver_config(arg0: u64, arg1: address, arg2: u64) : ReceiverConfig {
        ReceiverConfig{
            _type    : arg0,
            fee_bps  : arg2,
            _address : arg1,
        }
    }

    public fun creator<T0>(arg0: &Tunnel<T0>) : address {
        arg0.creator
    }

    public fun creator_config_creator(arg0: &CreatorConfig) : address {
        arg0.creator
    }

    public fun creator_config_metadata(arg0: &CreatorConfig) : 0x1::string::String {
        arg0.metadata
    }

    public fun creator_config_operator_public_key(arg0: &CreatorConfig) : vector<u8> {
        arg0.operator_public_key
    }

    fun distribute_fees<T0>(arg0: &vector<ReceiverConfig>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<ReceiverConfig>(arg0);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<ReceiverConfig>(arg0, v4);
            if (v5._type == 4022 && v5._address == @0x0) {
                v1 = true;
                v2 = v5.fee_bps;
            };
            if (v5._type == 4020) {
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        v4 = 0;
        while (v4 < v0) {
            let v6 = 0x1::vector::borrow<ReceiverConfig>(arg0, v4);
            if (v6._type == 4022 && v6._address == @0x0) {
                v4 = v4 + 1;
                continue
            };
            let v7 = arg1 * v6.fee_bps / 10000;
            let v8 = v7;
            let v9 = if (v1) {
                if (v6._type == 4020) {
                    v3 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                v8 = v7 + arg1 * v2 / 10000 / v3;
            };
            if (v8 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v8), arg4), v6._address);
            };
            v4 = v4 + 1;
        };
        if (0x2::balance::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun finalize_close<T0>(arg0: Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_closed, 1);
        assert!(0x1::option::is_some<u64>(&arg0.close_initiated_at), 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.close_initiated_at) + arg0.grace_period_ms, 7);
        let v0 = 0x2::tx_context::sender(arg2);
        close_tunnel_and_refund<T0>(arg0, arg0.total_deposit - arg0.claimed_amount, v0, arg2);
    }

    public fun init_close<T0>(arg0: &mut Tunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 4);
        assert!(!arg0.is_closed, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.close_initiated_at = 0x1::option::some<u64>(v0);
        arg0.close_initiated_by = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        let v1 = CloseInitiated{
            tunnel_id    : 0x2::object::uid_to_inner(&arg0.id),
            initiated_by : 0x2::tx_context::sender(arg2),
            initiated_at : v0,
        };
        0x2::event::emit<CloseInitiated>(v1);
    }

    public fun is_closed<T0>(arg0: &Tunnel<T0>) : bool {
        arg0.is_closed
    }

    public fun open_tunnel<T0>(arg0: &CreatorConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg0.creator;
        assert!(0x1::vector::length<u8>(&arg1) == 32, 5);
        let v2 = 0x2::coin::value<T0>(&arg4);
        assert!(v2 > 0, 8);
        let v3 = arg0.receiver_configs;
        let v4 = 0;
        while (v4 < 0x1::vector::length<ReceiverConfig>(&v3)) {
            let v5 = 0x1::vector::borrow_mut<ReceiverConfig>(&mut v3, v4);
            if (v5._type == 4022) {
                v5._address = arg3;
            };
            v4 = v4 + 1;
        };
        let v6 = Tunnel<T0>{
            id                  : 0x2::object::new(arg5),
            payer               : v0,
            creator             : v1,
            operator            : arg0.operator,
            receiver_configs    : v3,
            payer_public_key    : arg1,
            operator_public_key : arg0.operator_public_key,
            credential          : arg2,
            grace_period_ms     : arg0.grace_period_ms,
            total_deposit       : v2,
            claimed_amount      : 0,
            balance             : 0x2::coin::into_balance<T0>(arg4),
            is_closed           : false,
            close_initiated_at  : 0x1::option::none<u64>(),
            close_initiated_by  : 0x1::option::none<address>(),
        };
        let v7 = TunnelOpened{
            tunnel_id : 0x2::object::id<Tunnel<T0>>(&v6),
            payer     : v0,
            creator   : v1,
            deposit   : v2,
        };
        0x2::event::emit<TunnelOpened>(v7);
        0x2::transfer::share_object<Tunnel<T0>>(v6);
    }

    public fun payer<T0>(arg0: &Tunnel<T0>) : address {
        arg0.payer
    }

    public fun process_payment<T0>(arg0: &CreatorConfig, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = arg0.receiver_configs;
        let v3 = 0;
        while (v3 < 0x1::vector::length<ReceiverConfig>(&v2)) {
            let v4 = 0x1::vector::borrow_mut<ReceiverConfig>(&mut v2, v3);
            if (v4._type == 4022) {
                v4._address = arg1;
            };
            v3 = v3 + 1;
        };
        distribute_fees<T0>(&v2, v1, 0x2::coin::into_balance<T0>(arg2), arg0.operator, arg4);
        let v5 = PaymentProcessed{
            config_id    : 0x2::object::id<CreatorConfig>(arg0),
            payer        : v0,
            referrer     : arg1,
            amount       : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PaymentProcessed>(v5);
    }

    public fun remaining_balance<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.total_deposit - arg0.claimed_amount
    }

    public fun total_deposit<T0>(arg0: &Tunnel<T0>) : u64 {
        arg0.total_deposit
    }

    public fun tunnel_id<T0>(arg0: &Tunnel<T0>) : 0x2::object::ID {
        0x2::object::id<Tunnel<T0>>(arg0)
    }

    fun verify_ed25519_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 64, 3);
        assert!(0x1::vector::length<u8>(arg1) == 32, 5);
        assert!(0x2::ed25519::ed25519_verify(arg0, arg1, arg2), 3);
    }

    // decompiled from Move bytecode v6
}

