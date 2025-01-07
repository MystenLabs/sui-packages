module 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid {
    struct SUIDOUBLE_LIQUID has drop {
        dummy_field: bool,
    }

    struct LiquidStore has key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        version: u64,
        pending_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        staked_with_rewards_balance: u64,
        liquid_store_epoch: u64,
        treasury: 0x1::option::Option<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>,
        staked_pool: 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::SuidoubleLiquidStaker,
        promised_pool: 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::SuidoubleLiquidPromisedPool,
        fee_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_pool_token: 0x2::balance::Balance<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>,
        immutable_pool_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        immutable_pool_tokens: 0x2::balance::Balance<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>,
    }

    struct LiquidStoreWithdrawPromise has store, key {
        id: 0x2::object::UID,
        for: address,
        token_amount: u64,
        sui_amount: u64,
        fulfilled_at_epoch: u64,
    }

    struct NewLiquidStoreEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct PriceEvent has copy, drop {
        price: u64,
        price_reverse: u64,
    }

    struct EpochEvent has copy, drop {
        expected_staked: u64,
        epoch: u64,
        was_pending_balance: u64,
        was_staked_amount: u64,
        was_promised_amount: u64,
        after_pending_balance: u64,
        after_staked_amount: u64,
        after_promised_amount: u64,
        price: u64,
    }

    struct WithdrawPromiseEvent has copy, drop {
        id: 0x2::object::ID,
        price: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun attach_treasury(arg0: &mut LiquidStore, arg1: 0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.immutable_pool_sui, arg2);
        0x2::coin::put<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&mut arg0.immutable_pool_tokens, 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::mint_and_return(&mut arg1, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg3));
        0x1::option::fill<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury, arg1);
    }

    public entry fun burn_and_get_nothing(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), arg1);
    }

    entry fun calc_expected_profits(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        arg0.staked_with_rewards_balance = staked_amount_with_rewards(arg0, arg1, arg2);
    }

    public entry fun collect_fees(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(0x2::coin::take<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&mut arg0.fee_pool_token, 0x2::balance::value<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&arg0.fee_pool_token), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = get_current_price_reverse(arg0, arg2, arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.pending_pool, arg1);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), (((0x2::coin::value<0x2::sui::SUI>(&arg1) as u128) * (v0 as u128) / (1000000000 as u128)) as u64), arg3);
        let v1 = PriceEvent{
            price         : 0,
            price_reverse : v0,
        };
        0x2::event::emit<PriceEvent>(v1);
        once_per_epoch_if_needed(arg0, arg2, arg3);
    }

    public entry fun deposit_v2(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = get_current_price_reverse(arg0, arg3, arg4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.pending_pool, arg1);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), (((0x2::coin::value<0x2::sui::SUI>(&arg1) as u128) * (v0 as u128) / (1000000000 as u128)) as u64), arg4);
        let v1 = PriceEvent{
            price         : 0,
            price_reverse : v0,
        };
        0x2::event::emit<PriceEvent>(v1);
        once_per_epoch_if_needed_v2(arg0, arg2, arg3, arg4);
    }

    public entry fun fulfill(arg0: &mut LiquidStore, arg1: LiquidStoreWithdrawPromise, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        assert!(arg1.fulfilled_at_epoch <= 0x2::tx_context::epoch(arg3), 2);
        once_per_epoch_if_needed(arg0, arg2, arg3);
        if (0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::is_there_promised_staked_sui(&arg0.promised_pool, 0x2::object::id<LiquidStoreWithdrawPromise>(&arg1))) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::take_promised_staked_sui(&mut arg0.promised_pool, 0x2::object::id<LiquidStoreWithdrawPromise>(&arg1), arg2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::take_sui(&mut arg0.promised_pool, arg1.sui_amount, arg3), 0x2::tx_context::sender(arg3));
        };
        let LiquidStoreWithdrawPromise {
            id                 : v0,
            for                : _,
            token_amount       : _,
            sui_amount         : _,
            fulfilled_at_epoch : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun fulfill_v2(arg0: &mut LiquidStore, arg1: LiquidStoreWithdrawPromise, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        assert!(arg1.fulfilled_at_epoch <= 0x2::tx_context::epoch(arg4), 2);
        once_per_epoch_if_needed_v2(arg0, arg2, arg3, arg4);
        if (0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::is_there_promised_staked_sui(&arg0.promised_pool, 0x2::object::id<LiquidStoreWithdrawPromise>(&arg1))) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::take_promised_staked_sui(&mut arg0.promised_pool, 0x2::object::id<LiquidStoreWithdrawPromise>(&arg1), arg3, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::take_sui(&mut arg0.promised_pool, arg1.sui_amount, arg4), 0x2::tx_context::sender(arg4));
        };
        let LiquidStoreWithdrawPromise {
            id                 : v0,
            for                : _,
            token_amount       : _,
            sui_amount         : _,
            fulfilled_at_epoch : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun gather_development_fees_and_increment_epoch(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = arg0.liquid_store_epoch;
        if (v0 > v1) {
            let v2 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::take_extra_staked_balance(&mut arg0.promised_pool);
            let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
            if (v3 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3 / 2));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_pool, v2);
            0x2::coin::put<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&mut arg0.fee_pool_token, 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::mint_and_return(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), (((get_token_supply(arg0) as u128) * ((5 * (v0 - v1)) as u128) / 365000) as u64), arg2));
            arg0.liquid_store_epoch = v0;
        };
    }

    fun get_current_price(arg0: &LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = get_token_supply(arg0);
        if (v0 == 0) {
            return 1000000000
        };
        ((((immutable_amount(arg0) + pending_amount(arg0) + staked_amount_with_rewards(arg0, arg1, arg2) - promised_amount(arg0)) as u128) * (1000000000 as u128) / (v0 as u128)) as u64)
    }

    fun get_current_price_reverse(arg0: &LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = immutable_amount(arg0) + pending_amount(arg0) + staked_amount_with_rewards(arg0, arg1, arg2) - promised_amount(arg0);
        if (v0 == 0) {
            return 1000000000
        };
        (((get_token_supply(arg0) as u128) * (1000000000 as u128) / (v0 as u128)) as u64)
    }

    fun get_token_supply(arg0: &LiquidStore) : u64 {
        0x2::coin::total_supply<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(0x1::option::borrow<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&arg0.treasury))
    }

    public(friend) fun immutable_amount(arg0: &LiquidStore) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.immutable_pool_sui)
    }

    fun init(arg0: SUIDOUBLE_LIQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIDOUBLE_LIQUID>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = LiquidStore{
            id                          : 0x2::object::new(arg1),
            admin                       : 0x2::object::id<AdminCap>(&v1),
            version                     : 13,
            pending_pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            staked_with_rewards_balance : 0,
            liquid_store_epoch          : 0,
            treasury                    : 0x1::option::none<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(),
            staked_pool                 : 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::default(),
            promised_pool               : 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::default(arg1),
            fee_pool                    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_pool_token              : 0x2::balance::zero<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(),
            immutable_pool_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            immutable_pool_tokens       : 0x2::balance::zero<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(),
        };
        let v3 = NewLiquidStoreEvent{id: 0x2::object::uid_to_inner(&v2.id)};
        0x2::event::emit<NewLiquidStoreEvent>(v3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"DoubleLiquid Withdraw Promise"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://doubleliquid.pro/promise/{id}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://suidouble.github.io/dl/promise.png"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"DoubleLiquid Withdraw Promise of {sui_amount} mSUI, ready at epoch {fulfilled_at_epoch}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://doubleliquid.pro/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"DoubleLiquid"));
        let v8 = 0x2::display::new_with_fields<LiquidStoreWithdrawPromise>(&v0, v4, v6, arg1);
        0x2::display::update_version<LiquidStoreWithdrawPromise>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LiquidStoreWithdrawPromise>>(v8, 0x2::tx_context::sender(arg1));
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::default_and_share(arg1);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LiquidStore>(v2);
    }

    entry fun migrate(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 6);
        assert!(arg0.version < 13, 7);
        arg0.version = 13;
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::default_and_share(arg2);
    }

    public entry fun once_per_epoch_if_needed(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 > arg0.liquid_store_epoch) {
            let v1 = pending_amount(arg0);
            let v2 = promised_amount(arg0);
            let v3 = staked_amount(arg0);
            unstake_promised(arg0, arg1, arg2);
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::quick_sort_by_apy(&mut arg0.staked_pool, arg1, v0);
            send_pending_to_staked(arg0, arg1, arg2);
            gather_development_fees_and_increment_epoch(arg0, arg1, arg2);
            let v4 = staked_amount_with_rewards(arg0, arg1, arg2);
            arg0.staked_with_rewards_balance = v4;
            let v5 = EpochEvent{
                expected_staked       : v4,
                epoch                 : v0,
                was_pending_balance   : v1,
                was_staked_amount     : v3,
                was_promised_amount   : v2,
                after_pending_balance : pending_amount(arg0),
                after_staked_amount   : staked_amount(arg0),
                after_promised_amount : promised_amount(arg0),
                price                 : get_current_price(arg0, arg1, arg2),
            };
            0x2::event::emit<EpochEvent>(v5);
        };
    }

    public entry fun once_per_epoch_if_needed_v2(arg0: &mut LiquidStore, arg1: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg0.liquid_store_epoch) {
            let v1 = pending_amount(arg0);
            let v2 = promised_amount(arg0);
            let v3 = staked_amount(arg0);
            unstake_promised(arg0, arg2, arg3);
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::quick_sort_by_apy(&mut arg0.staked_pool, arg2, v0);
            send_pending_to_staked_v2(arg0, arg1, arg2, arg3);
            gather_development_fees_and_increment_epoch(arg0, arg2, arg3);
            let v4 = staked_amount_with_rewards(arg0, arg2, arg3);
            arg0.staked_with_rewards_balance = v4;
            let v5 = EpochEvent{
                expected_staked       : v4,
                epoch                 : v0,
                was_pending_balance   : v1,
                was_staked_amount     : v3,
                was_promised_amount   : v2,
                after_pending_balance : pending_amount(arg0),
                after_staked_amount   : staked_amount(arg0),
                after_promised_amount : promised_amount(arg0),
                price                 : get_current_price(arg0, arg2, arg3),
            };
            0x2::event::emit<EpochEvent>(v5);
        };
    }

    public(friend) fun pending_amount(arg0: &LiquidStore) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_pool)
    }

    public entry fun prioritize_validator(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = 0x3::sui_system::active_validator_addresses(arg3);
        assert!(0x1::vector::contains<address>(&v0, &arg4), 8);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::set_metadata_next_validator(arg2, arg4);
    }

    public(friend) fun promised_amount(arg0: &LiquidStore) : u64 {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::promised_amount(&arg0.promised_pool)
    }

    public entry fun quick_sort_by_apy(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::quick_sort_by_apy(&mut arg0.staked_pool, arg1, 0x2::tx_context::epoch(arg2));
    }

    public entry fun rebalance(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: u64, arg3: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_pool, 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::rebalance(&mut arg0.staked_pool, arg2, arg3, arg4, arg5));
    }

    fun send_pending_to_promised(arg0: &mut LiquidStore, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = still_waiting_for_sui_amount(arg0);
        if (v0 > 0) {
            if (pending_amount(arg0) <= v0) {
                0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::fulfill_with_sui(&mut arg0.promised_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pending_pool));
            } else {
                0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::fulfill_with_sui(&mut arg0.promised_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_pool, v0));
            };
        };
    }

    fun send_pending_to_staked(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        if (pending_amount(arg0) / 1000000000 * 1000000000 > 0) {
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::stake_sui(&mut arg0.staked_pool, &mut arg0.pending_pool, arg1, arg2);
        };
    }

    fun send_pending_to_staked_v2(arg0: &mut LiquidStore, arg1: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        if (pending_amount(arg0) / 1000000000 * 1000000000 > 0) {
            0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::stake_sui_v2(&mut arg0.staked_pool, &mut arg0.pending_pool, arg1, arg2, arg3);
        };
    }

    public entry fun stake_pending_no_wait(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        send_pending_to_staked(arg0, arg2, arg3);
    }

    public entry fun stake_pending_no_wait_v2(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        send_pending_to_staked_v2(arg0, arg2, arg3, arg4);
    }

    public(friend) fun staked_amount(arg0: &LiquidStore) : u64 {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::staked_amount(&arg0.staked_pool)
    }

    public fun staked_amount_with_rewards(arg0: &LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::staked_amount_with_rewards(&arg0.staked_pool, arg1, arg2)
    }

    public(friend) fun still_waiting_for_sui_amount(arg0: &LiquidStore) : u64 {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::still_waiting_for_sui_amount(&arg0.promised_pool)
    }

    public entry fun test_staked_amount_with_rewards(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        arg0.staked_with_rewards_balance = staked_amount_with_rewards(arg0, arg1, arg2);
    }

    fun unstake_promised(arg0: &mut LiquidStore, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::try_to_fill_with_perfect_staked_sui(&mut arg0.promised_pool, &mut arg0.staked_pool, arg1, arg2);
        if (still_waiting_for_sui_amount(arg0) > 0) {
            send_pending_to_promised(arg0, arg2);
            let v0 = still_waiting_for_sui_amount(arg0);
            if (v0 > 0) {
                let v1 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::unstake_sui(&mut arg0.staked_pool, v0, arg1, arg2);
                if (0x2::balance::value<0x2::sui::SUI>(&v1) <= v0) {
                    0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::fulfill_with_sui(&mut arg0.promised_pool, v1);
                } else {
                    0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::fulfill_with_sui(&mut arg0.promised_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0));
                    0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_pool, v1);
                };
                send_pending_to_promised(arg0, arg2);
            };
        };
    }

    public entry fun unstake_the_pool_to_pending(arg0: &mut LiquidStore, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_pool, 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::unstake_sui_for_the_pool(&mut arg0.staked_pool, arg2, arg3, arg4));
    }

    public entry fun withdraw(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = 0x2::coin::value<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&arg1);
        let v1 = get_current_price(arg0, arg2, arg3);
        let v2 = (v0 as u128) * (v1 as u128) / (1000000000 as u128);
        let v3 = PriceEvent{
            price         : v1,
            price_reverse : 0,
        };
        0x2::event::emit<PriceEvent>(v3);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), arg1);
        let v4 = 0x2::tx_context::epoch(arg3) + 2;
        let v5 = LiquidStoreWithdrawPromise{
            id                 : 0x2::object::new(arg3),
            for                : 0x2::tx_context::sender(arg3),
            token_amount       : v0,
            sui_amount         : (v2 as u64),
            fulfilled_at_epoch : v4,
        };
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::increment_promised_amount(&mut arg0.promised_pool, (v2 as u64), v4, 0x2::object::id<LiquidStoreWithdrawPromise>(&v5));
        0x2::transfer::public_transfer<LiquidStoreWithdrawPromise>(v5, 0x2::tx_context::sender(arg3));
        once_per_epoch_if_needed(arg0, arg2, arg3);
    }

    public entry fun withdraw_fast(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = get_current_price(arg0, arg2, arg3);
        let v1 = (0x2::coin::value<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&arg1) as u128) * (v0 as u128) / (1000000000 as u128);
        let v2 = (v1 as u64);
        let v3 = PriceEvent{
            price         : v0,
            price_reverse : 0,
        };
        0x2::event::emit<PriceEvent>(v3);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), arg1);
        let v4 = 0x2::tx_context::epoch(arg3);
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        let v6 = 0;
        let v7 = v6;
        let v8 = v2;
        let v9 = pending_amount(arg0);
        if (v9 < v2) {
            v8 = v9;
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_pool, v8));
            v7 = v6 + v8;
        };
        if (v7 < v2) {
            let v10 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::promised_amount_at_epoch(&mut arg0.promised_pool, v4 + 1);
            let v11 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::staked_amount_available(&arg0.staked_pool, arg2, v4 + 1);
            let v12 = 0;
            if (v10 < v11) {
                v12 = v11 - v10;
            };
            let v13 = v2 - v7;
            let v14 = v13;
            if (v13 < 1000000000) {
                v14 = 1000000000;
            };
            assert!(v14 <= v12, 1);
            let v15 = 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_staker::unstake_sui(&mut arg0.staked_pool, v14, arg2, arg3);
            let v16 = 0x2::balance::value<0x2::sui::SUI>(&v15);
            assert!(v16 <= v12, 1);
            v7 = v7 + v16;
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v15);
        };
        assert!(v7 >= v2, 1);
        let v17 = v1 / 1000 * 20;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v5, (v17 as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_pool, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v5, v2 - (v17 as u64), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_v2(arg0: &mut LiquidStore, arg1: 0x2::coin::Coin<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>, arg2: &mut 0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_stats::SuidoubleLiquidStats, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 13, 5);
        let v0 = 0x2::coin::value<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>(&arg1);
        let v1 = get_current_price(arg0, arg3, arg4);
        let v2 = (v0 as u128) * (v1 as u128) / (1000000000 as u128);
        let v3 = PriceEvent{
            price         : v1,
            price_reverse : 0,
        };
        0x2::event::emit<PriceEvent>(v3);
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_coin::SUIDOUBLE_LIQUID_COIN>>(&mut arg0.treasury), arg1);
        let v4 = 0x2::tx_context::epoch(arg4) + 2;
        let v5 = LiquidStoreWithdrawPromise{
            id                 : 0x2::object::new(arg4),
            for                : 0x2::tx_context::sender(arg4),
            token_amount       : v0,
            sui_amount         : (v2 as u64),
            fulfilled_at_epoch : v4,
        };
        0x67e77b4e79e8c157e42c18eecf68e25047f6f95e657bd65387189411f2898ce3::suidouble_liquid_promised_pool::increment_promised_amount(&mut arg0.promised_pool, (v2 as u64), v4, 0x2::object::id<LiquidStoreWithdrawPromise>(&v5));
        0x2::transfer::public_transfer<LiquidStoreWithdrawPromise>(v5, 0x2::tx_context::sender(arg4));
        once_per_epoch_if_needed_v2(arg0, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

