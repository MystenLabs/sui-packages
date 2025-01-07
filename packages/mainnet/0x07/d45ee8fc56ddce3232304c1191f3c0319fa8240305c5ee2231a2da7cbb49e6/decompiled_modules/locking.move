module 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LockUpManager has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        treasury_manager: address,
        extra_treasury: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        lock_infos: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, LockInfo>,
        type_name: 0x1::type_name::TypeName,
        min_lock_day: u64,
        max_lock_day: u64,
        min_percent_numerator: u64,
        max_percent_numerator: u64,
        package_version: u64,
    }

    struct LockInfo has drop, store {
        venft_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        xcetus_amount: u64,
        cetus_amount: u64,
    }

    struct InitEvent has copy, drop, store {
        admin_id: 0x2::object::ID,
        publisher_id: 0x2::object::ID,
        display_id: 0x2::object::ID,
    }

    struct InitializeEvent has copy, drop, store {
        min_lock_day: u64,
        max_lock_day: u64,
        min_percent_numerator: u64,
        max_percent_numerator: u64,
        lock_manager: 0x2::object::ID,
        cetus_type: 0x1::type_name::TypeName,
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
        cetus_amount: u64,
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
        cetus_amount: u64,
        xcetus_amount: u64,
    }

    struct RedeemAllEvent has copy, drop, store {
        lock_manager: 0x2::object::ID,
        receiver: address,
        amount: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct LOCKING has drop {
        dummy_field: bool,
    }

    public entry fun approve_transfer_venft(arg0: &LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::approve_transfer_venft(arg1, arg2, arg3, arg4);
    }

    public fun cancel_redeem_lock(arg0: &mut LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        checked_package_version(arg0);
        assert!(0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::lock_time<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg3) > 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg4), 5);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, LockInfo>(&arg0.lock_infos, 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&arg3));
        assert!(v0.venft_id == 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg2), 4);
        assert!(0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg3) == v0.cetus_amount, 4);
        let (v1, v2) = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::destory_lock<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg3);
        assert!(v2 == v0.lock_id, 4);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::update_unlocked(arg1, arg2, v0.xcetus_amount);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, LockInfo>(&mut arg0.lock_infos, v0.lock_id);
        receive(arg0, v1);
        let v3 = CancelRedeemEvent{
            lock_manager : 0x2::object::id<LockUpManager>(arg0),
            venft_id     : v0.venft_id,
            locked_coin  : v2,
        };
        0x2::event::emit<CancelRedeemEvent>(v3);
    }

    public entry fun cancel_transfer_venft_request_by_admin(arg0: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::AdminCap, arg1: &LockUpManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg3: 0x2::object::ID) {
        checked_package_version(arg1);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::cancel_transfer_venft_request_by_admin(arg0, arg2, arg3);
    }

    public fun checked_package_version(arg0: &LockUpManager) {
        assert!(arg0.package_version <= 2, 8);
    }

    public fun convert(arg0: &mut LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::merge_coins<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg5);
        if (0x2::coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v0) == 0) {
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v0);
            return
        };
        receive(arg0, 0x2::coin::into_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::coin::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v0, arg3, arg5)));
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::mint(arg1, arg4, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(v0, 0x2::tx_context::sender(arg5));
        let v1 = ConvertEvent{
            venft_id     : 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg4),
            amount       : arg3,
            lock_manager : 0x2::object::id<LockUpManager>(arg0),
        };
        0x2::event::emit<ConvertEvent>(v1);
    }

    fun init(arg0: LOCKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Cetus veNFT #{index}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://x77unmxbojk6nincdlzd57hhk5qgp5223rrrxrsplqqcs23vu5ja.arweave.net/v_9GsuFyVeahohryPvznV2Bn91rcYxvGT1wgKWt1p1I"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A non-transferrable NFT storing Cetus Escrowed Token xCETUS that represents a user's governance power on Cetus Protocol."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Cetus"));
        let v5 = 0x2::package::claim<LOCKING>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>>(v6, 0x2::tx_context::sender(arg1));
        initialize(15, 180, 500, 1000, arg1);
        let v7 = InitEvent{
            admin_id     : 0x2::object::id<AdminCap>(&v0),
            publisher_id : 0x2::object::id<0x2::package::Publisher>(&v5),
            display_id   : 0x2::object::id<0x2::package::Publisher>(&v5),
        };
        0x2::event::emit<InitEvent>(v7);
    }

    fun initialize(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 < (1000 as u64)) {
            if (arg3 <= (1000 as u64)) {
                arg2 < arg3 && arg0 < arg1 || arg2 == arg3 && arg0 == arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = LockUpManager{
            id                    : 0x2::object::new(arg4),
            balance               : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            treasury_manager      : @0x1,
            extra_treasury        : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            lock_infos            : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, LockInfo>(arg4),
            type_name             : 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            min_lock_day          : arg0,
            max_lock_day          : arg1,
            min_percent_numerator : arg2,
            max_percent_numerator : arg3,
            package_version       : 1,
        };
        let v2 = InitializeEvent{
            min_lock_day          : arg0,
            max_lock_day          : arg1,
            min_percent_numerator : arg2,
            max_percent_numerator : arg3,
            lock_manager          : 0x2::object::id<LockUpManager>(&v1),
            cetus_type            : 0x1::type_name::get<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
        };
        0x2::event::emit<InitializeEvent>(v2);
        0x2::transfer::share_object<LockUpManager>(v1);
    }

    public fun mint_and_convert(arg0: &mut LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::mint_venft_object(arg1, arg4);
        let v1 = &mut v0;
        convert(arg0, arg1, arg2, arg3, v1, arg4);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::transfer_venft(v0, arg4);
    }

    fun receive(arg0: &mut LockUpManager, arg1: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>) {
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.balance, arg1);
    }

    fun receive_treasury(arg0: &mut LockUpManager, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = take(arg0, arg1);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.extra_treasury, v0);
    }

    public fun redeem(arg0: &mut LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, LockInfo>(&arg0.lock_infos, 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(&arg3));
        assert!(v0.venft_id == 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg2), 4);
        assert!(0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg3) == v0.cetus_amount, 4);
        let v1 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::unlock_coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg3, arg4, arg5);
        assert!(v1 == v0.lock_id, 4);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::update_unlocked(arg1, arg2, v0.xcetus_amount);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::burn(arg1, arg2, v0.xcetus_amount, arg5);
        let v2 = v0.cetus_amount;
        let v3 = v0.xcetus_amount;
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, LockInfo>(&mut arg0.lock_infos, v0.lock_id);
        receive_treasury(arg0, v3 - v2);
        let v4 = RedeemEvent{
            lock_manager  : 0x2::object::id<LockUpManager>(arg0),
            venft_id      : v0.venft_id,
            locked_coin   : v1,
            cetus_amount  : v2,
            xcetus_amount : v3,
        };
        0x2::event::emit<RedeemEvent>(v4);
    }

    public fun redeem_lock(arg0: &mut LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(arg3 <= 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::available_value(arg1, arg2), 1);
        assert!(arg4 >= arg0.min_lock_day && arg4 <= arg0.max_lock_day, 2);
        let v0 = redeem_num(arg0.min_lock_day, arg0.max_lock_day, arg0.min_percent_numerator, arg0.max_percent_numerator, arg4, arg3);
        assert!(v0 <= arg3, 3);
        let v1 = take(arg0, v0);
        let v2 = 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::lock_coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v1, arg6), 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg5), 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::utils::now_timestamp(arg5) + arg4 * 86400, 0x2::tx_context::sender(arg6), arg6);
        let v3 = 0x2::object::id<0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT>(arg2);
        let v4 = LockInfo{
            venft_id      : v3,
            lock_id       : v2,
            xcetus_amount : arg3,
            cetus_amount  : v0,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, LockInfo>(&mut arg0.lock_infos, v2, v4);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::update_locked(arg1, arg2, arg3);
        let v5 = RedeemLockEvent{
            lock_manager : 0x2::object::id<LockUpManager>(arg0),
            venft_id     : v3,
            amount       : arg3,
            lock_day     : arg4,
            cetus_amount : v0,
        };
        0x2::event::emit<RedeemLockEvent>(v5);
    }

    fun redeem_num(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg1 == arg0) {
            (((arg2 as u128) * (arg5 as u128) / 1000) as u64)
        } else {
            (((100000000000 * (arg3 as u128) - 100000000000 * ((arg1 - arg4) as u128) * ((arg3 - arg2) as u128) / ((arg1 - arg0) as u128)) * (arg5 as u128) / 1000 / 100000000000) as u64)
        }
    }

    public entry fun redeem_treasury(arg0: &mut LockUpManager, arg1: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(arg0.treasury_manager == 0x2::tx_context::sender(arg1), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(take_treasury(arg0), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun request_transfer_venft_by_admin(arg0: &0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::AdminCap, arg1: &LockUpManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg3: 0x2::object::ID, arg4: address) {
        checked_package_version(arg1);
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::request_transfer_venft_by_admin(arg0, arg2, arg3, arg4);
    }

    fun take(arg0: &mut LockUpManager, arg1: u64) : 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.balance, arg1)
    }

    fun take_treasury(arg0: &mut LockUpManager) : 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.extra_treasury)
    }

    public entry fun update_package_version<T0>(arg0: &AdminCap, arg1: &mut LockUpManager, arg2: u64) {
        checked_package_version(arg1);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public entry fun update_treasury_manager(arg0: &AdminCap, arg1: &mut LockUpManager, arg2: address) {
        checked_package_version(arg1);
        arg1.treasury_manager = arg2;
    }

    // decompiled from Move bytecode v6
}

