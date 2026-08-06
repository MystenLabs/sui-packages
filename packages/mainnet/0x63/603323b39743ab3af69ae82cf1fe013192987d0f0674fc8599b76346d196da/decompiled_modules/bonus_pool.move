module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::bonus_pool {
    struct BonusPool has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        signer: address,
        vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        claimed: 0x2::table::Table<address, bool>,
        paused: bool,
        total_granted: u64,
    }

    struct ClaimEnvelope has copy, drop, store {
        domain: vector<u8>,
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        expiry_ms: u64,
    }

    struct UnlockEnvelope has copy, drop, store {
        domain: vector<u8>,
        pool_id: 0x2::object::ID,
        user: address,
        expiry_ms: u64,
    }

    struct BonusGranted has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        account_id: 0x2::object::ID,
        amount: u64,
        remaining_budget: u64,
    }

    struct BonusUnlocked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        account_id: 0x2::object::ID,
    }

    struct BonusRevoked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        account_id: 0x2::object::ID,
        reclaimed: u64,
    }

    public fun admin(arg0: &BonusPool) : address {
        arg0.admin
    }

    public fun admin_withdraw(arg0: &mut BonusPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 504);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>>(0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.vault, arg1), arg3), arg2);
    }

    public fun claim_bonus_into_account(arg0: &mut BonusPool, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: u64, arg3: u64, arg4: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 502);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 503);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::owner(arg1) == v0, 505);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 501);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::verify_signature_message(arg4, arg0.signer, claim_message(arg0, v0, arg2, arg3));
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_yoso_as_deposit(arg1, 0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.vault, arg2), arg6));
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::apply_bonus_lock(arg1, arg2);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.total_granted = arg0.total_granted + arg2;
        let v1 = BonusGranted{
            pool_id          : 0x2::object::id<BonusPool>(arg0),
            user             : v0,
            account_id       : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1),
            amount           : arg2,
            remaining_budget : 0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.vault),
        };
        0x2::event::emit<BonusGranted>(v1);
    }

    public fun claim_message(arg0: &BonusPool, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = ClaimEnvelope{
            domain    : b"YOSO_BONUS_CLAIM_V1",
            pool_id   : 0x2::object::id<BonusPool>(arg0),
            user      : arg1,
            amount    : arg2,
            expiry_ms : arg3,
        };
        0x2::bcs::to_bytes<ClaimEnvelope>(&v0)
    }

    public fun fund(arg0: &mut BonusPool, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
    }

    public fun granted_account_id(arg0: &BonusGranted) : 0x2::object::ID {
        arg0.account_id
    }

    public fun granted_amount(arg0: &BonusGranted) : u64 {
        arg0.amount
    }

    public fun granted_remaining_budget(arg0: &BonusGranted) : u64 {
        arg0.remaining_budget
    }

    public fun granted_user(arg0: &BonusGranted) : address {
        arg0.user
    }

    public fun has_claimed(arg0: &BonusPool, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun init_account_with_bonus(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccountRegistry, arg1: &mut BonusPool, arg2: u64, arg3: u64, arg4: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::create_registered_account(arg0, arg6);
        let v1 = &mut v0;
        claim_bonus_into_account(arg1, v1, arg2, arg3, arg4, arg5, arg6);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::share_account(v0);
    }

    public fun init_bonus_pool(arg0: &0x2::package::UpgradeCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BonusPool{
            id            : 0x2::object::new(arg3),
            version       : 1,
            admin         : arg1,
            signer        : arg2,
            vault         : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            claimed       : 0x2::table::new<address, bool>(arg3),
            paused        : false,
            total_granted : 0,
        };
        0x2::transfer::share_object<BonusPool>(v0);
    }

    public fun revoke_bonus(arg0: &mut BonusPool, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 504);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::locked_yoso(arg1);
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::yoso_balance(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        if (v2 > 0) {
            0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_yoso(arg1, v2, arg2)));
            arg0.total_granted = arg0.total_granted - v2;
        };
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::clear_bonus_lock(arg1);
        let v3 = BonusRevoked{
            pool_id    : 0x2::object::id<BonusPool>(arg0),
            user       : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::owner(arg1),
            account_id : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1),
            reclaimed  : v2,
        };
        0x2::event::emit<BonusRevoked>(v3);
    }

    public fun set_admin(arg0: &mut BonusPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 504);
        arg0.admin = arg1;
    }

    public fun set_paused(arg0: &mut BonusPool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 504);
        arg0.paused = arg1;
    }

    public fun set_signer(arg0: &mut BonusPool, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 504);
        arg0.signer = arg1;
    }

    public fun unlock_bonus(arg0: &BonusPool, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: u64, arg3: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 503);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::owner(arg1) == v0, 505);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::verify_signature_message(arg3, arg0.signer, unlock_message(arg0, v0, arg2));
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::clear_bonus_lock(arg1);
        let v1 = BonusUnlocked{
            pool_id    : 0x2::object::id<BonusPool>(arg0),
            user       : v0,
            account_id : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1),
        };
        0x2::event::emit<BonusUnlocked>(v1);
    }

    public fun unlock_message(arg0: &BonusPool, arg1: address, arg2: u64) : vector<u8> {
        let v0 = UnlockEnvelope{
            domain    : b"YOSO_BONUS_UNLOCK_V1",
            pool_id   : 0x2::object::id<BonusPool>(arg0),
            user      : arg1,
            expiry_ms : arg2,
        };
        0x2::bcs::to_bytes<UnlockEnvelope>(&v0)
    }

    public fun vault_balance(arg0: &BonusPool) : u64 {
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.vault)
    }

    // decompiled from Move bytecode v7
}

