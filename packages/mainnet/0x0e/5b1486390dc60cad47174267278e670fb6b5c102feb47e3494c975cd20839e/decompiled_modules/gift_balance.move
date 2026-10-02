module 0xe5b1486390dc60cad47174267278e670fb6b5c102feb47e3494c975cd20839e::gift_balance {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Settings has key {
        id: 0x2::object::UID,
        paused: bool,
        max_balance: u64,
        max_per_day_cap: u64,
        coin_type: 0x1::option::Option<0x1::ascii::String>,
        registry_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct GiftBalance<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        device_key: 0x1::option::Option<address>,
        funds: 0x2::balance::Balance<T0>,
        max_per_gift: u64,
        max_per_day: u64,
        day_start_ms: u64,
        spent_today: u64,
        expires_at_ms: u64,
        total_sent: u64,
    }

    struct BalanceOpened has copy, drop {
        balance_id: 0x2::object::ID,
        owner: address,
        device_key: address,
        amount: u64,
        max_per_gift: u64,
        max_per_day: u64,
        expires_at_ms: u64,
    }

    struct BalanceToppedUp has copy, drop {
        balance_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct BalanceWithdrawn has copy, drop {
        balance_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct DeviceKeyChanged has copy, drop {
        balance_id: 0x2::object::ID,
        owner: address,
        device_key: 0x1::option::Option<address>,
        expires_at_ms: u64,
    }

    struct LimitsChanged has copy, drop {
        balance_id: 0x2::object::ID,
        owner: address,
        max_per_gift: u64,
        max_per_day: u64,
    }

    struct BalanceGiftSent has copy, drop {
        balance_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        owner: address,
        signer: address,
        creator: address,
        gift_id: 0x1::string::String,
        stream_id: 0x1::string::String,
        amount: u64,
        remaining: u64,
        spent_today: u64,
        timestamp_ms: u64,
    }

    struct SettingsChanged has copy, drop {
        paused: bool,
        max_balance: u64,
        max_per_day_cap: u64,
    }

    struct Configured has copy, drop {
        coin_type: 0x1::ascii::String,
        registry_id: 0x2::object::ID,
    }

    public fun value<T0>(arg0: &GiftBalance<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun check_coin<T0>(arg0: &Settings) : 0x1::ascii::String {
        assert!(0x1::option::is_some<0x1::ascii::String>(&arg0.coin_type), 13);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(*0x1::option::borrow<0x1::ascii::String>(&arg0.coin_type) == v0, 15);
        v0
    }

    fun check_expiry(arg0: u64, arg1: u64) {
        assert!(arg1 > arg0 && arg1 <= arg0 + 7776000000, 12);
    }

    fun check_limits(arg0: &Settings, arg1: u64, arg2: u64) {
        let v0 = if (arg1 > 0) {
            if (arg2 >= arg1) {
                arg2 <= arg0.max_per_day_cap
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
    }

    public fun configure<T0>(arg0: &AdminCap, arg1: &mut Settings, arg2: &0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>) {
        assert!(0x1::option::is_none<0x1::ascii::String>(&arg1.coin_type) && 0x1::option::is_none<0x2::object::ID>(&arg1.registry_id), 14);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        arg1.coin_type = 0x1::option::some<0x1::ascii::String>(v0);
        arg1.registry_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg2));
        let v1 = Configured{
            coin_type   : v0,
            registry_id : 0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg2),
        };
        0x2::event::emit<Configured>(v1);
    }

    public fun device_key<T0>(arg0: &GiftBalance<T0>) : 0x1::option::Option<address> {
        arg0.device_key
    }

    fun emit_settings(arg0: &Settings) {
        let v0 = SettingsChanged{
            paused          : arg0.paused,
            max_balance     : arg0.max_balance,
            max_per_day_cap : arg0.max_per_day_cap,
        };
        0x2::event::emit<SettingsChanged>(v0);
    }

    public fun expires_at_ms<T0>(arg0: &GiftBalance<T0>) : u64 {
        arg0.expires_at_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Settings{
            id              : 0x2::object::new(arg0),
            paused          : false,
            max_balance     : 500000000,
            max_per_day_cap : 100000000,
            coin_type       : 0x1::option::none<0x1::ascii::String>(),
            registry_id     : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Settings>(v1);
    }

    public fun is_paused(arg0: &Settings) : bool {
        arg0.paused
    }

    public fun limits<T0>(arg0: &GiftBalance<T0>) : (u64, u64) {
        (arg0.max_per_gift, arg0.max_per_day)
    }

    public fun max_balance(arg0: &Settings) : u64 {
        arg0.max_balance
    }

    public fun max_per_day_cap(arg0: &Settings) : u64 {
        arg0.max_per_day_cap
    }

    public fun open<T0>(arg0: &Settings, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        assert!(v0 <= arg0.max_balance, 10);
        check_limits(arg0, arg3, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        check_expiry(v1, arg5);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = GiftBalance<T0>{
            id            : 0x2::object::new(arg7),
            owner         : v2,
            device_key    : 0x1::option::some<address>(arg2),
            funds         : 0x2::coin::into_balance<T0>(arg1),
            max_per_gift  : arg3,
            max_per_day   : arg4,
            day_start_ms  : v1,
            spent_today   : 0,
            expires_at_ms : arg5,
            total_sent    : 0,
        };
        let v4 = BalanceOpened{
            balance_id    : 0x2::object::id<GiftBalance<T0>>(&v3),
            owner         : v2,
            device_key    : arg2,
            amount        : v0,
            max_per_gift  : arg3,
            max_per_day   : arg4,
            expires_at_ms : arg5,
        };
        0x2::event::emit<BalanceOpened>(v4);
        0x2::transfer::share_object<GiftBalance<T0>>(v3);
    }

    public fun owner<T0>(arg0: &GiftBalance<T0>) : address {
        arg0.owner
    }

    public fun send_gift<T0>(arg0: &Settings, arg1: &mut GiftBalance<T0>, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>, arg7: &mut 0x8c1ae6083a2802691f445bc5005444298c34daf9d08ece020f51e88dafdcea4f::gift_payments::Config, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.registry_id) && *0x1::option::borrow<0x2::object::ID>(&arg0.registry_id) == 0x2::object::id<0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system::Registry<T0>>(arg6), 16);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        if (v0 != arg1.owner) {
            assert!(0x1::option::is_some<address>(&arg1.device_key) && *0x1::option::borrow<address>(&arg1.device_key) == v0, 2);
            assert!(v1 < arg1.expires_at_ms, 3);
        };
        assert!(arg2 > 0, 7);
        assert!(arg3 != arg1.owner, 8);
        assert!(arg3 != v0 && arg3 != @0x0, 17);
        assert!(arg2 <= arg1.max_per_gift, 4);
        if (v1 >= arg1.day_start_ms + 86400000) {
            arg1.day_start_ms = v1;
            arg1.spent_today = 0;
        };
        assert!(arg1.spent_today + arg2 <= arg1.max_per_day, 5);
        assert!(0x2::balance::value<T0>(&arg1.funds) >= arg2, 6);
        arg1.spent_today = arg1.spent_today + arg2;
        arg1.total_sent = arg1.total_sent + arg2;
        0x8c1ae6083a2802691f445bc5005444298c34daf9d08ece020f51e88dafdcea4f::gift_payments::send_gift<T0>(0x2::coin::take<T0>(&mut arg1.funds, arg2, arg9), arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = BalanceGiftSent{
            balance_id   : 0x2::object::id<GiftBalance<T0>>(arg1),
            coin_type    : check_coin<T0>(arg0),
            owner        : arg1.owner,
            signer       : v0,
            creator      : arg3,
            gift_id      : arg4,
            stream_id    : arg5,
            amount       : arg2,
            remaining    : 0x2::balance::value<T0>(&arg1.funds),
            spent_today  : arg1.spent_today,
            timestamp_ms : v1,
        };
        0x2::event::emit<BalanceGiftSent>(v2);
    }

    public fun set_device_key<T0>(arg0: &mut GiftBalance<T0>, arg1: 0x1::option::Option<address>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        if (0x1::option::is_some<address>(&arg1)) {
            check_expiry(0x2::clock::timestamp_ms(arg3), arg2);
            arg0.expires_at_ms = arg2;
        };
        arg0.device_key = arg1;
        let v0 = DeviceKeyChanged{
            balance_id    : 0x2::object::id<GiftBalance<T0>>(arg0),
            owner         : arg0.owner,
            device_key    : arg1,
            expires_at_ms : arg0.expires_at_ms,
        };
        0x2::event::emit<DeviceKeyChanged>(v0);
    }

    public fun set_limits<T0>(arg0: &Settings, arg1: &mut GiftBalance<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 1);
        check_limits(arg0, arg2, arg3);
        arg1.max_per_gift = arg2;
        arg1.max_per_day = arg3;
        let v0 = LimitsChanged{
            balance_id   : 0x2::object::id<GiftBalance<T0>>(arg1),
            owner        : arg1.owner,
            max_per_gift : arg2,
            max_per_day  : arg3,
        };
        0x2::event::emit<LimitsChanged>(v0);
    }

    public fun set_max_balance(arg0: &AdminCap, arg1: &mut Settings, arg2: u64) {
        assert!(arg2 > 0, 11);
        arg1.max_balance = arg2;
        emit_settings(arg1);
    }

    public fun set_max_per_day_cap(arg0: &AdminCap, arg1: &mut Settings, arg2: u64) {
        assert!(arg2 > 0, 11);
        arg1.max_per_day_cap = arg2;
        emit_settings(arg1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Settings, arg2: bool) {
        arg1.paused = arg2;
        emit_settings(arg1);
    }

    public fun spent_today<T0>(arg0: &GiftBalance<T0>) : u64 {
        arg0.spent_today
    }

    public fun top_up<T0>(arg0: &Settings, arg1: &mut GiftBalance<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 1);
        assert!(!arg0.paused, 9);
        check_coin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 7);
        assert!(0x2::balance::value<T0>(&arg1.funds) + v0 <= arg0.max_balance, 10);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg2));
        let v1 = BalanceToppedUp{
            balance_id  : 0x2::object::id<GiftBalance<T0>>(arg1),
            owner       : arg1.owner,
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg1.funds),
        };
        0x2::event::emit<BalanceToppedUp>(v1);
    }

    public fun total_sent<T0>(arg0: &GiftBalance<T0>) : u64 {
        arg0.total_sent
    }

    public fun withdraw<T0>(arg0: &mut GiftBalance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 > 0, 7);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg1, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funds, arg1, arg2), arg0.owner);
        let v0 = BalanceWithdrawn{
            balance_id  : 0x2::object::id<GiftBalance<T0>>(arg0),
            owner       : arg0.owner,
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.funds),
        };
        0x2::event::emit<BalanceWithdrawn>(v0);
    }

    public fun withdraw_all<T0>(arg0: &mut GiftBalance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.funds);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.funds, v0, arg1), arg0.owner);
        };
        arg0.device_key = 0x1::option::none<address>();
        let v1 = BalanceWithdrawn{
            balance_id  : 0x2::object::id<GiftBalance<T0>>(arg0),
            owner       : arg0.owner,
            amount      : v0,
            new_balance : 0,
        };
        0x2::event::emit<BalanceWithdrawn>(v1);
        let v2 = DeviceKeyChanged{
            balance_id    : 0x2::object::id<GiftBalance<T0>>(arg0),
            owner         : arg0.owner,
            device_key    : 0x1::option::none<address>(),
            expires_at_ms : arg0.expires_at_ms,
        };
        0x2::event::emit<DeviceKeyChanged>(v2);
    }

    // decompiled from Move bytecode v7
}

