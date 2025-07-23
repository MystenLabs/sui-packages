module 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::rwa {
    struct RWA has drop {
        dummy_field: bool,
    }

    struct RwaProject has key {
        id: 0x2::object::UID,
        version: u64,
        rwa_key: vector<u8>,
        freezeUntilSoldOut: bool,
        isSoldOut: bool,
        admin: address,
        financier: address,
        price: 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::Ratio,
        balance: 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::SBalance<RWA>,
        revenue_balance: 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::SBalance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>,
        dividend_records: 0x2::object_bag::ObjectBag,
        dividend_batches: u64,
        dividend_funds_balance: 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::SBalance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>,
        bank_id: 0x2::object::ID,
        ido_id: 0x2::object::ID,
        purchaseAddressesBeforeSoldOut: 0x2::table::Table<address, bool>,
    }

    struct DividendBatchRecord has store, key {
        id: 0x2::object::UID,
        version: u64,
        nth: u64,
        record_key: vector<u8>,
        rwa_token_total_supply: u64,
        dividend_funds: u64,
        dividend_funds_ratio: 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::Ratio,
        calculated_rwa_token_total: u64,
        dividend_list: 0x2::table::Table<address, UserDividendRecord>,
    }

    struct UserDividendRecord has copy, store {
        rwa_token_owned: u64,
        dividend_income: u64,
    }

    struct TokenBank has key {
        id: 0x2::object::UID,
        version: u64,
        treasury_cap: 0x2::coin::TreasuryCap<RWA>,
        metadata: 0x2::coin::CoinMetadata<RWA>,
        project_id: 0x2::object::ID,
        ido_id: 0x2::object::ID,
    }

    struct TokenIdo has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        deny_capV2: 0x2::coin::DenyCapV2<RWA>,
        bank_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
    }

    struct RwaProjectPublishEvent has copy, drop {
        rwa_key: vector<u8>,
        version: u64,
        project_id: 0x2::object::ID,
        bank_id: 0x2::object::ID,
        ido_id: 0x2::object::ID,
        admin: address,
        financier: address,
        price: u64,
        initialSupply: u64,
    }

    struct SupplyIncreasedEvent has copy, drop {
        increase_supply: u64,
        bank_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
    }

    struct BuyRwaTokenEvent has copy, drop {
        project_id: 0x2::object::ID,
        user: address,
        recipient: address,
        price: u64,
        buy_amount: u64,
        pay_amount: u64,
    }

    struct DividendBatchSubmitEvent has copy, drop {
        project_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        nth: u64,
        record_key: vector<u8>,
        dividend_funds: u64,
        rwa_token_total_supply: u64,
    }

    struct DividendListAddEvent has copy, drop {
        project_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        nth: u64,
        record_key: vector<u8>,
        user: address,
        participating_dividend: u64,
        dividend_income: u64,
    }

    struct GlobalPausedChangedEvent has copy, drop {
        project_id: 0x2::object::ID,
        paused: bool,
    }

    struct BlacklistAddEvent has copy, drop {
        project_id: 0x2::object::ID,
        user: address,
    }

    struct BlacklistRemoveEvent has copy, drop {
        project_id: 0x2::object::ID,
        user: address,
    }

    struct AdminChangedEvent has copy, drop {
        old_admin: address,
        new_admin: address,
        project_id: 0x2::object::ID,
    }

    struct FinancierChangedEvent has copy, drop {
        old_financier: address,
        new_financier: address,
        project_id: 0x2::object::ID,
    }

    struct PriceChangedEvent has copy, drop {
        project_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    struct RevenueWithdrawEvent has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        amount: u64,
    }

    struct DividendFundsWithdrawEvent has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        amount: u64,
    }

    struct UserDividendFundsClaimEvent has copy, drop {
        project_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        nth: u64,
        record_key: vector<u8>,
        user: address,
        recipient: address,
        amount: u64,
    }

    public entry fun add_blacklist(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        do_add_blacklist(arg0, arg1, arg2, arg3);
    }

    public entry fun add_dividend_list(arg0: &mut RwaProject, arg1: vector<u8>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        do_add_dividend_list(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy_token(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut RwaProject, arg3: vector<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        do_buy_token(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_dividend_funds(arg0: &mut RwaProject, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        do_claim_dividend_funds(arg0, arg1, arg2, arg3);
    }

    fun do_add_blacklist(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 100018);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::coin::deny_list_v2_add<RWA>(arg1, &mut arg0.deny_capV2, v0, arg3);
            let v1 = BlacklistAddEvent{
                project_id : arg0.project_id,
                user       : v0,
            };
            0x2::event::emit<BlacklistAddEvent>(v1);
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun do_add_dividend_list(arg0: &mut RwaProject, arg1: vector<u8>, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(!0x1::vector::is_empty<address>(&arg2), 100012);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 100011);
        assert!(!0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::utils::has_duplicate<address>(&arg2), 100014);
        assert!(arg0.financier == 0x2::tx_context::sender(arg4), 100009);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.dividend_records, arg1), 100013);
        let v0 = 0x2::object_bag::borrow_mut<vector<u8>, DividendBatchRecord>(&mut arg0.dividend_records, arg1);
        let v1 = v0.rwa_token_total_supply - v0.calculated_rwa_token_total;
        assert!(v1 > 0, 100015);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg2)) {
            let v4 = v2 + (*0x1::vector::borrow<u64>(&arg3, v3) as u128);
            v2 = v4;
            assert!(v4 <= (v1 as u128), 100016);
            v3 = v3 + 1;
        };
        assert!(v0.dividend_funds >= 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::partial(v0.dividend_funds_ratio, (v2 as u64)), 100017);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v5 = 0x1::vector::pop_back<address>(&mut arg2);
            let v6 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(!0x2::table::contains<address, UserDividendRecord>(&v0.dividend_list, v5), 100014);
            let v7 = 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::partial(v0.dividend_funds_ratio, v6);
            let v8 = UserDividendRecord{
                rwa_token_owned : v6,
                dividend_income : v7,
            };
            0x2::table::add<address, UserDividendRecord>(&mut v0.dividend_list, v5, v8);
            let v9 = DividendListAddEvent{
                project_id             : 0x2::object::id<RwaProject>(arg0),
                record_id              : 0x2::object::uid_to_inner(&v0.id),
                nth                    : v0.nth,
                record_key             : arg1,
                user                   : v5,
                participating_dividend : v6,
                dividend_income        : v7,
            };
            0x2::event::emit<DividendListAddEvent>(v9);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    fun do_buy_token(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut RwaProject, arg3: vector<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 100001);
        assert!(arg4 > 0, 100003);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg2.admin != v0, 100004);
        assert!(arg2.financier != v0, 100005);
        let v1 = 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::partial(arg2.price, arg4);
        0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::increase<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&mut arg2.revenue_balance, 0x2::coin::into_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::utils::merge_coins_to_amount_and_transfer_back_rest<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(arg3, v1, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<RWA>>(0x2::coin::from_balance<RWA>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::split<RWA>(&mut arg2.balance, arg4), arg6), arg5);
        if (!arg2.isSoldOut) {
            0x2::table::add<address, bool>(&mut arg2.purchaseAddressesBeforeSoldOut, arg5, true);
        };
        if (0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::value<RWA>(&arg2.balance) == 0) {
            arg2.isSoldOut = true;
        } else if (arg2.freezeUntilSoldOut && !arg2.isSoldOut) {
            0x2::coin::deny_list_v2_add<RWA>(arg1, &mut arg0.deny_capV2, arg5, arg6);
        };
        let v2 = BuyRwaTokenEvent{
            project_id : 0x2::object::id<RwaProject>(arg2),
            user       : v0,
            recipient  : arg5,
            price      : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::partial(arg2.price, 1000000000),
            buy_amount : arg4,
            pay_amount : v1,
        };
        0x2::event::emit<BuyRwaTokenEvent>(v2);
    }

    fun do_claim_dividend_funds(arg0: &mut RwaProject, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::object_bag::contains<vector<u8>>(&arg0.dividend_records, arg1), 100013);
        let v1 = 0x2::object_bag::borrow_mut<vector<u8>, DividendBatchRecord>(&mut arg0.dividend_records, arg1);
        assert!(0x2::table::contains<address, UserDividendRecord>(&v1.dividend_list, v0), 100020);
        let v2 = 0x2::table::borrow_mut<address, UserDividendRecord>(&mut v1.dividend_list, v0);
        assert!(v2.dividend_income > 0, 100021);
        assert!(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::value<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&arg0.dividend_funds_balance) >= v2.dividend_income, 100022);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>(0x2::coin::from_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::split<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&mut arg0.dividend_funds_balance, v2.dividend_income), arg3), arg2);
        v2.dividend_income = 0;
        let v3 = UserDividendFundsClaimEvent{
            project_id : 0x2::object::id<RwaProject>(arg0),
            record_id  : 0x2::object::uid_to_inner(&v1.id),
            nth        : v1.nth,
            record_key : arg1,
            user       : v0,
            recipient  : arg2,
            amount     : v2.dividend_income,
        };
        0x2::event::emit<UserDividendFundsClaimEvent>(v3);
    }

    fun do_increase_supply(arg0: &mut TokenBank, arg1: &mut RwaProject, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg1.version == 0, 100001);
        assert!(arg2 > 0, 100002);
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 100008);
        0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::increase<RWA>(&mut arg1.balance, 0x2::coin::into_balance<RWA>(0x2::coin::mint<RWA>(&mut arg0.treasury_cap, arg2, arg3)));
        let v0 = SupplyIncreasedEvent{
            increase_supply : arg2,
            bank_id         : 0x2::object::id<TokenBank>(arg0),
            project_id      : 0x2::object::id<RwaProject>(arg1),
        };
        0x2::event::emit<SupplyIncreasedEvent>(v0);
    }

    fun do_remove_blacklist(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 100018);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::coin::deny_list_v2_remove<RWA>(arg1, &mut arg0.deny_capV2, v0, arg3);
            let v1 = BlacklistRemoveEvent{
                project_id : arg0.project_id,
                user       : v0,
            };
            0x2::event::emit<BlacklistRemoveEvent>(v1);
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun do_set_admin(arg0: TokenBank, arg1: &mut TokenIdo, arg2: &mut RwaProject, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 100001);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.admin == v0, 100008);
        assert!(arg2.admin == v0, 100008);
        arg2.admin = arg3;
        arg1.admin = arg3;
        0x2::transfer::transfer<TokenBank>(arg0, v0);
        let v1 = AdminChangedEvent{
            old_admin  : arg2.admin,
            new_admin  : arg3,
            project_id : 0x2::object::id<RwaProject>(arg2),
        };
        0x2::event::emit<AdminChangedEvent>(v1);
    }

    fun do_set_financier(arg0: &mut RwaProject, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 100008);
        assert!(arg0.version == 0, 100001);
        arg0.financier = arg1;
        let v0 = FinancierChangedEvent{
            old_financier : arg0.financier,
            new_financier : arg1,
            project_id    : 0x2::object::id<RwaProject>(arg0),
        };
        0x2::event::emit<FinancierChangedEvent>(v0);
    }

    fun do_set_global_pause(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 100018);
        if (arg2) {
            0x2::coin::deny_list_v2_enable_global_pause<RWA>(arg1, &mut arg0.deny_capV2, arg3);
        } else {
            0x2::coin::deny_list_v2_disable_global_pause<RWA>(arg1, &mut arg0.deny_capV2, arg3);
        };
        let v0 = GlobalPausedChangedEvent{
            project_id : arg0.project_id,
            paused     : arg2,
        };
        0x2::event::emit<GlobalPausedChangedEvent>(v0);
    }

    fun do_set_price(arg0: &mut RwaProject, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 100008);
        assert!(arg0.version == 0, 100001);
        arg0.price = 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::ratio(arg1, 1000000000);
        let v0 = PriceChangedEvent{
            project_id : 0x2::object::id<RwaProject>(arg0),
            old_price  : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::partial(arg0.price, 1000000000),
            new_price  : arg1,
        };
        0x2::event::emit<PriceChangedEvent>(v0);
    }

    fun do_submit_dividend_batch(arg0: &mut RwaProject, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg3 > 0 || !0x1::vector::is_empty<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>(&arg2), 100006);
        assert!(arg4 > 0, 100007);
        assert!(arg0.financier == 0x2::tx_context::sender(arg5), 100009);
        assert!(!0x2::object_bag::contains<vector<u8>>(&arg0.dividend_records, arg1), 100010);
        0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::increase<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&mut arg0.dividend_funds_balance, 0x2::coin::into_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::utils::merge_coins_to_amount_and_transfer_back_rest<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(arg2, arg3, arg5)));
        let v0 = 0x2::object::new(arg5);
        let v1 = arg0.dividend_batches;
        let v2 = DividendBatchRecord{
            id                         : v0,
            version                    : 0,
            nth                        : v1,
            record_key                 : arg1,
            rwa_token_total_supply     : arg4,
            dividend_funds             : arg3,
            dividend_funds_ratio       : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::ratio(arg3, arg4),
            calculated_rwa_token_total : 0,
            dividend_list              : 0x2::table::new<address, UserDividendRecord>(arg5),
        };
        0x2::object_bag::add<vector<u8>, DividendBatchRecord>(&mut arg0.dividend_records, arg1, v2);
        arg0.dividend_batches = v1 + 1;
        let v3 = DividendBatchSubmitEvent{
            project_id             : 0x2::object::id<RwaProject>(arg0),
            record_id              : 0x2::object::uid_to_inner(&v0),
            nth                    : v1,
            record_key             : arg1,
            dividend_funds         : arg3,
            rwa_token_total_supply : arg4,
        };
        0x2::event::emit<DividendBatchSubmitEvent>(v3);
    }

    fun do_unfreeze_if_sold_out(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: &RwaProject, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 100001);
        assert!(arg2.isSoldOut, 100024);
        assert!(arg2.freezeUntilSoldOut, 100025);
        do_remove_blacklist(arg0, arg1, arg3, arg4);
    }

    fun do_withdraw_dividend_funds(arg0: &mut RwaProject, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg1 > 0, 100019);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin, 100008);
        assert!(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::value<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&arg0.dividend_funds_balance) >= arg1, 100006);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>(0x2::coin::from_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::split<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&mut arg0.dividend_funds_balance, arg1), arg3), arg2);
        let v1 = DividendFundsWithdrawEvent{
            project_id : 0x2::object::id<RwaProject>(arg0),
            admin      : v0,
            recipient  : arg2,
            amount     : arg1,
        };
        0x2::event::emit<DividendFundsWithdrawEvent>(v1);
    }

    fun do_withdraw_revenue(arg0: &mut RwaProject, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 100001);
        assert!(arg1 > 0, 100019);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin, 100008);
        assert!(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::value<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&arg0.revenue_balance) >= arg1, 100023);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>(0x2::coin::from_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::split<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(&mut arg0.revenue_balance, arg1), arg3), arg2);
        let v1 = RevenueWithdrawEvent{
            project_id : 0x2::object::id<RwaProject>(arg0),
            admin      : v0,
            recipient  : arg2,
            amount     : arg1,
        };
        0x2::event::emit<RevenueWithdrawEvent>(v1);
    }

    public entry fun increase_supply(arg0: &mut TokenBank, arg1: &mut RwaProject, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        do_increase_supply(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: RWA, arg1: &mut 0x2::tx_context::TxContext) {
        init_impl(arg0, arg1);
    }

    fun init_impl(arg0: RWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<RWA>(arg0, 0, b"RWA", b"RWA name", b"RWA desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://img.bgstatic.com/multiLang/coinPriceLogo/ae0e28b6052889bc2a46c4acd0ab44f51711213630630.png"))), true, arg1);
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::object::new(arg1);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = 0x2::object::new(arg1);
        let v8 = 0x2::object::uid_to_inner(&v7);
        let v9 = 0x2::object::new(arg1);
        let v10 = 0x2::object::uid_to_inner(&v9);
        let v11 = TokenBank{
            id           : v5,
            version      : 0,
            treasury_cap : v3,
            metadata     : v2,
            project_id   : v10,
            ido_id       : v8,
        };
        0x2::transfer::transfer<TokenBank>(v11, v4);
        let v12 = TokenIdo{
            id         : v7,
            version    : 0,
            admin      : v4,
            deny_capV2 : v1,
            bank_id    : v6,
            project_id : v10,
        };
        0x2::transfer::share_object<TokenIdo>(v12);
        let v13 = RwaProject{
            id                             : v9,
            version                        : 0,
            rwa_key                        : b"1f46c454a08943e1b9ae13cc7d0cd12e",
            freezeUntilSoldOut             : true,
            isSoldOut                      : false,
            admin                          : v4,
            financier                      : v4,
            price                          : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::ratio::ratio(1000000000, 1000000000),
            balance                        : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::from_balance<RWA>(0x2::coin::into_balance<RWA>(0x2::coin::mint<RWA>(&mut v3, 100, arg1))),
            revenue_balance                : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::from_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0x2::balance::zero<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>()),
            dividend_records               : 0x2::object_bag::new(arg1),
            dividend_batches               : 0,
            dividend_funds_balance         : 0xc93fa00cbf48518ad3ecf82d1d49b90eb0cfd3d682b07eecb95fc494520e433e::sbalance::from_balance<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>(0x2::balance::zero<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>()),
            bank_id                        : v6,
            ido_id                         : v8,
            purchaseAddressesBeforeSoldOut : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<RwaProject>(v13);
        let v14 = RwaProjectPublishEvent{
            rwa_key       : b"1f46c454a08943e1b9ae13cc7d0cd12e",
            version       : 0,
            project_id    : v10,
            bank_id       : v6,
            ido_id        : v8,
            admin         : v4,
            financier     : v4,
            price         : 1000000000,
            initialSupply : 100,
        };
        0x2::event::emit<RwaProjectPublishEvent>(v14);
    }

    public entry fun remove_blacklist(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        do_remove_blacklist(arg0, arg1, arg2, arg3);
    }

    public entry fun set_admin(arg0: TokenBank, arg1: &mut TokenIdo, arg2: &mut RwaProject, arg3: address, arg4: &0x2::tx_context::TxContext) {
        do_set_admin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_financier(arg0: &mut RwaProject, arg1: address, arg2: &0x2::tx_context::TxContext) {
        do_set_financier(arg0, arg1, arg2);
    }

    public entry fun set_global_pause(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        do_set_global_pause(arg0, arg1, arg2, arg3);
    }

    public entry fun set_price(arg0: &mut RwaProject, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        do_set_price(arg0, arg1, arg2);
    }

    public entry fun submit_dividend_batch(arg0: &mut RwaProject, arg1: vector<u8>, arg2: vector<0x2::coin::Coin<0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh::USDH>>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        do_submit_dividend_batch(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun unfreeze_if_sold_out(arg0: &mut TokenIdo, arg1: &mut 0x2::deny_list::DenyList, arg2: &RwaProject, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        do_unfreeze_if_sold_out(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_dividend_funds(arg0: &mut RwaProject, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        do_withdraw_dividend_funds(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_revenue(arg0: &mut RwaProject, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        do_withdraw_revenue(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

