module 0xb596b728c8b4d15ccfedbc3a82f95ead366dc223424db6d278c382c6d1306043::platform {
    struct PLATFORM has drop {
        dummy_field: bool,
    }

    struct CreatorKey has copy, drop, store {
        a: address,
    }

    struct SymbolKey has copy, drop, store {
        hi: u128,
        lo: u128,
    }

    struct OwnerKey has copy, drop, store {
        a: address,
    }

    struct VideoKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        token_decimals: u8,
        max_supply_base: u64,
        v_sui_mist: u64,
        v_tok_base: u64,
        min_buy_mist: u64,
        video_admin_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        video_pass_policy_id: 0x1::option::Option<0x2::object::ID>,
        version: u64,
    }

    struct CreatorRegistry has store, key {
        id: 0x2::object::UID,
        market_count: u64,
    }

    struct VideoCatalog has store, key {
        id: 0x2::object::UID,
        video_count: u64,
    }

    struct CreatorMarket has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: vector<u8>,
        metadata_uri: vector<u8>,
        created_at_ms: u64,
        reserve_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        supply: u64,
        max_supply: u64,
        v_sui_mist: u64,
        v_tok_base: u64,
        min_buy_mist: u64,
        creator_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        trade_count: u64,
        buy_count: u64,
        sell_count: u64,
        holder_count: u64,
        version: u64,
    }

    struct Position has copy, drop, store {
        balance: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct VideoListing has store, key {
        id: 0x2::object::UID,
        creator: address,
        walrus_blob_id: vector<u8>,
        title: vector<u8>,
        description: vector<u8>,
        thumbnail_uri: vector<u8>,
        mode: u8,
        rent_price_mist: u64,
        rent_duration_ms: u64,
        buy_price_mist: u64,
        published: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
        creator_revenue_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        rent_count: u64,
        buy_count: u64,
        tip_count: u64,
        version: u64,
    }

    struct VideoPass has store, key {
        id: 0x2::object::UID,
        video_id: 0x2::object::ID,
        creator: address,
        purchased_at_ms: u64,
    }

    struct RentalReceipt has store, key {
        id: 0x2::object::UID,
        video_id: 0x2::object::ID,
        creator: address,
        rented_at_ms: u64,
        expires_at_ms: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        symbol: vector<u8>,
        max_supply: u64,
        v_sui_mist: u64,
        v_tok_base: u64,
        min_buy_mist: u64,
        timestamp_ms: u64,
    }

    struct TradeEvent has copy, drop {
        market_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_in_mist: u64,
        tokens_out: u64,
        tokens_in: u64,
        payout_gross_mist: u64,
        payout_net_mist: u64,
        creator_fee_mist: u64,
        admin_fee_mist: u64,
        locked_fee_mist: u64,
        reserve_after_mist: u64,
        supply_after: u64,
        price_after_fp: u64,
        timestamp_ms: u64,
    }

    struct PositionChanged has copy, drop {
        market_id: 0x2::object::ID,
        owner: address,
        balance_after: u64,
        holder_count_after: u64,
        timestamp_ms: u64,
    }

    struct FeesClaimed has copy, drop {
        market_id: 0x2::object::ID,
        who: address,
        is_creator: bool,
        amount_mist: u64,
        to: address,
        creator_vault_after: u64,
        admin_vault_after: u64,
        timestamp_ms: u64,
    }

    struct VideoCreated has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        walrus_blob_id: vector<u8>,
        title: vector<u8>,
        mode: u8,
        published: bool,
        timestamp_ms: u64,
    }

    struct VideoPublished has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        mode: u8,
        rent_price_mist: u64,
        rent_duration_ms: u64,
        buy_price_mist: u64,
        published: bool,
        timestamp_ms: u64,
    }

    struct VideoRented has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        renter: address,
        price_mist: u64,
        admin_fee_mist: u64,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct VideoPurchased has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        buyer: address,
        price_mist: u64,
        admin_fee_mist: u64,
        timestamp_ms: u64,
    }

    struct VideoTipped has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        tipper: address,
        amount_mist: u64,
        admin_fee_mist: u64,
        timestamp_ms: u64,
    }

    struct VideoRevenueClaimed has copy, drop {
        video_id: 0x2::object::ID,
        creator: address,
        amount_mist: u64,
        to: address,
        vault_after: u64,
        timestamp_ms: u64,
    }

    struct VideoAdminFeesClaimed has copy, drop {
        admin: address,
        amount_mist: u64,
        to: address,
        vault_after: u64,
        timestamp_ms: u64,
    }

    struct VideoPassPolicyInitialized has copy, drop {
        policy_id: 0x2::object::ID,
        admin: address,
        timestamp_ms: u64,
    }

    fun assert_str_len(arg0: &vector<u8>, arg1: u64) {
        let v0 = (0x1::vector::length<u8>(arg0) as u64);
        assert!(v0 > 0 && v0 <= arg1, 4);
    }

    fun assert_valid_video_mode(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 == 1) {
            assert!(arg1 > 0 && arg2 > 0, 14);
        } else if (arg0 == 2) {
            assert!(arg3 > 0, 14);
        } else {
            assert!(arg0 == 0, 14);
        };
    }

    public entry fun buy(arg0: &mut CreatorMarket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        internal_buy(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy_video(arg0: &mut GlobalConfig, arg1: &mut VideoListing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.published, 13);
        assert!(arg1.mode == 2, 14);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.buy_price_mist, 5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v1 = fee_amount(arg1.buy_price_mist, 100);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.buy_price_mist, arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.video_admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_revenue_vault, v2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        arg1.buy_count = arg1.buy_count + 1;
        arg1.updated_at_ms = v3;
        let v4 = VideoPass{
            id              : 0x2::object::new(arg4),
            video_id        : 0x2::object::id<VideoListing>(arg1),
            creator         : arg1.creator,
            purchased_at_ms : v3,
        };
        0x2::transfer::transfer<VideoPass>(v4, v0);
        let v5 = VideoPurchased{
            video_id       : 0x2::object::id<VideoListing>(arg1),
            creator        : arg1.creator,
            buyer          : v0,
            price_mist     : arg1.buy_price_mist,
            admin_fee_mist : v1,
            timestamp_ms   : v3,
        };
        0x2::event::emit<VideoPurchased>(v5);
    }

    fun calc_sui_out(arg0: &CreatorMarket, arg1: u64) : u64 {
        let v0 = effective_x(arg0);
        let v1 = effective_y(arg0);
        assert!(v1 > (arg1 as u128), 10);
        assert!(v0 <= 18446744073709551615 && v1 <= 18446744073709551615, 15);
        let v2 = v0 * v1;
        assert!(v1 == 0 || v2 / v1 == v0, 15);
        ((v0 - v2 / (v1 - (arg1 as u128))) as u64)
    }

    fun calc_tokens_out(arg0: &CreatorMarket, arg1: u64) : u64 {
        let v0 = effective_x(arg0);
        let v1 = effective_y(arg0);
        assert!(v0 <= 18446744073709551615 && v1 <= 18446744073709551615, 15);
        let v2 = v0 * v1;
        assert!(v0 == 0 || v2 / v0 == v1, 15);
        ((v1 - v2 / (v0 + (arg1 as u128))) as u64)
    }

    public entry fun claim_admin_fees(arg0: &AdminCap, arg1: &mut CreatorMarket, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.admin, 1);
        assert!(arg2 > 0, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.admin_fee_vault) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.admin_fee_vault, arg2), arg5), arg3);
        let v1 = FeesClaimed{
            market_id           : market_id(arg1),
            who                 : v0,
            is_creator          : false,
            amount_mist         : arg2,
            to                  : arg3,
            creator_vault_after : 0x2::balance::value<0x2::sui::SUI>(&arg1.creator_fee_vault),
            admin_vault_after   : 0x2::balance::value<0x2::sui::SUI>(&arg1.admin_fee_vault),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeesClaimed>(v1);
    }

    public entry fun claim_creator_fees(arg0: &mut CreatorMarket, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator, 12);
        assert!(arg1 > 0, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault) >= arg1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_fee_vault, arg1), arg4), arg2);
        let v1 = FeesClaimed{
            market_id           : market_id(arg0),
            who                 : v0,
            is_creator          : true,
            amount_mist         : arg1,
            to                  : arg2,
            creator_vault_after : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault),
            admin_vault_after   : 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesClaimed>(v1);
    }

    public entry fun claim_video_admin_fees(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.admin, 1);
        assert!(arg2 > 0, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.video_admin_fee_vault) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.video_admin_fee_vault, arg2), arg5), arg3);
        let v1 = VideoAdminFeesClaimed{
            admin        : v0,
            amount_mist  : arg2,
            to           : arg3,
            vault_after  : 0x2::balance::value<0x2::sui::SUI>(&arg1.video_admin_fee_vault),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VideoAdminFeesClaimed>(v1);
    }

    public entry fun claim_video_revenue(arg0: &mut VideoListing, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 12);
        assert!(arg1 > 0, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.creator_revenue_vault) >= arg1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_revenue_vault, arg1), arg4), arg2);
        let v0 = VideoRevenueClaimed{
            video_id     : 0x2::object::id<VideoListing>(arg0),
            creator      : arg0.creator,
            amount_mist  : arg1,
            to           : arg2,
            vault_after  : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_revenue_vault),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VideoRevenueClaimed>(v0);
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun confirm_video_pass_transfer(arg0: &0x2::transfer_policy::TransferPolicy<VideoPass>, arg1: 0x2::transfer_policy::TransferRequest<VideoPass>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<VideoPass>(arg0, arg1);
    }

    public entry fun create_and_publish_video(arg0: &mut VideoCatalog, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        create_video(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true, arg9, arg10);
    }

    public entry fun create_market_with_first_buy(arg0: &GlobalConfig, arg1: &mut CreatorRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert_str_len(&arg2, 48);
        assert_str_len(&arg3, 16);
        if (0x1::vector::length<u8>(&arg4) > 0) {
            assert!((0x1::vector::length<u8>(&arg4) as u64) <= 256, 4);
        };
        let v1 = CreatorKey{a: v0};
        assert!(!0x2::dynamic_field::exists_<CreatorKey>(&arg1.id, v1), 2);
        let v2 = symbol_key(&arg3);
        assert!(!0x2::dynamic_field::exists_<SymbolKey>(&arg1.id, v2), 3);
        let v3 = CreatorMarket{
            id                : 0x2::object::new(arg8),
            creator           : v0,
            name              : 0x1::string::utf8(arg2),
            symbol            : arg3,
            metadata_uri      : arg4,
            created_at_ms     : 0x2::clock::timestamp_ms(arg7),
            reserve_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            supply            : 0,
            max_supply        : arg0.max_supply_base,
            v_sui_mist        : arg0.v_sui_mist,
            v_tok_base        : arg0.v_tok_base,
            min_buy_mist      : arg0.min_buy_mist,
            creator_fee_vault : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_fee_vault   : 0x2::balance::zero<0x2::sui::SUI>(),
            trade_count       : 0,
            buy_count         : 0,
            sell_count        : 0,
            holder_count      : 0,
            version           : 2,
        };
        let v4 = 0x2::object::id<CreatorMarket>(&v3);
        let v5 = CreatorKey{a: v0};
        0x2::dynamic_field::add<CreatorKey, 0x2::object::ID>(&mut arg1.id, v5, v4);
        0x2::dynamic_field::add<SymbolKey, 0x2::object::ID>(&mut arg1.id, v2, v4);
        arg1.market_count = arg1.market_count + 1;
        let v6 = MarketCreated{
            market_id    : v4,
            creator      : v0,
            name         : v3.name,
            symbol       : clone_bytes(&v3.symbol),
            max_supply   : v3.max_supply,
            v_sui_mist   : v3.v_sui_mist,
            v_tok_base   : v3.v_tok_base,
            min_buy_mist : v3.min_buy_mist,
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<MarketCreated>(v6);
        let v7 = &mut v3;
        internal_buy(v7, arg5, arg6, arg7, arg8);
        0x2::transfer::share_object<CreatorMarket>(v3);
    }

    public entry fun create_video(arg0: &mut VideoCatalog, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert_str_len(&arg2, 120);
        assert_valid_video_mode(arg5, arg6, arg7, arg8);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = VideoListing{
            id                    : 0x2::object::new(arg11),
            creator               : v0,
            walrus_blob_id        : arg1,
            title                 : arg2,
            description           : arg3,
            thumbnail_uri         : arg4,
            mode                  : arg5,
            rent_price_mist       : arg6,
            rent_duration_ms      : arg7,
            buy_price_mist        : arg8,
            published             : arg9,
            created_at_ms         : v1,
            updated_at_ms         : v1,
            creator_revenue_vault : 0x2::balance::zero<0x2::sui::SUI>(),
            rent_count            : 0,
            buy_count             : 0,
            tip_count             : 0,
            version               : 2,
        };
        let v3 = 0x2::object::id<VideoListing>(&v2);
        let v4 = VideoKey{id: v3};
        0x2::dynamic_field::add<VideoKey, bool>(&mut arg0.id, v4, true);
        arg0.video_count = arg0.video_count + 1;
        let v5 = VideoCreated{
            video_id       : v3,
            creator        : v0,
            walrus_blob_id : clone_bytes(&v2.walrus_blob_id),
            title          : clone_bytes(&v2.title),
            mode           : arg5,
            published      : arg9,
            timestamp_ms   : v1,
        };
        0x2::event::emit<VideoCreated>(v5);
        let v6 = VideoPublished{
            video_id         : v3,
            creator          : v0,
            mode             : arg5,
            rent_price_mist  : arg6,
            rent_duration_ms : arg7,
            buy_price_mist   : arg8,
            published        : arg9,
            timestamp_ms     : v1,
        };
        0x2::event::emit<VideoPublished>(v6);
        0x2::transfer::share_object<VideoListing>(v2);
    }

    fun effective_x(arg0: &CreatorMarket) : u128 {
        (arg0.v_sui_mist as u128) + (0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui) as u128)
    }

    fun effective_y(arg0: &CreatorMarket) : u128 {
        (arg0.v_tok_base as u128) + (arg0.supply as u128)
    }

    fun fee_amount(arg0: u64, arg1: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = if (arg0 > 0) {
            if (arg1 > 0) {
                v0 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            1
        } else {
            v0
        }
    }

    public fun get_market_id_by_creator(arg0: &CreatorRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        let v0 = CreatorKey{a: arg1};
        if (!0x2::dynamic_field::exists_<CreatorKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<CreatorKey, 0x2::object::ID>(&arg0.id, v0))
    }

    public fun get_market_id_by_symbol(arg0: &CreatorRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = symbol_key(&arg1);
        if (!0x2::dynamic_field::exists_<SymbolKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<SymbolKey, 0x2::object::ID>(&arg0.id, v0))
    }

    public fun get_market_stats(arg0: &CreatorMarket) : (u64, u64, u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui), arg0.supply, arg0.max_supply, price_fp(arg0), 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fee_vault), 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fee_vault))
    }

    public fun get_video_pass_policy_id(arg0: &GlobalConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.video_pass_policy_id
    }

    fun init(arg0: PLATFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PLATFORM>(arg0, arg1), v0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GlobalConfig{
            id                    : 0x2::object::new(arg1),
            admin                 : v0,
            token_decimals        : 9,
            max_supply_base       : 10000000000000000000,
            v_sui_mist            : 200000000000,
            v_tok_base            : 300000000000000,
            min_buy_mist          : 1000000000,
            video_admin_fee_vault : 0x2::balance::zero<0x2::sui::SUI>(),
            video_pass_policy_id  : 0x1::option::none<0x2::object::ID>(),
            version               : 2,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
        let v3 = CreatorRegistry{
            id           : 0x2::object::new(arg1),
            market_count : 0,
        };
        0x2::transfer::share_object<CreatorRegistry>(v3);
        let v4 = VideoCatalog{
            id          : 0x2::object::new(arg1),
            video_count : 0,
        };
        0x2::transfer::share_object<VideoCatalog>(v4);
    }

    public entry fun init_video_pass_policy(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &0x2::package::Publisher, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.admin, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.video_pass_policy_id), 16);
        let (v1, v2) = 0x2::transfer_policy::new<VideoPass>(arg2, arg4);
        let v3 = v1;
        let v4 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<VideoPass>>(&v3);
        arg1.video_pass_policy_id = 0x1::option::some<0x2::object::ID>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<VideoPass>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<VideoPass>>(v2, v0);
        let v5 = VideoPassPolicyInitialized{
            policy_id    : v4,
            admin        : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VideoPassPolicyInitialized>(v5);
    }

    fun internal_buy(arg0: &mut CreatorMarket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.min_buy_mist, 5);
        let v2 = fee_amount(v1, 100);
        let v3 = fee_amount(v1, 100);
        let v4 = fee_amount(v1, 100);
        let v5 = calc_tokens_out(arg0, v1 - v2 - v3 - v4);
        assert!(v5 > 0, 7);
        assert!(v5 >= arg2, 6);
        assert!(arg0.supply + v5 <= arg0.max_supply, 8);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_sui, v6);
        arg0.supply = arg0.supply + v5;
        arg0.trade_count = arg0.trade_count + 1;
        arg0.buy_count = arg0.buy_count + 1;
        let v7 = OwnerKey{a: v0};
        let v8 = 0x2::clock::timestamp_ms(arg3);
        if (!0x2::dynamic_field::exists_<OwnerKey>(&arg0.id, v7)) {
            arg0.holder_count = arg0.holder_count + 1;
            let v9 = Position{
                balance       : v5,
                created_at_ms : v8,
                updated_at_ms : v8,
            };
            0x2::dynamic_field::add<OwnerKey, Position>(&mut arg0.id, v7, v9);
        } else {
            let v10 = 0x2::dynamic_field::borrow_mut<OwnerKey, Position>(&mut arg0.id, v7);
            v10.balance = v10.balance + v5;
            v10.updated_at_ms = v8;
        };
        let v11 = PositionChanged{
            market_id          : market_id(arg0),
            owner              : v0,
            balance_after      : position_balance(arg0, v0),
            holder_count_after : arg0.holder_count,
            timestamp_ms       : v8,
        };
        0x2::event::emit<PositionChanged>(v11);
        let v12 = TradeEvent{
            market_id          : market_id(arg0),
            trader             : v0,
            is_buy             : true,
            sui_in_mist        : v1,
            tokens_out         : v5,
            tokens_in          : 0,
            payout_gross_mist  : 0,
            payout_net_mist    : 0,
            creator_fee_mist   : v2,
            admin_fee_mist     : v3,
            locked_fee_mist    : v4,
            reserve_after_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui),
            supply_after       : arg0.supply,
            price_after_fp     : price_fp(arg0),
            timestamp_ms       : v8,
        };
        0x2::event::emit<TradeEvent>(v12);
    }

    fun market_id(arg0: &CreatorMarket) : 0x2::object::ID {
        0x2::object::id<CreatorMarket>(arg0)
    }

    public fun position_balance(arg0: &CreatorMarket, arg1: address) : u64 {
        let v0 = OwnerKey{a: arg1};
        if (!0x2::dynamic_field::exists_<OwnerKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<OwnerKey, Position>(&arg0.id, v0).balance
    }

    fun price_fp(arg0: &CreatorMarket) : u64 {
        ((effective_x(arg0) * 1000000000 / effective_y(arg0)) as u64)
    }

    public entry fun publish_video(arg0: &mut VideoListing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 12);
        arg0.published = true;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = VideoPublished{
            video_id         : 0x2::object::id<VideoListing>(arg0),
            creator          : arg0.creator,
            mode             : arg0.mode,
            rent_price_mist  : arg0.rent_price_mist,
            rent_duration_ms : arg0.rent_duration_ms,
            buy_price_mist   : arg0.buy_price_mist,
            published        : true,
            timestamp_ms     : arg0.updated_at_ms,
        };
        0x2::event::emit<VideoPublished>(v0);
    }

    public fun quote_buy(arg0: &CreatorMarket, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = fee_amount(arg1, 100);
        let v1 = fee_amount(arg1, 100);
        let v2 = fee_amount(arg1, 100);
        let v3 = arg1 - v0 - v1 - v2;
        (calc_tokens_out(arg0, v3), v0, v1, v2, v3)
    }

    public fun quote_sell(arg0: &CreatorMarket, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = calc_sui_out(arg0, arg1);
        let v1 = fee_amount(v0, 100);
        let v2 = fee_amount(v0, 100);
        let v3 = fee_amount(v0, 100);
        (v0 - v1 - v2 - v3, v1, v2, v3, v0)
    }

    public entry fun rent_video(arg0: &mut GlobalConfig, arg1: &mut VideoListing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.published, 13);
        assert!(arg1.mode == 1, 14);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.rent_price_mist, 5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v1 = fee_amount(arg1.rent_price_mist, 100);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.rent_price_mist, arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.video_admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_revenue_vault, v2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = v3 + arg1.rent_duration_ms;
        arg1.rent_count = arg1.rent_count + 1;
        arg1.updated_at_ms = v3;
        let v5 = RentalReceipt{
            id            : 0x2::object::new(arg4),
            video_id      : 0x2::object::id<VideoListing>(arg1),
            creator       : arg1.creator,
            rented_at_ms  : v3,
            expires_at_ms : v4,
        };
        0x2::transfer::transfer<RentalReceipt>(v5, v0);
        let v6 = VideoRented{
            video_id       : 0x2::object::id<VideoListing>(arg1),
            creator        : arg1.creator,
            renter         : v0,
            price_mist     : arg1.rent_price_mist,
            admin_fee_mist : v1,
            expires_at_ms  : v4,
            timestamp_ms   : v3,
        };
        0x2::event::emit<VideoRented>(v6);
    }

    public fun rental_expires_at(arg0: &RentalReceipt) : u64 {
        arg0.expires_at_ms
    }

    public fun rental_is_valid(arg0: &RentalReceipt, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms
    }

    public entry fun sell(arg0: &mut CreatorMarket, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 > 0, 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = OwnerKey{a: v0};
        assert!(0x2::dynamic_field::exists_<OwnerKey>(&arg0.id, v2), 9);
        assert!(0x2::dynamic_field::borrow<OwnerKey, Position>(&arg0.id, v2).balance >= arg1, 10);
        let v3 = calc_sui_out(arg0, arg1);
        assert!(v3 > 0, 7);
        let v4 = fee_amount(v3, 100);
        let v5 = fee_amount(v3, 100);
        let v6 = fee_amount(v3, 100);
        let v7 = v3 - v4 - v5 - v6;
        assert!(v7 >= arg2, 6);
        let v8 = v7 + v4 + v5;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui) >= v8, 11);
        let v9 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve_sui, v8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v5));
        arg0.supply = arg0.supply - arg1;
        arg0.trade_count = arg0.trade_count + 1;
        arg0.sell_count = arg0.sell_count + 1;
        let v10 = 0x2::dynamic_field::borrow_mut<OwnerKey, Position>(&mut arg0.id, v2);
        v10.balance = v10.balance - arg1;
        v10.updated_at_ms = v1;
        if (0x2::dynamic_field::borrow<OwnerKey, Position>(&arg0.id, v2).balance == 0) {
            arg0.holder_count = arg0.holder_count - 1;
            0x2::dynamic_field::remove<OwnerKey, Position>(&mut arg0.id, v2);
        };
        let v11 = OwnerKey{a: v0};
        let v12 = if (0x2::dynamic_field::exists_<OwnerKey>(&arg0.id, v11)) {
            position_balance(arg0, v0)
        } else {
            0
        };
        let v13 = PositionChanged{
            market_id          : market_id(arg0),
            owner              : v0,
            balance_after      : v12,
            holder_count_after : arg0.holder_count,
            timestamp_ms       : v1,
        };
        0x2::event::emit<PositionChanged>(v13);
        let v14 = TradeEvent{
            market_id          : market_id(arg0),
            trader             : v0,
            is_buy             : false,
            sui_in_mist        : 0,
            tokens_out         : 0,
            tokens_in          : arg1,
            payout_gross_mist  : v3,
            payout_net_mist    : v7,
            creator_fee_mist   : v4,
            admin_fee_mist     : v5,
            locked_fee_mist    : v6,
            reserve_after_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui),
            supply_after       : arg0.supply,
            price_after_fp     : price_fp(arg0),
            timestamp_ms       : v1,
        };
        0x2::event::emit<TradeEvent>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg4), v0);
    }

    fun symbol_key(arg0: &vector<u8>) : SymbolKey {
        let v0 = 0x2::hash::blake2b256(arg0);
        SymbolKey{
            hi : u128_from_16(&v0, 0),
            lo : u128_from_16(&v0, 16),
        }
    }

    public entry fun tip_video(arg0: &mut GlobalConfig, arg1: &mut VideoListing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.published, 13);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = fee_amount(v0, 100);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.video_admin_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.creator_revenue_vault, v2);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        arg1.tip_count = arg1.tip_count + 1;
        arg1.updated_at_ms = v3;
        let v4 = VideoTipped{
            video_id       : 0x2::object::id<VideoListing>(arg1),
            creator        : arg1.creator,
            tipper         : 0x2::tx_context::sender(arg4),
            amount_mist    : v0,
            admin_fee_mist : v1,
            timestamp_ms   : v3,
        };
        0x2::event::emit<VideoTipped>(v4);
    }

    fun u128_from_16(arg0: &vector<u8>, arg1: u64) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun unpublish_video(arg0: &mut VideoListing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 12);
        arg0.published = false;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = VideoPublished{
            video_id         : 0x2::object::id<VideoListing>(arg0),
            creator          : arg0.creator,
            mode             : arg0.mode,
            rent_price_mist  : arg0.rent_price_mist,
            rent_duration_ms : arg0.rent_duration_ms,
            buy_price_mist   : arg0.buy_price_mist,
            published        : false,
            timestamp_ms     : arg0.updated_at_ms,
        };
        0x2::event::emit<VideoPublished>(v0);
    }

    public entry fun update_admin(arg0: &mut AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        arg0.admin = arg2;
        arg1.admin = arg2;
    }

    public entry fun update_video_listing(arg0: &mut VideoListing, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.creator, 12);
        assert_valid_video_mode(arg1, arg2, arg3, arg4);
        arg0.mode = arg1;
        arg0.rent_price_mist = arg2;
        arg0.rent_duration_ms = arg3;
        arg0.buy_price_mist = arg4;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = VideoPublished{
            video_id         : 0x2::object::id<VideoListing>(arg0),
            creator          : arg0.creator,
            mode             : arg1,
            rent_price_mist  : arg2,
            rent_duration_ms : arg3,
            buy_price_mist   : arg4,
            published        : arg0.published,
            timestamp_ms     : arg0.updated_at_ms,
        };
        0x2::event::emit<VideoPublished>(v0);
    }

    // decompiled from Move bytecode v6
}

