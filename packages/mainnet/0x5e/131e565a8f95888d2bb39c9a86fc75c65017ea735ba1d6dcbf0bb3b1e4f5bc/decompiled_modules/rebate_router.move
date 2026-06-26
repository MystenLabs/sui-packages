module 0x5e131e565a8f95888d2bb39c9a86fc75c65017ea735ba1d6dcbf0bb3b1e4f5bc::rebate_router {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_recipient: address,
        fee_bps: u16,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConfigInitialized has copy, drop {
        config_id: 0x2::object::ID,
        fee_recipient: address,
        fee_bps: u16,
    }

    struct FeeRecipientUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
    }

    struct FeeBpsUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_bps: u16,
        new_bps: u16,
    }

    struct CoinClosed has copy, drop {
        coin_type: 0x1::ascii::String,
        owner: address,
    }

    struct CoinBurned has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
        owner: address,
    }

    struct FeeCollected has copy, drop {
        config_id: 0x2::object::ID,
        payer: address,
        recipient: address,
        amount: u64,
        declared_gross_rebate: u64,
    }

    public fun burn_coin_full<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xdead);
        let v0 = CoinBurned{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : 0x2::coin::value<T0>(&arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CoinBurned>(v0);
    }

    public fun burn_coin_portion<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg2), @0xdead);
        let v0 = CoinBurned{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : arg1,
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CoinBurned>(v0);
    }

    public fun close_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<T0>(arg0);
        let v0 = CoinClosed{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CoinClosed>(v0);
    }

    public fun collect_fee(arg0: &Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg2 > 0, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!((v0 as u128) * 10000 <= (arg2 as u128) * (arg0.fee_bps as u128), 3);
        let v1 = arg0.fee_recipient;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        let v2 = FeeCollected{
            config_id             : 0x2::object::id<Config>(arg0),
            payer                 : 0x2::tx_context::sender(arg3),
            recipient             : v1,
            amount                : v0,
            declared_gross_rebate : arg2,
        };
        0x2::event::emit<FeeCollected>(v2);
    }

    public fun fee_bps(arg0: &Config) : u16 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            fee_recipient : v0,
            fee_bps       : 500,
        };
        let v2 = ConfigInitialized{
            config_id     : 0x2::object::id<Config>(&v1),
            fee_recipient : v0,
            fee_bps       : 500,
        };
        0x2::event::emit<ConfigInitialized>(v2);
        0x2::transfer::share_object<Config>(v1);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        assert!(arg2 <= 1000, 1);
        arg1.fee_bps = arg2;
        let v0 = FeeBpsUpdated{
            config_id : 0x2::object::id<Config>(arg1),
            old_bps   : arg1.fee_bps,
            new_bps   : arg2,
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{
            config_id     : 0x2::object::id<Config>(arg1),
            old_recipient : arg1.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

