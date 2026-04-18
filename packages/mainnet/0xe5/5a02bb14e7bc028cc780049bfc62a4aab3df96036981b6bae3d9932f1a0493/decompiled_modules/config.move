module 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RebalancerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeBpsUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct FeeReceiverUpdated has copy, drop {
        old_receiver: address,
        new_receiver: address,
    }

    struct PauseUpdated has copy, drop {
        paused: bool,
    }

    struct FeesWithdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        receiver: address,
    }

    struct Config has key {
        id: 0x2::object::UID,
        paused: bool,
        protocol_fee_bps: u64,
        fees: 0x2::bag::Bag,
        fee_receiver: address,
        validator: 0x1::option::Option<vector<u8>>,
        version: u64,
    }

    public(friend) fun add_fee<T0>(arg0: &mut Config, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v0, arg1);
        };
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 101);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 102);
    }

    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun deduct_fee_on_yield<T0>(arg0: &mut Config, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) : u64 {
        let v0 = calculate_fee(arg2, arg0.protocol_fee_bps);
        if (v0 > 0) {
            let v1 = 0x1::type_name::with_defining_ids<T0>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v1)) {
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v1), 0x2::balance::split<T0>(arg1, v0));
            } else {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fees, v1, 0x2::balance::split<T0>(arg1, v0));
            };
        };
        v0
    }

    public fun fee_receiver(arg0: &Config) : address {
        arg0.fee_receiver
    }

    public fun fees_balance<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fees, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.fees, v0))
        } else {
            0
        }
    }

    public fun grant_rebalancer_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RebalancerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<RebalancerCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = RebalancerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RebalancerCap>(v2, v0);
        let v3 = Config{
            id               : 0x2::object::new(arg0),
            paused           : false,
            protocol_fee_bps : 1000,
            fees             : 0x2::bag::new(arg0),
            fee_receiver     : v0,
            validator        : 0x1::option::none<vector<u8>>(),
            version          : 1,
        };
        0x2::transfer::share_object<Config>(v3);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun set_fee_receiver(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_receiver = arg2;
        let v0 = FeeReceiverUpdated{
            old_receiver : arg1.fee_receiver,
            new_receiver : arg2,
        };
        0x2::event::emit<FeeReceiverUpdated>(v0);
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseUpdated{paused: arg2};
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun set_protocol_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 2000, 100);
        arg1.protocol_fee_bps = arg2;
        let v0 = ProtocolFeeBpsUpdated{
            old_fee_bps : arg1.protocol_fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<ProtocolFeeBpsUpdated>(v0);
    }

    public fun update_validator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut Config) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 110);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public(friend) fun verify_signature(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>) {
        if (0x1::option::is_none<vector<u8>>(&arg0.validator)) {
            abort 111
        };
        assert!(0x2::ed25519::ed25519_verify(&arg1, 0x1::option::borrow<vector<u8>>(&arg0.validator), &arg2), 112);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_all_fees<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fees, v0)) {
            let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fees, v0);
            let v2 = 0x2::balance::value<T0>(v1);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg2), arg1.fee_receiver);
                let v3 = FeesWithdrawn{
                    coin_type : v0,
                    amount    : v2,
                    receiver  : arg1.fee_receiver,
                };
                0x2::event::emit<FeesWithdrawn>(v3);
            };
        };
    }

    // decompiled from Move bytecode v6
}

