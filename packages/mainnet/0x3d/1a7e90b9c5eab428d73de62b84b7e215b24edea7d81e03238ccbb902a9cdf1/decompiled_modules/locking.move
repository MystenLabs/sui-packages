module 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking {
    struct LockUpManager has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>,
        extra_treasury: 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>,
        lock_infos: 0x2::linked_table::LinkedTable<0x2::object::ID, LockInfo>,
        type_name: 0x1::type_name::TypeName,
        min_lock_day: u64,
        max_lock_day: u64,
        min_percent_numerator: u64,
        max_percent_numerator: u64,
    }

    struct LockInfo has drop, store {
        venft_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        xturbos_amount: u64,
        turbos_amount: u64,
    }

    struct InitEvent has copy, drop, store {
        publisher_id: 0x2::object::ID,
        display_id: 0x2::object::ID,
    }

    struct InitializeEvent has copy, drop, store {
        min_lock_day: u64,
        max_lock_day: u64,
        min_percent_numerator: u64,
        max_percent_numerator: u64,
        lock_manager: 0x2::object::ID,
        turbos_type: 0x1::type_name::TypeName,
    }

    struct ConvertEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        amount: u64,
        lock_manager: 0x2::object::ID,
    }

    struct RedeemLockEvent has copy, drop, store {
        lock_manager: 0x2::object::ID,
        venft_id: 0x2::object::ID,
        amount: u64,
        lock_day: u64,
        turbos_amount: u64,
    }

    struct CancelRedeemEvent has copy, drop, store {
        lock_manager: 0x2::object::ID,
        venft_id: 0x2::object::ID,
        locked_coin: 0x2::object::ID,
    }

    struct RedeemEvent has copy, drop, store {
        lock_manager: 0x2::object::ID,
        venft_id: 0x2::object::ID,
        locked_coin: 0x2::object::ID,
        turbos_amount: u64,
        xturbos_amount: u64,
    }

    struct LockInfoEvent has copy, drop, store {
        venft_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        xturbos_amount: u64,
        turbos_amount: u64,
    }

    struct LOCKING has drop {
        dummy_field: bool,
    }

    public fun checked_package_version(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
    }

    public fun approve_transfer_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg2: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::approve_transfer_venft(arg0, arg1, arg2, arg3, arg4);
    }

    public fun cancel_redeem_lock(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>, arg5: &0x2::clock::Clock) {
        checked_package_version(arg0);
        assert!(0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::lock_time<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, &arg4) > 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg5), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::coin_in_lock_period());
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, LockInfo>(&arg1.lock_infos, 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(&arg4));
        assert!(v0.venft_id == 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::lock_info_mismatch());
        assert!(0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, &arg4) == v0.turbos_amount, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::lock_info_mismatch());
        let v1 = v0.lock_id;
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::update_unlocked(arg0, arg2, arg3, v0.xturbos_amount);
        let (v2, v3) = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::destory_lock<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, arg4);
        assert!(v3 == v1, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::lock_info_mismatch());
        0x2::linked_table::remove<0x2::object::ID, LockInfo>(&mut arg1.lock_infos, v1);
        receive(arg1, v2);
        let v4 = CancelRedeemEvent{
            lock_manager : 0x2::object::id<LockUpManager>(arg1),
            venft_id     : v0.venft_id,
            locked_coin  : v3,
        };
        0x2::event::emit<CancelRedeemEvent>(v4);
    }

    public fun cancel_transfer_venft_request_by_admin(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_locking_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::cancel_transfer_venft_request_by_admin(arg0, arg1, arg2);
    }

    public fun convert(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: vector<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>, arg4: u64, arg5: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        checked_package_version(arg0);
        let v0 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::merge_coins<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg3, arg6);
        if (0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v0) == 0) {
            return v0
        };
        assert!(0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v0) >= arg4, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        receive(arg1, 0x2::coin::into_balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(0x2::coin::split<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&mut v0, arg4, arg6)));
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::mint(arg0, arg2, arg5, arg4);
        let v1 = ConvertEvent{
            venft_id     : 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg5),
            amount       : arg4,
            lock_manager : 0x2::object::id<LockUpManager>(arg1),
        };
        0x2::event::emit<ConvertEvent>(v1);
        v0
    }

    public fun fetch_lock_info(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &LockUpManager, arg2: 0x2::object::ID) {
        checked_package_version(arg0);
        if (!0x2::linked_table::contains<0x2::object::ID, LockInfo>(&arg1.lock_infos, arg2)) {
            return
        };
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, LockInfo>(&arg1.lock_infos, arg2);
        let v1 = LockInfoEvent{
            venft_id       : arg2,
            lock_id        : v0.lock_id,
            xturbos_amount : v0.xturbos_amount,
            turbos_amount  : v0.turbos_amount,
        };
        0x2::event::emit<LockInfoEvent>(v1);
    }

    fun init(arg0: LOCKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Turbos veNFT #{index}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.turbos.finance"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.turbos.finance/Turbos_nft.png"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"A non-transferrable NFT storing Turbos Escrowed Token xTURBOS that represents a user's governance power on Turbos Protocol."));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://app.turbos.finance"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Turbos"));
        let v2 = 0x2::package::claim<LOCKING>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(&v2, v0, v1, arg1);
        0x2::display::update_version<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>>(v3, 0x2::tx_context::sender(arg1));
        initialize(15, 180, 500, 1000, arg1);
        let v4 = InitEvent{
            publisher_id : 0x2::object::id<0x2::package::Publisher>(&v2),
            display_id   : 0x2::object::id<0x2::display::Display<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>>(&v3),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    fun initialize(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 < 1000 && arg3 <= 1000;
        let v1 = arg2 < arg3 && arg0 < arg1;
        let v2 = arg2 == arg3 && arg0 == arg1;
        assert!(v0 && (v1 || v2), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_lock_params());
        let v3 = LockUpManager{
            id                    : 0x2::object::new(arg4),
            balance               : 0x2::balance::zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(),
            extra_treasury        : 0x2::balance::zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(),
            lock_infos            : 0x2::linked_table::new<0x2::object::ID, LockInfo>(arg4),
            type_name             : 0x1::type_name::with_defining_ids<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(),
            min_lock_day          : arg0,
            max_lock_day          : arg1,
            min_percent_numerator : arg2,
            max_percent_numerator : arg3,
        };
        let v4 = InitializeEvent{
            min_lock_day          : arg0,
            max_lock_day          : arg1,
            min_percent_numerator : arg2,
            max_percent_numerator : arg3,
            lock_manager          : 0x2::object::id<LockUpManager>(&v3),
            turbos_type           : 0x1::type_name::with_defining_ids<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(),
        };
        0x2::event::emit<InitializeEvent>(v4);
        0x2::transfer::share_object<LockUpManager>(v3);
    }

    public fun mint_and_convert(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: vector<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        checked_package_version(arg0);
        let v0 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::mint_venft(arg0, arg2, arg5);
        let v1 = &mut v0;
        let v2 = convert(arg0, arg1, arg2, arg3, arg4, v1, arg5);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::transfer_venft(arg0, v0, arg5);
        v2
    }

    fun receive(arg0: &mut LockUpManager, arg1: 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>) {
        0x2::balance::join<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&mut arg0.balance, arg1);
    }

    fun receive_treasury(arg0: &mut LockUpManager, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = take(arg0, arg1);
        0x2::balance::join<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&mut arg0.extra_treasury, v0);
    }

    public fun redeem(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        checked_package_version(arg0);
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, LockInfo>(&arg1.lock_infos, 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(&arg4));
        assert!(v0.venft_id == 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::lock_info_mismatch());
        assert!(0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, &arg4) == v0.turbos_amount, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::lock_info_mismatch());
        let v1 = v0.lock_id;
        let v2 = v0.turbos_amount;
        let v3 = v0.xturbos_amount;
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::update_unlocked(arg0, arg2, arg3, v3);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::burn(arg0, arg2, arg3, v3, arg6);
        0x2::linked_table::remove<0x2::object::ID, LockInfo>(&mut arg1.lock_infos, v1);
        receive_treasury(arg1, v3 - v2);
        let v4 = RedeemEvent{
            lock_manager   : 0x2::object::id<LockUpManager>(arg1),
            venft_id       : v0.venft_id,
            locked_coin    : v1,
            turbos_amount  : v2,
            xturbos_amount : v3,
        };
        0x2::event::emit<RedeemEvent>(v4);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::unlock_coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, arg4, arg5, arg6)
    }

    public fun redeem_lock(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(arg4 > 0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_xturbos_amount());
        assert!(arg4 <= 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::available_value(arg0, arg2, arg3), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_xturbos_amount());
        assert!(arg5 >= arg1.min_lock_day && arg5 <= arg1.max_lock_day, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::invalid_lock_day());
        let v0 = redeem_num(arg1.min_lock_day, arg1.max_lock_day, arg1.min_percent_numerator, arg1.max_percent_numerator, arg5, arg4);
        assert!(v0 <= arg4, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::xturbos_exceeds_turbos());
        assert!(0x2::balance::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&arg1.balance) >= v0, 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::error::insufficient_balance());
        let v1 = take(arg1, v0);
        let v2 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::lock_coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(arg0, 0x2::coin::from_balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(v1, arg7), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg6), 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::utils::now_timestamp(arg6) + arg5 * 60, 0x2::tx_context::sender(arg7), arg6, arg7);
        let v3 = 0x2::object::id<0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT>(arg3);
        let v4 = LockInfo{
            venft_id       : v3,
            lock_id        : v2,
            xturbos_amount : arg4,
            turbos_amount  : v0,
        };
        0x2::linked_table::push_back<0x2::object::ID, LockInfo>(&mut arg1.lock_infos, v2, v4);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::update_locked(arg0, arg2, arg3, arg4);
        let v5 = RedeemLockEvent{
            lock_manager  : 0x2::object::id<LockUpManager>(arg1),
            venft_id      : v3,
            amount        : arg4,
            lock_day      : arg5,
            turbos_amount : v0,
        };
        0x2::event::emit<RedeemLockEvent>(v5);
    }

    fun redeem_num(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg4 < 15) {
            arg2
        } else if (arg4 >= 15 && arg4 < 30) {
            900 + (arg4 - 15) * 50 / 15
        } else if (arg4 >= 30 && arg4 < 90) {
            950 + (arg4 - 30) * 35 / 60
        } else if (arg4 >= 90 && arg4 < 180) {
            985 + (arg4 - 90) * 15 / 90
        } else {
            1000
        };
        (((v0 as u128) * (arg5 as u128) / 1000) as u64)
    }

    public fun redeem_treasury(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut LockUpManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_locking_manager_role(arg0, 0x2::tx_context::sender(arg2));
        take_treasury(arg1)
    }

    public fun request_transfer_venft_by_admin(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::check_locking_manager_role(arg0, 0x2::tx_context::sender(arg4));
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::request_transfer_venft_by_admin(arg0, arg1, arg2, arg3);
    }

    fun take(arg0: &mut LockUpManager, arg1: u64) : 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        0x2::balance::split<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&mut arg0.balance, arg1)
    }

    fun take_treasury(arg0: &mut LockUpManager) : 0x2::balance::Balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS> {
        0x2::balance::withdraw_all<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&mut arg0.extra_treasury)
    }

    // decompiled from Move bytecode v6
}

