module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_custody {
    struct CustodyWallet has store, key {
        id: 0x2::object::UID,
        circle_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        created_at: u64,
        locked_until: 0x1::option::Option<u64>,
        is_active: bool,
        daily_withdrawal_limit: u64,
        last_withdrawal_time: u64,
        daily_withdrawal_total: u64,
        transaction_history: vector<CustodyTransaction>,
    }

    struct CustodyTransaction has drop, store {
        operation_type: u8,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct StablecoinBalance has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        coin_type: 0x1::string::String,
        last_updated: u64,
    }

    struct CustodyWalletCreated has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        admin: address,
    }

    struct CustodyDeposited has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        member: address,
        amount: u64,
        operation_type: u8,
    }

    struct CustodyWithdrawn has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        operation_type: u8,
    }

    struct StablecoinHoldingUpdated has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        previous_balance: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct CoinDeposited has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
        member: address,
        previous_balance: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct StablecoinDepositWithPrice has copy, drop {
        circle_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
        usd_value: u64,
        member: address,
        timestamp: u64,
    }

    public fun check_withdrawal_limit(arg0: &CustodyWallet, arg1: u64) : bool {
        let v0 = if (arg0.last_withdrawal_time == 0) {
            1000000000000
        } else {
            arg0.last_withdrawal_time
        };
        v0 > arg0.last_withdrawal_time + 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day() && arg1 <= arg0.daily_withdrawal_limit || arg0.daily_withdrawal_total + arg1 <= arg0.daily_withdrawal_limit
    }

    fun coin_field_name<T0>() : 0x1::string::String {
        0x1::string::utf8(b"coin_objects")
    }

    public fun create_custody_wallet(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = CustodyWallet{
            id                     : 0x2::object::new(arg2),
            circle_id              : arg0,
            balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                  : v0,
            created_at             : arg1,
            locked_until           : 0x1::option::none<u64>(),
            is_active              : true,
            daily_withdrawal_limit : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::to_decimals(10000),
            last_withdrawal_time   : 0,
            daily_withdrawal_total : 0,
            transaction_history    : 0x1::vector::empty<CustodyTransaction>(),
        };
        0x2::transfer::share_object<CustodyWallet>(v1);
        let v2 = CustodyWalletCreated{
            circle_id : arg0,
            wallet_id : 0x2::object::uid_to_inner(&v1.id),
            admin     : v0,
        };
        0x2::event::emit<CustodyWalletCreated>(v2);
    }

    fun create_transaction(arg0: u8, arg1: address, arg2: u64, arg3: u64) : CustodyTransaction {
        CustodyTransaction{
            operation_type : arg0,
            user           : arg1,
            amount         : arg2,
            timestamp      : arg3,
        }
    }

    public fun deposit(arg0: &mut CustodyWallet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.is_active, 43);
        assert!(v0 == arg0.admin || is_authorized_depositor(arg0.circle_id, v0), 42);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_deposit(), v0, v1, 0x2::tx_context::epoch_timestamp_ms(arg2)));
        let v2 = CustodyDeposited{
            circle_id      : arg0.circle_id,
            wallet_id      : 0x2::object::uid_to_inner(&arg0.id),
            member         : v0,
            amount         : v1,
            operation_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_deposit(),
        };
        0x2::event::emit<CustodyDeposited>(v2);
    }

    public(friend) fun deposit_contribution_coin<T0>(arg0: &mut CustodyWallet, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.is_active, 43);
        let v2 = get_stablecoin_balance<T0>(arg0);
        let v3 = coin_field_name<T0>();
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3);
            0x2::coin::join<T0>(&mut v4, arg1);
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3, v4);
        } else {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3, arg1);
            register_stablecoin_type<T0>(arg0);
        };
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_deposit(), arg2, v0, v1));
        let v5 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0x1::string::utf8(b"sui")
        } else {
            0x1::string::utf8(b"stablecoin")
        };
        let v6 = CoinDeposited{
            circle_id        : arg0.circle_id,
            wallet_id        : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : v5,
            amount           : v0,
            member           : arg2,
            previous_balance : v2,
            new_balance      : get_stablecoin_balance<T0>(arg0),
            timestamp        : v1,
        };
        0x2::event::emit<CoinDeposited>(v6);
    }

    public fun get_admin(arg0: &CustodyWallet) : address {
        arg0.admin
    }

    public fun get_balance(arg0: &CustodyWallet) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::from_decimals(0x2::balance::value<0x2::sui::SUI>(&arg0.balance))
    }

    public fun get_circle_id(arg0: &CustodyWallet) : 0x2::object::ID {
        arg0.circle_id
    }

    public fun get_coin_decimals(arg0: &CustodyWallet, arg1: 0x1::string::String) : u8 {
        let v0 = 0x1::string::utf8(b"metadata_");
        0x1::string::append(&mut v0, arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            let v1 = *0x2::dynamic_field::borrow<0x1::string::String, vector<0x1::string::String>>(&arg0.id, v0);
            if (0x1::vector::length<0x1::string::String>(&v1) >= 2) {
                let v2 = *0x1::vector::borrow<0x1::string::String>(&v1, 1);
                if (0x1::string::length(&v2) > 0) {
                    let v3 = *0x1::string::bytes(&v2);
                    return ((*0x1::vector::borrow<u8>(&v3, 0) - 48) as u8)
                };
            };
        };
        9
    }

    public fun get_coin_type_path(arg0: &CustodyWallet, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"metadata_");
        0x1::string::append(&mut v0, arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            let v1 = *0x2::dynamic_field::borrow<0x1::string::String, vector<0x1::string::String>>(&arg0.id, v0);
            if (0x1::vector::length<0x1::string::String>(&v1) >= 3) {
                return *0x1::vector::borrow<0x1::string::String>(&v1, 2)
            };
        };
        0x1::string::utf8(b"")
    }

    public fun get_lock_time(arg0: &CustodyWallet) : u64 {
        if (0x1::option::is_some<u64>(&arg0.locked_until)) {
            *0x1::option::borrow<u64>(&arg0.locked_until)
        } else {
            0
        }
    }

    public fun get_raw_balance(arg0: &CustodyWallet) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_stablecoin_balance<T0>(arg0: &CustodyWallet) : u64 {
        let v0 = coin_field_name<T0>();
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return 0
        };
        0x2::coin::value<T0>(0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::coin::Coin<T0>>(&arg0.id, v0))
    }

    public fun get_supported_stablecoin_types(arg0: &CustodyWallet) : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b"registered_types");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x1::string::String, vector<0x1::string::String>>(&arg0.id, v0)
        } else {
            0x1::vector::empty<0x1::string::String>()
        }
    }

    public fun get_total_stablecoin_value_usd(arg0: &CustodyWallet) : u64 {
        get_supported_stablecoin_types(arg0);
        0
    }

    public fun get_total_wallet_balance(arg0: &CustodyWallet) : u64 {
        let v0 = coin_field_name<0x2::sui::SUI>();
        let v1 = if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x2::coin::value<0x2::sui::SUI>(0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.id, v0))
        } else {
            0
        };
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + v1
    }

    public fun get_wallet_balance(arg0: &CustodyWallet) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + get_stablecoin_balance<0x2::sui::SUI>(arg0)
    }

    public fun has_any_stablecoin_balance(arg0: &CustodyWallet) : bool {
        let v0 = get_supported_stablecoin_types(arg0);
        if (0x1::vector::length<0x1::string::String>(&v0) == 0) {
            return false
        };
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"coin_objects"))) {
            return true
        };
        if (get_stablecoin_balance<0x2::sui::SUI>(arg0) > 0) {
            return true
        };
        false
    }

    public fun has_stablecoin_balance<T0>(arg0: &CustodyWallet) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, coin_field_name<T0>())
    }

    public(friend) fun internal_store_security_deposit<T0>(arg0: &mut CustodyWallet, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg6);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.is_active, 43);
        let v2 = 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_price_validator::validate_stablecoin_deposit(arg4, v0, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg5, arg6);
        assert!(v2 >= arg3, 55);
        let v3 = get_stablecoin_balance<T0>(arg0);
        let v4 = coin_field_name<T0>();
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            let v5 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v4);
            0x2::coin::join<T0>(&mut v5, arg1);
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v4, v5);
        } else {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v4, arg1);
            register_stablecoin_type<T0>(arg0);
        };
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_stablecoin_deposit(), arg2, v0, v1));
        let v6 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0x1::string::utf8(b"sui")
        } else {
            0x1::string::utf8(b"stablecoin")
        };
        let v7 = CustodyDeposited{
            circle_id      : arg0.circle_id,
            wallet_id      : 0x2::object::uid_to_inner(&arg0.id),
            member         : arg2,
            amount         : v0,
            operation_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_stablecoin_deposit(),
        };
        0x2::event::emit<CustodyDeposited>(v7);
        let v8 = CoinDeposited{
            circle_id        : arg0.circle_id,
            wallet_id        : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : v6,
            amount           : v0,
            member           : arg2,
            previous_balance : v3,
            new_balance      : get_stablecoin_balance<T0>(arg0),
            timestamp        : v1,
        };
        0x2::event::emit<CoinDeposited>(v8);
        let v9 = StablecoinDepositWithPrice{
            circle_id : arg0.circle_id,
            wallet_id : 0x2::object::uid_to_inner(&arg0.id),
            coin_type : v6,
            amount    : v0,
            usd_value : v2,
            member    : arg2,
            timestamp : v1,
        };
        0x2::event::emit<StablecoinDepositWithPrice>(v9);
    }

    public(friend) fun internal_store_security_deposit_without_validation<T0>(arg0: &mut CustodyWallet, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.is_active, 43);
        let v2 = get_stablecoin_balance<T0>(arg0);
        let v3 = coin_field_name<T0>();
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3);
            0x2::coin::join<T0>(&mut v4, arg1);
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3, v4);
        } else {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v3, arg1);
            register_stablecoin_type<T0>(arg0);
        };
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_stablecoin_deposit(), arg2, v0, v1));
        let v5 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            0x1::string::utf8(b"sui")
        } else {
            0x1::string::utf8(b"stablecoin")
        };
        let v6 = CustodyDeposited{
            circle_id      : arg0.circle_id,
            wallet_id      : 0x2::object::uid_to_inner(&arg0.id),
            member         : arg2,
            amount         : v0,
            operation_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_stablecoin_deposit(),
        };
        0x2::event::emit<CustodyDeposited>(v6);
        let v7 = CoinDeposited{
            circle_id        : arg0.circle_id,
            wallet_id        : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : v5,
            amount           : v0,
            member           : arg2,
            previous_balance : v2,
            new_balance      : get_stablecoin_balance<T0>(arg0),
            timestamp        : v1,
        };
        0x2::event::emit<CoinDeposited>(v7);
    }

    fun is_authorized_depositor(arg0: 0x2::object::ID, arg1: address) : bool {
        true
    }

    public fun is_wallet_active(arg0: &CustodyWallet) : bool {
        arg0.is_active
    }

    public fun is_wallet_locked(arg0: &CustodyWallet) : bool {
        0x1::option::is_some<u64>(&arg0.locked_until)
    }

    public fun lock_wallet(arg0: &mut CustodyWallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 42);
        arg0.locked_until = 0x1::option::some<u64>(arg1);
    }

    fun register_stablecoin_type<T0>(arg0: &mut CustodyWallet) {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = 0x1::string::utf8(b"registered_types");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            let v2 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v2, v0);
            0x2::dynamic_field::add<0x1::string::String, vector<0x1::string::String>>(&mut arg0.id, v1, v2);
        } else {
            let v3 = 0x2::dynamic_field::borrow<0x1::string::String, vector<0x1::string::String>>(&arg0.id, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x1::string::String>(v3)) {
                if (0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(v3, v4)) == 0x1::string::bytes(&v0)) {
                    return
                };
                v4 = v4 + 1;
            };
            0x1::vector::push_back<0x1::string::String>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x1::string::String>>(&mut arg0.id, v1), v0);
        };
    }

    public fun unlock_wallet(arg0: &mut CustodyWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 42);
        arg0.locked_until = 0x1::option::none<u64>();
    }

    public fun validate_deposit_amount<T0>(arg0: u64, arg1: u64, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_price_validator::validate_stablecoin_deposit(arg2, arg0, arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()), arg3, arg4)
    }

    public fun withdraw(arg0: &mut CustodyWallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 == arg0.admin, 42);
        assert!(arg0.is_active, 43);
        if (0x1::option::is_some<u64>(&arg0.locked_until)) {
            assert!(v1 >= *0x1::option::borrow<u64>(&arg0.locked_until), 44);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 12);
        if (v1 > arg0.last_withdrawal_time + 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::ms_per_day()) {
            arg0.daily_withdrawal_total = arg1;
        } else {
            let v2 = arg0.daily_withdrawal_total + arg1;
            assert!(v2 <= arg0.daily_withdrawal_limit, 45);
            arg0.daily_withdrawal_total = v2;
        };
        arg0.last_withdrawal_time = v1;
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_withdrawal(), v0, arg1, v1));
        let v3 = CustodyWithdrawn{
            circle_id      : arg0.circle_id,
            wallet_id      : 0x2::object::uid_to_inner(&arg0.id),
            recipient      : v0,
            amount         : arg1,
            operation_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_withdrawal(),
        };
        0x2::event::emit<CustodyWithdrawn>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun withdraw_from_dynamic_fields(arg0: &mut CustodyWallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 == arg0.admin, 42);
        assert!(arg0.is_active, 43);
        if (0x1::option::is_some<u64>(&arg0.locked_until)) {
            assert!(v1 >= *0x1::option::borrow<u64>(&arg0.locked_until), 44);
        };
        let v2 = coin_field_name<0x2::sui::SUI>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v2), 50);
        let v3 = get_stablecoin_balance<0x2::sui::SUI>(arg0);
        assert!(v3 >= arg1, 12);
        let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v2);
        if (0x2::coin::value<0x2::sui::SUI>(&v4) > 0) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v2, v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
        };
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_withdrawal(), v0, arg1, v1));
        let v5 = CustodyWithdrawn{
            circle_id      : arg0.circle_id,
            wallet_id      : 0x2::object::uid_to_inner(&arg0.id),
            recipient      : v0,
            amount         : arg1,
            operation_type : 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_withdrawal(),
        };
        0x2::event::emit<CustodyWithdrawn>(v5);
        let v6 = CoinDeposited{
            circle_id        : arg0.circle_id,
            wallet_id        : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : 0x1::string::utf8(b"sui"),
            amount           : 0,
            member           : v0,
            previous_balance : v3,
            new_balance      : get_stablecoin_balance<0x2::sui::SUI>(arg0),
            timestamp        : v1,
        };
        0x2::event::emit<CoinDeposited>(v6);
        0x2::coin::split<0x2::sui::SUI>(&mut v4, arg1, arg2)
    }

    public fun withdraw_stablecoin<T0>(arg0: &mut CustodyWallet, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 == arg0.admin, 42);
        assert!(arg0.is_active, 43);
        if (0x1::option::is_some<u64>(&arg0.locked_until)) {
            assert!(v1 >= *0x1::option::borrow<u64>(&arg0.locked_until), 44);
        };
        let v2 = coin_field_name<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v2), 50);
        let v3 = get_stablecoin_balance<T0>(arg0);
        assert!(v3 >= arg1, 12);
        let v4 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v2);
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v2, v4);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        0x1::vector::push_back<CustodyTransaction>(&mut arg0.transaction_history, create_transaction(0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_core::custody_op_withdrawal(), v0, arg1, v1));
        let v5 = StablecoinHoldingUpdated{
            circle_id        : arg0.circle_id,
            wallet_id        : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : 0x1::string::utf8(b"stablecoin"),
            previous_balance : v3,
            new_balance      : get_stablecoin_balance<T0>(arg0),
            timestamp        : v1,
        };
        0x2::event::emit<StablecoinHoldingUpdated>(v5);
        0x2::coin::split<T0>(&mut v4, arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

