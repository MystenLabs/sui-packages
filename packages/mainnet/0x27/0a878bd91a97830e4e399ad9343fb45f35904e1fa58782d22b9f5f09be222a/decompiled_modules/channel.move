module 0x270a878bd91a97830e4e399ad9343fb45f35904e1fa58782d22b9f5f09be222a::channel {
    struct Registry has key {
        id: 0x2::object::UID,
        shard: u64,
    }

    struct ChannelKey has copy, drop, store {
        payer: address,
        nonce: u64,
    }

    struct Channel<phantom T0> has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        operator: address,
        authorizer: vector<u8>,
        funds: 0x2::balance::Balance<T0>,
        deposited: u64,
        claimed: u64,
        withdraw_delay_ms: u64,
        close_requested_at_ms: 0x1::option::Option<u64>,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        shard: u64,
    }

    struct ChannelOpened<phantom T0> has copy, drop {
        channel_id: 0x2::object::ID,
        payer: address,
        payee: address,
        operator: address,
        authorizer: vector<u8>,
        nonce: u64,
        deposit: u64,
        withdraw_delay_ms: u64,
    }

    struct ChannelToppedUp<phantom T0> has copy, drop {
        channel_id: 0x2::object::ID,
        amount: u64,
        deposited: u64,
    }

    struct ChannelClaimed<phantom T0> has copy, drop {
        channel_id: 0x2::object::ID,
        payee: address,
        amount: u64,
        claimed: u64,
    }

    struct ChannelCloseRequested<phantom T0> has copy, drop {
        channel_id: 0x2::object::ID,
        requested_at_ms: u64,
        withdrawable_at_ms: u64,
    }

    struct ChannelClosed<phantom T0> has copy, drop {
        channel_id: 0x2::object::ID,
        claimed: u64,
        refunded: u64,
    }

    public fun balance<T0>(arg0: &Channel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun claim<T0>(arg0: &mut Channel<T0>, arg1: u64, arg2: vector<u8>) {
        assert!(arg1 > arg0.claimed, 13835903558249480199);
        assert!(arg1 <= arg0.deposited, 13836185037521289225);
        let v0 = voucher_message(0x2::object::uid_to_inner(&arg0.id), arg1);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.authorizer, &v0), 13835622096157540357);
        let v1 = arg1 - arg0.claimed;
        arg0.claimed = arg1;
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.funds, v1), arg0.payee);
        let v2 = ChannelClaimed<T0>{
            channel_id : 0x2::object::uid_to_inner(&arg0.id),
            payee      : arg0.payee,
            amount     : v1,
            claimed    : arg1,
        };
        0x2::event::emit<ChannelClaimed<T0>>(v2);
    }

    public fun authorizer<T0>(arg0: &Channel<T0>) : vector<u8> {
        arg0.authorizer
    }

    public fun channel_id(arg0: &Registry, arg1: address, arg2: u64) : 0x2::object::ID {
        let v0 = ChannelKey{
            payer : arg1,
            nonce : arg2,
        };
        0x2::object::id_from_address(0x2::derived_object::derive_address<ChannelKey>(0x2::object::uid_to_inner(&arg0.id), v0))
    }

    public fun claimed<T0>(arg0: &Channel<T0>) : u64 {
        arg0.claimed
    }

    public fun close<T0>(arg0: Channel<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.payee || v0 == arg0.operator, 13835340694195142659);
        destroy<T0>(arg0);
    }

    public fun close_requested_at_ms<T0>(arg0: &Channel<T0>) : 0x1::option::Option<u64> {
        arg0.close_requested_at_ms
    }

    fun create_registries(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = 0x2::object::new(arg1);
            let v2 = RegistryCreated{
                registry_id : 0x2::object::uid_to_inner(&v1),
                shard       : v0,
            };
            0x2::event::emit<RegistryCreated>(v2);
            let v3 = Registry{
                id    : v1,
                shard : v0,
            };
            0x2::transfer::share_object<Registry>(v3);
            v0 = v0 + 1;
        };
    }

    public fun deposited<T0>(arg0: &Channel<T0>) : u64 {
        arg0.deposited
    }

    fun destroy<T0>(arg0: Channel<T0>) {
        let Channel {
            id                    : v0,
            payer                 : v1,
            payee                 : _,
            operator              : _,
            authorizer            : _,
            funds                 : v5,
            deposited             : _,
            claimed               : v7,
            withdraw_delay_ms     : _,
            close_requested_at_ms : _,
        } = arg0;
        let v10 = v5;
        let v11 = v0;
        let v12 = 0x2::balance::value<T0>(&v10);
        let v13 = ChannelClosed<T0>{
            channel_id : 0x2::object::uid_to_inner(&v11),
            claimed    : v7,
            refunded   : v12,
        };
        0x2::event::emit<ChannelClosed<T0>>(v13);
        if (v12 > 0) {
            0x2::balance::send_funds<T0>(v10, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        0x2::object::delete(v11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_registries(16, arg0);
    }

    public fun open<T0>(arg0: &mut Registry, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13836466168900747275);
        assert!(arg4 >= 900000 && arg4 <= 2592000000, 13836747656762490893);
        let v0 = 0x2::balance::value<T0>(&arg6);
        assert!(v0 > 0, 13837592094577917971);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = ChannelKey{
            payer : v1,
            nonce : arg5,
        };
        let v3 = 0x2::derived_object::claim<ChannelKey>(&mut arg0.id, v2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = ChannelOpened<T0>{
            channel_id        : v4,
            payer             : v1,
            payee             : arg1,
            operator          : arg2,
            authorizer        : arg3,
            nonce             : arg5,
            deposit           : v0,
            withdraw_delay_ms : arg4,
        };
        0x2::event::emit<ChannelOpened<T0>>(v5);
        let v6 = Channel<T0>{
            id                    : v3,
            payer                 : v1,
            payee                 : arg1,
            operator              : arg2,
            authorizer            : arg3,
            funds                 : arg6,
            deposited             : v0,
            claimed               : 0,
            withdraw_delay_ms     : arg4,
            close_requested_at_ms : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Channel<T0>>(v6);
        v4
    }

    public fun operator<T0>(arg0: &Channel<T0>) : address {
        arg0.operator
    }

    public fun payee<T0>(arg0: &Channel<T0>) : address {
        arg0.payee
    }

    public fun payer<T0>(arg0: &Channel<T0>) : address {
        arg0.payer
    }

    public fun registry_shards() : u64 {
        16
    }

    public fun request_close<T0>(arg0: &mut Channel<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 13835059025944772609);
        if (0x1::option::is_some<u64>(&arg0.close_requested_at_ms)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.close_requested_at_ms = 0x1::option::some<u64>(v0);
        let v1 = ChannelCloseRequested<T0>{
            channel_id         : 0x2::object::uid_to_inner(&arg0.id),
            requested_at_ms    : v0,
            withdrawable_at_ms : v0 + arg0.withdraw_delay_ms,
        };
        0x2::event::emit<ChannelCloseRequested<T0>>(v1);
    }

    public fun shard(arg0: &Registry) : u64 {
        arg0.shard
    }

    public fun top_up<T0>(arg0: &mut Channel<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(0x1::option::is_none<u64>(&arg0.close_requested_at_ms), 13837873715583647765);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 13837592249196740627);
        0x2::balance::join<T0>(&mut arg0.funds, arg1);
        arg0.deposited = arg0.deposited + v0;
        let v1 = ChannelToppedUp<T0>{
            channel_id : 0x2::object::uid_to_inner(&arg0.id),
            amount     : v0,
            deposited  : arg0.deposited,
        };
        0x2::event::emit<ChannelToppedUp<T0>>(v1);
    }

    public fun voucher_message(arg0: 0x2::object::ID, arg1: u64) : vector<u8> {
        let v0 = b"blockpay/channel/voucher/v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun withdraw<T0>(arg0: Channel<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payer, 13835059081779347457);
        assert!(0x1::option::is_some<u64>(&arg0.close_requested_at_ms), 13837029410912206863);
        assert!(0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.close_requested_at_ms) + arg0.withdraw_delay_ms, 13837310894478983185);
        destroy<T0>(arg0);
    }

    public fun withdraw_delay_ms<T0>(arg0: &Channel<T0>) : u64 {
        arg0.withdraw_delay_ms
    }

    // decompiled from Move bytecode v7
}

