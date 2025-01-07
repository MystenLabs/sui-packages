module 0x4f94bd05ed668664e8aecd9f95c4ed12a6f6dabc0e1e31af56c3016a683ebc59::launchpad_token {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct BuyTokenEvent has copy, drop {
        launchpad_id: 0x2::object::ID,
        buyer: address,
    }

    struct CreateLaunchpadEvent has copy, drop {
        launchpad_id: 0x2::object::ID,
        creator: address,
    }

    struct LaunchpadTokenInfo has store {
        metadata_id: 0x2::object::ID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        total_supply: u64,
    }

    struct UserClaim has copy, drop, store {
        user: address,
        claim_at: u64,
        claim_amount: u64,
    }

    struct DefiConfig has store {
        price: u64,
        soft_cap: u64,
        hard_cap: u64,
        start_time: u64,
        end_time: u64,
        is_public: bool,
        whitelist: vector<address>,
        limit_per_wallet: u64,
        minimum_per_wallet: u64,
        dex_id: u64,
        liquidity_percentage: u64,
        liquidity_listing_rate: u64,
        liquidity_lockup_minutes: u64,
        should_use_vesting_contributor: bool,
        first_release_percentage: u64,
        vesting_cycle_period_minutes: u64,
        token_release_each_cycle_percentage: u64,
        is_cancel: bool,
        is_finalize: bool,
    }

    struct LaunchpadConfig has store {
        fee_option: u64,
        fee_revenue_percentage: u64,
        fee_token_percentage: u64,
        is_auto_listing: bool,
        affiliate_percentage: u64,
        refund_type: u64,
        is_aff: bool,
        is_ama: bool,
        is_audit: bool,
        is_kyc: bool,
        safu_rank: u64,
    }

    struct Launchpad<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        logo: 0x1::string::String,
        featured_image: 0x1::string::String,
        website_url: 0x1::string::String,
        facebook_url: 0x1::string::String,
        twitter_url: 0x1::string::String,
        github_url: 0x1::string::String,
        telegram_url: 0x1::string::String,
        instagram_url: 0x1::string::String,
        discord_url: 0x1::string::String,
        youtube_url: 0x1::string::String,
        reddit_url: 0x1::string::String,
        defiConfig: DefiConfig,
        launchpadConfig: LaunchpadConfig,
        total_ref_sold: u64,
        total_sold: u64,
        total_claim: u64,
        total_refund: u64,
        treasury: 0x2::balance::Balance<T1>,
        token_balance: 0x2::balance::Balance<T0>,
        burning_treasury: 0x2::balance::Balance<T0>,
        token: LaunchpadTokenInfo,
        claim_history: vector<UserClaim>,
        contributors: 0x2::vec_set::VecSet<address>,
        creator: address,
    }

    struct ListLaunchpad has copy, drop, store {
        id: 0x2::object::ID,
        soft_cap: u64,
        hard_cap: u64,
        start_time: u64,
        end_time: u64,
        name: 0x1::string::String,
    }

    struct UserContribution has store, key {
        id: 0x2::object::UID,
        launchpads: 0x2::vec_set::VecSet<ListLaunchpad>,
    }

    struct UserBuyData has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct UserClaimInLaunchpad has store, key {
        id: 0x2::object::UID,
        claim_history: vector<UserClaim>,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        launchpads: vector<ListLaunchpad>,
        transaction_fee: u64,
        transaction_fee_decimal_place: u8,
        wallet: address,
        dex_package_ids: vector<0x2::object::ID>,
        admin_list: vector<address>,
    }

    struct UserReferralData has store, key {
        id: 0x2::object::UID,
        referral_count: u64,
    }

    public entry fun add_to_whitelist<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x1::vector::push_back<address>(&mut arg1.defiConfig.whitelist, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun burn_remaining_tokens<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun buy<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: vector<0x2::coin::Coin<T1>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1.defiConfig.is_cancel == false, 134);
        let v1 = get_now_second(arg4);
        assert!(arg1.defiConfig.start_time <= v1, 123);
        assert!(arg1.defiConfig.end_time >= v1, 123);
        assert!(arg2 > 0, 106);
        assert!(arg1.total_sold + arg2 <= arg1.defiConfig.hard_cap, 102);
        assert!(arg2 >= arg1.defiConfig.minimum_per_wallet, 122);
        let (v2, _) = 0x1::vector::index_of<address>(&arg1.defiConfig.whitelist, &v0);
        assert!(!!arg1.defiConfig.is_public || v2, 104);
        assert!(arg3 != v0, 136);
        if (arg3 != @0x0) {
            let v4 = 0x1::string::utf8(b"user_referral_data_");
            0x1::string::append(&mut v4, 0x2::address::to_string(arg3));
            if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, v4)) {
                let v5 = UserReferralData{
                    id             : 0x2::object::new(arg6),
                    referral_count : 0,
                };
                0x2::dynamic_object_field::add<0x1::string::String, UserReferralData>(&mut arg1.id, v4, v5);
            };
            let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserReferralData>(&mut arg1.id, v4);
            v6.referral_count = v6.referral_count + arg2;
        };
        arg1.total_ref_sold = arg1.total_ref_sold + arg2;
        assert!(arg1.defiConfig.is_finalize == false, 126);
        let v7 = 0x1::string::utf8(b"user_buy_data_");
        0x1::string::append(&mut v7, 0x2::address::to_string(v0));
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, v7)) {
            let v8 = UserBuyData{
                id     : 0x2::object::new(arg6),
                amount : 0,
            };
            0x2::dynamic_object_field::add<0x1::string::String, UserBuyData>(&mut arg1.id, v7, v8);
        };
        let v9 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserBuyData>(&mut arg1.id, v7);
        v9.amount = v9.amount + arg2;
        arg1.total_sold = arg1.total_sold + arg2;
        let v10 = arg2 / 0x2::math::pow(10, arg1.token.decimals);
        let v11 = if (v10 > 0) {
            let v12 = 0;
            if (v10 * 0x2::math::pow(10, arg1.token.decimals) < arg2) {
                v12 = arg2 - v10 * 0x2::math::pow(10, arg1.token.decimals);
            };
            v10 * arg1.defiConfig.price + v12 * arg1.defiConfig.price / 0x2::math::pow(10, arg1.token.decimals)
        } else {
            arg2 * arg1.defiConfig.price / 0x2::math::pow(10, arg1.token.decimals)
        };
        assert!(v11 > 0, 127);
        let (v13, v14) = merge_and_split<T1>(arg5, v11, arg6);
        0x2::balance::join<T1>(&mut arg1.treasury, 0x2::coin::into_balance<T1>(v13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, v0);
        let v15 = 0x1::string::utf8(b"user_contribution_");
        0x1::string::append(&mut v15, 0x2::address::to_string(v0));
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v15)) {
            let v16 = UserContribution{
                id         : 0x2::object::new(arg6),
                launchpads : 0x2::vec_set::empty<ListLaunchpad>(),
            };
            0x2::dynamic_object_field::add<0x1::string::String, UserContribution>(&mut arg0.id, v15, v16);
        };
        let v17 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserContribution>(&mut arg0.id, v15);
        let v18 = get_listlaunchpad_object_from_launchpad<T0, T1>(arg1);
        if (!0x2::vec_set::contains<ListLaunchpad>(&v17.launchpads, &v18)) {
            0x2::vec_set::insert<ListLaunchpad>(&mut v17.launchpads, v18);
        };
        if (!0x2::vec_set::contains<address>(&arg1.contributors, &v0)) {
            0x2::vec_set::insert<address>(&mut arg1.contributors, v0);
        };
        let v19 = BuyTokenEvent{
            launchpad_id : 0x2::object::id<Launchpad<T0, T1>>(arg1),
            buyer        : v0,
        };
        0x2::event::emit<BuyTokenEvent>(v19);
    }

    public entry fun cancel_launchpad<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        assert!(arg1.defiConfig.is_cancel == false, 134);
        assert!(get_now_second(arg2) < arg1.defiConfig.start_time, 135);
        arg1.defiConfig.is_cancel = true;
        refund_launchpad_token_to_owner<T0, T1>(arg1, arg3);
    }

    public entry fun claim<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.defiConfig.is_finalize == true, 119);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_claim_amount_by_user<T0, T1>(arg0, v0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_balance, v1, arg2), v0);
        arg0.total_claim = arg0.total_claim + v1;
        create_claim_history<T0, T1>(arg0, v0, v1, arg1, arg2);
    }

    public entry fun claim_reward_for_referral<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"user_referral_data_");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg1)));
    }

    fun create_claim_history<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"user_claim_");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg1));
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0), 139);
        let v1 = UserClaimInLaunchpad{
            id            : 0x2::object::new(arg4),
            claim_history : 0x1::vector::empty<UserClaim>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, UserClaimInLaunchpad>(&mut arg0.id, v0, v1);
        let v2 = get_now_second(arg3);
        let v3 = UserClaim{
            user         : arg1,
            claim_at     : v2,
            claim_amount : arg2,
        };
        0x1::vector::push_back<UserClaim>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserClaimInLaunchpad>(&mut arg0.id, v0).claim_history, v3);
        let v4 = UserClaim{
            user         : arg1,
            claim_at     : v2,
            claim_amount : arg2,
        };
        0x1::vector::push_back<UserClaim>(&mut arg0.claim_history, v4);
    }

    public entry fun create_launchpad<T0, T1>(arg0: &mut Marketplace, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: bool, arg21: vector<address>, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: bool, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: bool, arg36: u64, arg37: u64, arg38: bool, arg39: vector<0x2::coin::Coin<T0>>, arg40: &0x2::coin::CoinMetadata<T0>, arg41: u64, arg42: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg42);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        assert!(arg32 == 1 || arg32 == 2, 107);
        assert!(arg37 == 2 || arg37 == 1, 108);
        assert!(arg24 == 0, 109);
        assert!(arg15 > 0, 114);
        assert!(arg16 > 0, 117);
        assert!(arg17 > 0, 118);
        assert!(arg41 > 0, 112);
        assert!(arg16 >= arg17 / 4, 110);
        assert!(arg22 > 0, 115);
        assert!(arg23 > 0, 116);
        assert!(arg18 < arg19, 113);
        if (arg35 == true) {
            assert!(arg25 >= 51 && arg25 <= 100, 111);
        };
        let v1 = LaunchpadTokenInfo{
            metadata_id  : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg40),
            decimals     : 0x2::coin::get_decimals<T0>(arg40),
            name         : 0x2::coin::get_name<T0>(arg40),
            symbol       : 0x2::coin::get_symbol<T0>(arg40),
            description  : 0x2::coin::get_description<T0>(arg40),
            icon_url     : 0x2::coin::get_icon_url<T0>(arg40),
            total_supply : arg41,
        };
        let v2 = LaunchpadConfig{
            fee_option             : arg32,
            fee_revenue_percentage : arg33,
            fee_token_percentage   : arg34,
            is_auto_listing        : arg35,
            affiliate_percentage   : arg36,
            refund_type            : arg37,
            is_aff                 : arg38,
            is_ama                 : false,
            is_audit               : false,
            is_kyc                 : false,
            safu_rank              : 0,
        };
        let v3 = DefiConfig{
            price                               : arg15,
            soft_cap                            : arg16,
            hard_cap                            : arg17,
            start_time                          : arg18,
            end_time                            : arg19,
            is_public                           : arg20,
            whitelist                           : arg21,
            limit_per_wallet                    : arg22,
            minimum_per_wallet                  : arg23,
            dex_id                              : arg24,
            liquidity_percentage                : arg25,
            liquidity_listing_rate              : arg26,
            liquidity_lockup_minutes            : arg27,
            should_use_vesting_contributor      : arg28,
            first_release_percentage            : arg29,
            vesting_cycle_period_minutes        : arg30,
            token_release_each_cycle_percentage : arg31,
            is_cancel                           : false,
            is_finalize                         : false,
        };
        let v4 = Launchpad<T0, T1>{
            id               : 0x2::object::new(arg42),
            owner            : arg1,
            name             : arg2,
            description      : arg3,
            logo             : arg4,
            featured_image   : arg5,
            website_url      : arg6,
            facebook_url     : arg7,
            twitter_url      : arg8,
            github_url       : arg9,
            telegram_url     : arg10,
            instagram_url    : arg11,
            discord_url      : arg12,
            youtube_url      : arg13,
            reddit_url       : arg14,
            defiConfig       : v3,
            launchpadConfig  : v2,
            total_ref_sold   : 0,
            total_sold       : 0,
            total_claim      : 0,
            total_refund     : 0,
            treasury         : 0x2::balance::zero<T1>(),
            token_balance    : 0x2::balance::zero<T0>(),
            burning_treasury : 0x2::balance::zero<T0>(),
            token            : v1,
            claim_history    : 0x1::vector::empty<UserClaim>(),
            contributors     : 0x2::vec_set::empty<address>(),
            creator          : v0,
        };
        0x1::vector::push_back<ListLaunchpad>(&mut arg0.launchpads, get_listlaunchpad_object_from_launchpad<T0, T1>(&v4));
        let v5 = &mut v4;
        send_token_to_launchpad_treasury<T0, T1>(v5, arg17, arg39, v0, arg42);
        let v6 = CreateLaunchpadEvent{
            launchpad_id : 0x2::object::id<Launchpad<T0, T1>>(&v4),
            creator      : v0,
        };
        0x2::event::emit<CreateLaunchpadEvent>(v6);
        0x2::transfer::share_object<Launchpad<T0, T1>>(v4);
    }

    public entry fun finalize<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &mut Marketplace, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_now_second(arg2);
        assert!(0x1::vector::contains<address>(&arg1.admin_list, &v0), 120);
        assert!(arg0.defiConfig.is_finalize == false, 126);
        assert!(arg0.defiConfig.hard_cap == arg0.total_sold || v1 > arg0.defiConfig.end_time, 137);
        if (arg0.total_sold < arg0.defiConfig.soft_cap) {
            assert!(v1 > arg0.defiConfig.end_time, 121);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_balance, arg0.defiConfig.hard_cap, arg3), arg0.creator);
            let v2 = 0;
            let v3 = 0x2::vec_set::into_keys<address>(arg0.contributors);
            while (v2 < 0x2::vec_set::size<address>(&arg0.contributors)) {
                refund_to_user<T0, T1>(arg0, *0x1::vector::borrow<address>(&v3, v2), arg3);
                v2 = v2 + 1;
            };
        } else {
            let v4 = arg0.total_sold / 0x2::math::pow(10, arg0.token.decimals);
            let v5 = if (v4 > 0) {
                v4 * arg0.defiConfig.price
            } else {
                arg0.total_sold * arg0.defiConfig.price / 0x2::math::pow(10, arg0.token.decimals)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.treasury, v5, arg3), arg1.wallet);
            if (arg0.total_sold < arg0.defiConfig.hard_cap) {
                if (arg0.launchpadConfig.refund_type == 1) {
                    refund_launchpad_token_to_owner<T0, T1>(arg0, arg3);
                } else {
                    burn_remaining_tokens<T0, T1>(arg0, arg3);
                };
            };
        };
        arg0.defiConfig.is_finalize = true;
    }

    public entry fun fullfil_treasury<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.total_sold / 0x2::math::pow(10, arg0.token.decimals);
        let v2 = if (v1 > 0) {
            v1 * arg0.defiConfig.price
        } else {
            arg0.total_sold * arg0.defiConfig.price / 0x2::math::pow(10, arg0.token.decimals)
        };
        let (v3, v4) = merge_and_split<T1>(arg1, v2 - 0x2::balance::value<T1>(&arg0.treasury), arg2);
        0x2::balance::join<T1>(&mut arg0.treasury, 0x2::coin::into_balance<T1>(v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, v0);
    }

    fun get_claim_amount_by_user<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::string::utf8(b"user_buy_data_");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg2)));
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            let v1 = UserBuyData{
                id     : 0x2::object::new(arg2),
                amount : 0,
            };
            0x2::dynamic_object_field::add<0x1::string::String, UserBuyData>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserBuyData>(&mut arg0.id, v0).amount
    }

    fun get_listlaunchpad_object_from_launchpad<T0, T1>(arg0: &Launchpad<T0, T1>) : ListLaunchpad {
        ListLaunchpad{
            id         : 0x2::object::id<Launchpad<T0, T1>>(arg0),
            soft_cap   : arg0.defiConfig.soft_cap,
            hard_cap   : arg0.defiConfig.hard_cap,
            start_time : arg0.defiConfig.start_time,
            end_time   : arg0.defiConfig.end_time,
            name       : arg0.name,
        }
    }

    fun get_now_second(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun get_remaining_tokens_to_hard_cap<T0, T1>(arg0: &Launchpad<T0, T1>) : u64 {
        arg0.defiConfig.hard_cap - arg0.total_sold
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = Marketplace{
            id                            : 0x2::object::new(arg0),
            launchpads                    : 0x1::vector::empty<ListLaunchpad>(),
            transaction_fee               : 0,
            transaction_fee_decimal_place : 3,
            wallet                        : @0x5667295fdc3e4ff8a6a9f4807dab36d3ba9d33a3ab55ceefc6dc9ed87e94742f,
            dex_package_ids               : 0x1::vector::empty<0x2::object::ID>(),
            admin_list                    : v2,
        };
        0x2::transfer::share_object<Marketplace>(v3);
    }

    fun merge_and_split<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        assert!(0x2::coin::value<T0>(&v0) >= arg1, 100);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun refund<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_now_second(arg1);
        assert!(v0 > arg0.defiConfig.end_time, 121);
        if (arg0.total_sold >= arg0.defiConfig.soft_cap) {
            assert!(v0 > arg0.defiConfig.end_time + 259200, 129);
            assert!(arg0.defiConfig.is_finalize == false, 126);
        };
        let v1 = 0x2::tx_context::sender(arg2);
        refund_to_user<T0, T1>(arg0, v1, arg2);
    }

    fun refund_launchpad_token_to_owner<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = get_remaining_tokens_to_hard_cap<T0, T1>(arg0);
        assert!(v0 >= 0, 128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.token_balance, v0, arg1), arg0.creator);
    }

    fun refund_to_user<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"user_buy_data_");
        0x1::string::append(&mut v0, 0x2::address::to_string(arg1));
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UserBuyData>(&mut arg0.id, v0).amount * arg0.defiConfig.price / 0x2::math::pow(10, arg0.token.decimals);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.treasury, v1, arg2), arg1);
            arg0.total_refund = arg0.total_refund + v1;
        };
    }

    public entry fun remove_from_whitelist<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg1.defiConfig.whitelist, &v1);
            if (v2) {
                0x1::vector::remove<address>(&mut arg1.defiConfig.whitelist, v3);
            };
        };
    }

    fun send_token_to_launchpad_treasury<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == arg0.defiConfig.hard_cap, 101);
        let (v0, v1) = merge_and_split<T0>(arg2, arg1, arg4);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg3);
    }

    public entry fun update_launchpad<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: bool, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg19);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        assert!(arg16 > get_now_second(arg18), 133);
        assert!(arg17 > arg16, 132);
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.logo = arg4;
        arg1.featured_image = arg5;
        arg1.website_url = arg6;
        arg1.facebook_url = arg7;
        arg1.twitter_url = arg8;
        arg1.github_url = arg9;
        arg1.telegram_url = arg10;
        arg1.instagram_url = arg11;
        arg1.discord_url = arg12;
        arg1.youtube_url = arg13;
        arg1.reddit_url = arg14;
        arg1.launchpadConfig.is_aff = arg15;
        arg1.defiConfig.start_time = arg16;
        arg1.defiConfig.end_time = arg17;
    }

    public entry fun update_marketplace_admin_list(arg0: &mut Marketplace, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        assert!(0x1::vector::length<address>(&arg1) > 0, 138);
        arg0.admin_list = arg1;
    }

    public entry fun update_marketplace_data(arg0: &AdminCap, arg1: &mut Marketplace, arg2: address, arg3: u64, arg4: u8, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.wallet = arg2;
        arg1.transaction_fee = arg3;
        arg1.transaction_fee_decimal_place = arg4;
        arg1.dex_package_ids = arg5;
    }

    public entry fun update_status_kyc_other<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: bool, arg3: bool, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        assert!(arg5 == 3 || arg5 == 2 || arg5 == 1 || arg5 == 0, 131);
        arg1.launchpadConfig.safu_rank = arg5;
        arg1.launchpadConfig.is_kyc = arg2;
        arg1.launchpadConfig.is_ama = arg3;
        arg1.launchpadConfig.is_audit = arg4;
    }

    public entry fun update_whitelist<T0, T1>(arg0: &mut Marketplace, arg1: &mut Launchpad<T0, T1>, arg2: bool, arg3: vector<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 120);
        arg1.defiConfig.is_public = arg2;
        if (arg4 == 1) {
            add_to_whitelist<T0, T1>(arg0, arg1, arg3, arg5);
        } else if (arg4 == 2) {
            remove_from_whitelist<T0, T1>(arg0, arg1, arg3, arg5);
        };
    }

    // decompiled from Move bytecode v6
}

