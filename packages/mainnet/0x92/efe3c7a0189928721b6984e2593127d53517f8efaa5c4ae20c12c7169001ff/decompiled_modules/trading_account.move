module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account {
    struct ShareKey has copy, drop, store {
        market_id: u64,
        market_object_id: 0x2::object::ID,
        outcome: u8,
    }

    struct TradingAccount has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        yoso_vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        shares: 0x2::table::Table<ShareKey, u64>,
    }

    struct TradingAccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct YosoDeposited has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct YosoWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct OutcomeDeposited has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        outcome: u8,
        amount: u64,
    }

    struct OutcomeWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        outcome: u8,
        amount: u64,
    }

    struct AccountWinningsRedeemed has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        outcome: u8,
        shares_burned: u64,
        yoso_credited: u64,
    }

    struct AccountInvalidProceedsClaimed has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        market_id: u64,
        outcome: u8,
        shares_burned: u64,
        yoso_credited: u64,
    }

    public fun id(arg0: &TradingAccount) : 0x2::object::ID {
        assert_version(arg0);
        0x2::object::id<TradingAccount>(arg0)
    }

    fun assert_owner(arg0: &TradingAccount, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    public(friend) fun assert_owner_address(arg0: &TradingAccount, arg1: address) {
        assert_version(arg0);
        assert!(arg0.owner == arg1, 101);
    }

    fun assert_version(arg0: &TradingAccount) {
        assert!(arg0.version == 1, 100);
    }

    public fun claim_invalid_from_account(arg0: &mut TradingAccount, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg1);
        debit_outcome(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg1), arg2, arg3);
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::claim_invalid_amount(arg1, arg2, arg3, arg4);
        credit_yoso(arg0, v1);
        let v2 = AccountInvalidProceedsClaimed{
            account_id    : 0x2::object::id<TradingAccount>(arg0),
            owner         : arg0.owner,
            market_id     : v0,
            outcome       : arg2,
            shares_burned : arg3,
            yoso_credited : 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v1),
        };
        0x2::event::emit<AccountInvalidProceedsClaimed>(v2);
    }

    public(friend) fun credit_outcome(arg0: &mut TradingAccount, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: u64) {
        assert_version(arg0);
        if (arg4 > 0) {
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg3);
            let v0 = ShareKey{
                market_id        : arg1,
                market_object_id : arg2,
                outcome          : arg3,
            };
            let v1 = share_balance_by_key(arg0, v0) + arg4;
            set_share_balance(arg0, v0, v1);
        };
    }

    public(friend) fun credit_yoso(arg0: &mut TradingAccount, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        assert_version(arg0);
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1) > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
    }

    public(friend) fun debit_outcome(arg0: &mut TradingAccount, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: u64) {
        assert_version(arg0);
        if (arg4 > 0) {
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg3);
            let v0 = ShareKey{
                market_id        : arg1,
                market_object_id : arg2,
                outcome          : arg3,
            };
            let v1 = share_balance_by_key(arg0, v0);
            assert!(v1 >= arg4, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
            set_share_balance(arg0, v0, v1 - arg4);
        };
    }

    public(friend) fun debit_yoso(arg0: &mut TradingAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg1 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_vault) >= arg1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, arg1), arg2)
    }

    public fun deposit_outcome(arg0: &mut TradingAccount, arg1: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let (v0, v1, v2, v3) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::burn(arg1);
        credit_outcome(arg0, v0, v1, v2, v3);
        let v4 = OutcomeDeposited{
            account_id       : 0x2::object::id<TradingAccount>(arg0),
            owner            : arg0.owner,
            market_id        : v0,
            market_object_id : v1,
            outcome          : v2,
            amount           : v3,
        };
        0x2::event::emit<OutcomeDeposited>(v4);
    }

    public fun deposit_yoso(arg0: &mut TradingAccount, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1);
        assert!(v0 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
        let v1 = YosoDeposited{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            owner      : arg0.owner,
            amount     : v0,
        };
        0x2::event::emit<YosoDeposited>(v1);
    }

    public fun init_account(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_account(v0, arg0);
        let v2 = TradingAccountCreated{
            account_id : 0x2::object::id<TradingAccount>(&v1),
            owner      : v0,
        };
        0x2::event::emit<TradingAccountCreated>(v2);
        0x2::transfer::share_object<TradingAccount>(v1);
    }

    fun new_account(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : TradingAccount {
        assert!(arg0 != @0x0, 101);
        TradingAccount{
            id         : 0x2::object::new(arg1),
            version    : 1,
            owner      : arg0,
            yoso_vault : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            shares     : 0x2::table::new<ShareKey, u64>(arg1),
        }
    }

    public fun owner(arg0: &TradingAccount) : address {
        assert_version(arg0);
        arg0.owner
    }

    public fun redeem_from_account(arg0: &mut TradingAccount, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg1);
        debit_outcome(arg0, v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg1), arg2, arg3);
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::redeem_amount(arg1, arg2, arg3, arg4);
        credit_yoso(arg0, v1);
        let v2 = AccountWinningsRedeemed{
            account_id    : 0x2::object::id<TradingAccount>(arg0),
            owner         : arg0.owner,
            market_id     : v0,
            outcome       : arg2,
            shares_burned : arg3,
            yoso_credited : 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v1),
        };
        0x2::event::emit<AccountWinningsRedeemed>(v2);
    }

    fun set_share_balance(arg0: &mut TradingAccount, arg1: ShareKey, arg2: u64) {
        if (0x2::table::contains<ShareKey, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow_mut<ShareKey, u64>(&mut arg0.shares, arg1) = arg2;
        } else {
            0x2::table::add<ShareKey, u64>(&mut arg0.shares, arg1, arg2);
        };
    }

    public fun share_balance(arg0: &TradingAccount, arg1: u64, arg2: 0x2::object::ID, arg3: u8) : u64 {
        assert_version(arg0);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg3);
        let v0 = ShareKey{
            market_id        : arg1,
            market_object_id : arg2,
            outcome          : arg3,
        };
        share_balance_by_key(arg0, v0)
    }

    fun share_balance_by_key(arg0: &TradingAccount, arg1: ShareKey) : u64 {
        if (0x2::table::contains<ShareKey, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<ShareKey, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    public fun withdraw_outcome(arg0: &mut TradingAccount, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare {
        assert_owner(arg0, arg5);
        debit_outcome(arg0, arg1, arg2, arg3, arg4);
        let v0 = OutcomeWithdrawn{
            account_id       : 0x2::object::id<TradingAccount>(arg0),
            owner            : arg0.owner,
            market_id        : arg1,
            market_object_id : arg2,
            outcome          : arg3,
            amount           : arg4,
        };
        0x2::event::emit<OutcomeWithdrawn>(v0);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::mint(arg1, arg2, arg3, arg4, arg5)
    }

    public fun withdraw_yoso(arg0: &mut TradingAccount, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_owner(arg0, arg2);
        let v0 = debit_yoso(arg0, arg1, arg2);
        let v1 = YosoWithdrawn{
            account_id : 0x2::object::id<TradingAccount>(arg0),
            owner      : arg0.owner,
            amount     : arg1,
        };
        0x2::event::emit<YosoWithdrawn>(v1);
        v0
    }

    public fun yoso_balance(arg0: &TradingAccount) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_vault)
    }

    // decompiled from Move bytecode v7
}

