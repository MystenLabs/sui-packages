module 0x6d362056c6af8df52e956a540b024681d31f21f17a20efb68108b632b9bd7e71::payment {
    struct PaymentConfig has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct PaymentReceived has copy, drop {
        config: address,
        order_id: vector<u8>,
        payer: address,
        treasury: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ConfigInitialized has copy, drop {
        config: address,
        coin_type: 0x1::type_name::TypeName,
        treasury: address,
        by: address,
        timestamp_ms: u64,
    }

    struct TreasuryChanged has copy, drop {
        config: address,
        old_treasury: address,
        new_treasury: address,
        by: address,
        timestamp_ms: u64,
    }

    struct PauseChanged has copy, drop {
        config: address,
        paused: bool,
        by: address,
        timestamp_ms: u64,
    }

    struct Migrated has copy, drop {
        config: address,
        from_version: u64,
        to_version: u64,
        by: address,
        timestamp_ms: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentConfig{
            id        : 0x2::object::new(arg0),
            version   : 1,
            treasury  : @0x0,
            coin_type : 0x1::option::none<0x1::type_name::TypeName>(),
            paused    : true,
        };
        let v1 = AdminCap{
            id        : 0x2::object::new(arg0),
            config_id : 0x2::object::id<PaymentConfig>(&v0),
        };
        0x2::transfer::share_object<PaymentConfig>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0>(arg0: &mut PaymentConfig, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.config_id == 0x2::object::id<PaymentConfig>(arg0), 5);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.coin_type), 9);
        assert!(arg2 != @0x0, 4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        arg0.coin_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg0.treasury = arg2;
        arg0.paused = false;
        let v1 = ConfigInitialized{
            config       : 0x2::object::uid_to_address(&arg0.id),
            coin_type    : v0,
            treasury     : arg2,
            by           : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConfigInitialized>(v1);
    }

    public fun is_initialized(arg0: &PaymentConfig) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.coin_type)
    }

    public fun is_paused(arg0: &PaymentConfig) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &mut PaymentConfig, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.config_id == 0x2::object::id<PaymentConfig>(arg0), 5);
        assert!(arg0.version < 1, 11);
        arg0.version = 1;
        let v0 = Migrated{
            config       : 0x2::object::uid_to_address(&arg0.id),
            from_version : arg0.version,
            to_version   : 1,
            by           : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun pay<T0>(arg0: &PaymentConfig, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.coin_type), 8);
        assert!(!arg0.paused, 1);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.coin_type) == 0x1::type_name::with_original_ids<T0>(), 7);
        assert!(arg0.treasury == arg3, 6);
        assert!(0x1::vector::length<u8>(&arg2) == 16, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 <= arg4, 12);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        let v2 = arg0.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        let v3 = PaymentReceived{
            config       : 0x2::object::uid_to_address(&arg0.id),
            order_id     : arg2,
            payer        : 0x2::tx_context::sender(arg6),
            treasury     : v2,
            amount       : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<PaymentReceived>(v3);
    }

    public fun set_paused(arg0: &mut PaymentConfig, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.config_id == 0x2::object::id<PaymentConfig>(arg0), 5);
        arg0.paused = arg2;
        let v0 = PauseChanged{
            config       : 0x2::object::uid_to_address(&arg0.id),
            paused       : arg2,
            by           : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_treasury(arg0: &mut PaymentConfig, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.config_id == 0x2::object::id<PaymentConfig>(arg0), 5);
        assert!(arg2 != @0x0, 4);
        arg0.treasury = arg2;
        let v0 = TreasuryChanged{
            config       : 0x2::object::uid_to_address(&arg0.id),
            old_treasury : arg0.treasury,
            new_treasury : arg2,
            by           : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun treasury_of(arg0: &PaymentConfig) : address {
        arg0.treasury
    }

    public fun version_of(arg0: &PaymentConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

