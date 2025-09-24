module 0x11c2ffbf8cfcc378cd19d930c544a92d33bd4c34be700766fd028300974312bc::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        paused: bool,
        version: u64,
    }

    struct ProtocolFeeVault has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
    }

    struct ProtocolFeeCollected has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        collected_at: u64,
    }

    struct ProtocolFeeClaimed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        claimed_at: u64,
    }

    public fun claim_protocol_fee<T0>(arg0: &GlobalConfig, arg1: &AdminCap, arg2: &mut ProtocolFeeVault, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg2.vault, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.vault, v0);
        let v2 = ProtocolFeeClaimed{
            token_type : v0,
            amount     : 0x2::balance::value<T0>(&v1),
            recipient  : 0x2::tx_context::sender(arg4),
            claimed_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProtocolFeeClaimed>(v2);
        v1
    }

    public fun collect_protocol_fee<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, arg1);
        };
        let v1 = ProtocolFeeCollected{
            token_type   : v0,
            amount       : 0x2::balance::value<T0>(&arg1),
            collected_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProtocolFeeCollected>(v1);
    }

    public fun get_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.fee_rate
    }

    public fun get_version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    public fun grant_operator_cap(arg0: &GlobalConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        let v2 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            fee_rate : 1000,
            paused   : false,
            version  : 1,
        };
        let v3 = ProtocolFeeVault{
            id    : 0x2::object::new(arg0),
            vault : 0x2::bag::new(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OperatorCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v2);
        0x2::transfer::share_object<ProtocolFeeVault>(v3);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun set_fee_rate(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.fee_rate = arg2;
    }

    public fun set_paused(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

