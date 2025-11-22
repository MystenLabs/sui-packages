module 0x581dadd4dda14ea304b2fbbd09f928a91c2b56bc3bac964ffda2a3de6685d3f4::sbt {
    struct Platform has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_locked_assets: u64,
        total_credits_issued: u64,
        total_users: u64,
    }

    struct LockedAsset has key {
        id: 0x2::object::UID,
        owner: address,
        asset_type: 0x1::string::String,
        asset_id: 0x1::option::Option<0x2::object::ID>,
        locked_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        lock_timestamp: u64,
        is_locked: bool,
        recovery_request: 0x1::option::Option<RecoveryRequest>,
    }

    struct RecoveryRequest has copy, drop, store {
        requested_at: u64,
        new_wallet: address,
        pin_hash: vector<u8>,
        admin_approved: bool,
    }

    struct UserAccount has key {
        id: 0x2::object::UID,
        owner: address,
        email_hash: vector<u8>,
        credits: u64,
        loyalty_points: u64,
        total_scans: u64,
        total_locks: u64,
        referral_code: 0x1::string::String,
        referred_by: 0x1::option::Option<address>,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AssetLocked has copy, drop {
        asset_id: 0x2::object::ID,
        owner: address,
        asset_type: 0x1::string::String,
        amount: u64,
        timestamp: u64,
    }

    struct AssetUnlocked has copy, drop {
        asset_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RecoveryRequested has copy, drop {
        asset_id: 0x2::object::ID,
        owner: address,
        new_wallet: address,
        timestamp: u64,
    }

    struct RecoveryApproved has copy, drop {
        asset_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct RecoveryCompleted has copy, drop {
        asset_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        credits_spent: u64,
    }

    struct CreditsPurchased has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount_paid: u64,
        credits_added: u64,
        loyalty_points_added: u64,
    }

    struct CreditsSpent has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        feature: 0x1::string::String,
        credits_spent: u64,
    }

    struct SecurityScanPerformed has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        scan_type: 0x1::string::String,
        credits_spent: u64,
        timestamp: u64,
    }

    struct UserReferred has copy, drop {
        referrer: address,
        new_user: address,
        points_awarded: u64,
    }

    public entry fun admin_approve_recovery(arg0: &AdminCap, arg1: &mut LockedAsset, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<RecoveryRequest>(&arg1.recovery_request), 8);
        0x1::option::borrow_mut<RecoveryRequest>(&mut arg1.recovery_request).admin_approved = true;
        let v0 = RecoveryApproved{
            asset_id  : 0x2::object::id<LockedAsset>(arg1),
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RecoveryApproved>(v0);
    }

    public entry fun complete_recovery(arg0: &mut UserAccount, arg1: LockedAsset, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.credits >= 10, 5);
        assert!(0x1::option::is_some<RecoveryRequest>(&arg1.recovery_request), 8);
        let v0 = 0x1::option::extract<RecoveryRequest>(&mut arg1.recovery_request);
        assert!(v0.admin_approved, 9);
        assert!(v0.pin_hash == arg2, 7);
        arg0.credits = arg0.credits - 10;
        arg0.loyalty_points = arg0.loyalty_points + 5;
        let LockedAsset {
            id               : v1,
            owner            : _,
            asset_type       : _,
            asset_id         : _,
            locked_balance   : v5,
            lock_timestamp   : _,
            is_locked        : _,
            recovery_request : _,
        } = arg1;
        let v9 = v1;
        let v10 = RecoveryCompleted{
            asset_id      : 0x2::object::uid_to_inner(&v9),
            old_owner     : arg1.owner,
            new_owner     : v0.new_wallet,
            credits_spent : 10,
        };
        0x2::event::emit<RecoveryCompleted>(v10);
        let v11 = CreditsSpent{
            account_id    : 0x2::object::id<UserAccount>(arg0),
            owner         : arg0.owner,
            feature       : 0x1::string::utf8(b"Recovery"),
            credits_spent : 10,
        };
        0x2::event::emit<CreditsSpent>(v11);
        0x2::object::delete(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3), v0.new_wallet);
    }

    public entry fun create_user_account(arg0: &mut Platform, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = UserAccount{
            id             : 0x2::object::new(arg5),
            owner          : 0x2::tx_context::sender(arg5),
            email_hash     : arg1,
            credits        : 0,
            loyalty_points : 0,
            total_scans    : 0,
            total_locks    : 0,
            referral_code  : arg2,
            referred_by    : arg3,
            created_at     : 0x2::clock::timestamp_ms(arg4),
        };
        arg0.total_users = arg0.total_users + 1;
        if (0x1::option::is_some<address>(&arg3)) {
            let v1 = UserReferred{
                referrer       : *0x1::option::borrow<address>(&arg3),
                new_user       : 0x2::tx_context::sender(arg5),
                points_awarded : 50,
            };
            0x2::event::emit<UserReferred>(v1);
        };
        0x2::transfer::transfer<UserAccount>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_user_account_simple(arg0: &mut Platform, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserAccount{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            email_hash     : 0x1::vector::empty<u8>(),
            credits        : 0,
            loyalty_points : 0,
            total_scans    : 0,
            total_locks    : 0,
            referral_code  : 0x1::string::utf8(b"AUTO_REF"),
            referred_by    : 0x1::option::none<address>(),
            created_at     : 0x2::clock::timestamp_ms(arg1),
        };
        arg0.total_users = arg0.total_users + 1;
        0x2::transfer::transfer<UserAccount>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_asset_balance(arg0: &LockedAsset) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance)
    }

    public fun get_loyalty_points(arg0: &UserAccount) : u64 {
        arg0.loyalty_points
    }

    public fun get_platform_stats(arg0: &Platform) : (u64, u64, u64) {
        (arg0.total_locked_assets, arg0.total_credits_issued, arg0.total_users)
    }

    public fun get_user_credits(arg0: &UserAccount) : u64 {
        arg0.credits
    }

    public fun has_recovery_request(arg0: &LockedAsset) : bool {
        0x1::option::is_some<RecoveryRequest>(&arg0.recovery_request)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Platform{
            id                   : 0x2::object::new(arg0),
            admin                : v0,
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_locked_assets  : 0,
            total_credits_issued : 0,
            total_users          : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Platform>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_asset_locked(arg0: &LockedAsset) : bool {
        arg0.is_locked
    }

    public entry fun lock_sui_asset(arg0: &mut Platform, arg1: &mut UserAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = LockedAsset{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            asset_type       : 0x1::string::utf8(b"SUI"),
            asset_id         : 0x1::option::none<0x2::object::ID>(),
            locked_balance   : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            lock_timestamp   : 0x2::clock::timestamp_ms(arg3),
            is_locked        : true,
            recovery_request : 0x1::option::none<RecoveryRequest>(),
        };
        arg0.total_locked_assets = arg0.total_locked_assets + 1;
        arg1.total_locks = arg1.total_locks + 1;
        let v2 = AssetLocked{
            asset_id   : 0x2::object::id<LockedAsset>(&v1),
            owner      : 0x2::tx_context::sender(arg4),
            asset_type : 0x1::string::utf8(b"SUI"),
            amount     : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AssetLocked>(v2);
        0x2::transfer::transfer<LockedAsset>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun perform_phishing_scan(arg0: &mut UserAccount, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.credits >= 2, 5);
        arg0.credits = arg0.credits - 2;
        arg0.total_scans = arg0.total_scans + 1;
        arg0.loyalty_points = arg0.loyalty_points + 5;
        let v0 = SecurityScanPerformed{
            account_id    : 0x2::object::id<UserAccount>(arg0),
            owner         : arg0.owner,
            scan_type     : 0x1::string::utf8(b"Phishing Detection"),
            credits_spent : 2,
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SecurityScanPerformed>(v0);
        let v1 = CreditsSpent{
            account_id    : 0x2::object::id<UserAccount>(arg0),
            owner         : arg0.owner,
            feature       : 0x1::string::utf8(b"Phishing Scan"),
            credits_spent : 2,
        };
        0x2::event::emit<CreditsSpent>(v1);
    }

    public entry fun perform_security_scan(arg0: &mut UserAccount, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.credits >= 3, 5);
        arg0.credits = arg0.credits - 3;
        arg0.total_scans = arg0.total_scans + 1;
        arg0.loyalty_points = arg0.loyalty_points + 5;
        let v0 = SecurityScanPerformed{
            account_id    : 0x2::object::id<UserAccount>(arg0),
            owner         : arg0.owner,
            scan_type     : arg1,
            credits_spent : 3,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SecurityScanPerformed>(v0);
        let v1 = CreditsSpent{
            account_id    : 0x2::object::id<UserAccount>(arg0),
            owner         : arg0.owner,
            feature       : 0x1::string::utf8(b"Security Scan"),
            credits_spent : 3,
        };
        0x2::event::emit<CreditsSpent>(v1);
    }

    public entry fun purchase_credits_150(arg0: &mut Platform, arg1: &mut UserAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        purchase_credits_internal(arg0, arg1, arg2, 150, 50000000, arg3);
    }

    public entry fun purchase_credits_50(arg0: &mut Platform, arg1: &mut UserAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        purchase_credits_internal(arg0, arg1, arg2, 50, 10000000, arg3);
    }

    public entry fun purchase_credits_500(arg0: &mut Platform, arg1: &mut UserAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        purchase_credits_internal(arg0, arg1, arg2, 500, 100000000, arg3);
    }

    fun purchase_credits_internal(arg0: &mut Platform, arg1: &mut UserAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg4, 6);
        arg1.credits = arg1.credits + arg3;
        let v1 = arg3 * 1;
        arg1.loyalty_points = arg1.loyalty_points + v1;
        arg0.total_credits_issued = arg0.total_credits_issued + arg3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = CreditsPurchased{
            account_id           : 0x2::object::id<UserAccount>(arg1),
            owner                : arg1.owner,
            amount_paid          : v0,
            credits_added        : arg3,
            loyalty_points_added : v1,
        };
        0x2::event::emit<CreditsPurchased>(v2);
    }

    public entry fun request_recovery(arg0: &mut LockedAsset, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.is_locked, 3);
        let v0 = RecoveryRequest{
            requested_at   : 0x2::clock::timestamp_ms(arg3),
            new_wallet     : arg1,
            pin_hash       : arg2,
            admin_approved : false,
        };
        arg0.recovery_request = 0x1::option::some<RecoveryRequest>(v0);
        let v1 = RecoveryRequested{
            asset_id   : 0x2::object::id<LockedAsset>(arg0),
            owner      : arg0.owner,
            new_wallet : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RecoveryRequested>(v1);
    }

    public entry fun unlock_asset(arg0: &mut LockedAsset, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.is_locked, 3);
        assert!(0x1::option::is_none<RecoveryRequest>(&arg0.recovery_request), 8);
        arg0.is_locked = false;
        let v0 = AssetUnlocked{
            asset_id  : 0x2::object::id<LockedAsset>(arg0),
            owner     : arg0.owner,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&arg0.locked_balance),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AssetUnlocked>(v0);
    }

    public entry fun update_admin(arg0: &AdminCap, arg1: &mut Platform, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg4), arg3);
    }

    public entry fun withdraw_unlocked_asset(arg0: LockedAsset, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        assert!(!arg0.is_locked, 10);
        let LockedAsset {
            id               : v0,
            owner            : v1,
            asset_type       : _,
            asset_id         : _,
            locked_balance   : v4,
            lock_timestamp   : _,
            is_locked        : _,
            recovery_request : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1), v1);
    }

    // decompiled from Move bytecode v6
}

