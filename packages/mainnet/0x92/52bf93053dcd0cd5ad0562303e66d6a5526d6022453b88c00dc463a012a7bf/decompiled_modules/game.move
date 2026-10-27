module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::game {
    struct Build has copy, drop, store {
        platform: 0x1::string::String,
        sha256: vector<u8>,
        size: u64,
        path: 0x1::string::String,
    }

    struct Release has copy, drop, store {
        version: u64,
        label: 0x1::string::String,
        edition: u64,
        builds: vector<Build>,
        published_at_ms: u64,
    }

    struct ResaleTerms has copy, drop, store {
        enabled: bool,
        royalty_bps: u64,
        min_hold_ms: u64,
        min_royalty_mist: u64,
        royalty_to: address,
    }

    struct Sale has copy, drop, store {
        buyer: address,
        coin: u8,
        amount: u64,
        price_usd: u64,
        fee_bps: u64,
        release_at_ms: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        version: u64,
        studio: 0x2::object::ID,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        price_usd: u64,
        sale_price_usd: u64,
        sale_ends_ms: u64,
        accept_sui: bool,
        listed: bool,
        blocked: bool,
        launch_check: bool,
        edition: u64,
        latest: 0x1::option::Option<Release>,
        editions: 0x2::table::Table<u64, Release>,
        resale: ResaleTerms,
        sales: u64,
        refunds: u64,
        sold_usd: u64,
        escrow: 0x2::table::Table<0x2::object::ID, Sale>,
        escrow_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        revenue_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UsdcEscrow has copy, drop, store {
        dummy_field: bool,
    }

    struct UsdcRevenue has copy, drop, store {
        dummy_field: bool,
    }

    public fun accept_sui(arg0: &Game) : bool {
        arg0.accept_sui
    }

    fun after_mint(arg0: &Game, arg1: 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::purchased(0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&arg1), 0x2::object::id<Game>(arg0), 0x2::tx_context::sender(arg9), arg2, arg3, arg4, arg5, arg6, 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::edition(&arg1), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::version(&arg1), arg7, 0x2::clock::timestamp_ms(arg8), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::number(&arg1));
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::send(arg1, 0x2::tx_context::sender(arg9));
    }

    public(friend) fun assert_current(arg0: &Game) {
        assert!(arg0.version == 1, 401);
    }

    fun assert_owner(arg0: &Game, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap) {
        assert_current(arg0);
        assert!(0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::cap_studio(arg1) == arg0.studio, 402);
    }

    public fun studio(arg0: &Game) : 0x2::object::ID {
        arg0.studio
    }

    fun assert_sellable(arg0: &Game) {
        assert_current(arg0);
        assert!(!arg0.blocked, 406);
        assert!(arg0.listed && 0x1::option::is_some<Release>(&arg0.latest), 405);
    }

    public fun blocked(arg0: &Game) : bool {
        arg0.blocked
    }

    public fun build_path(arg0: &Build) : 0x1::string::String {
        arg0.path
    }

    public fun build_platform(arg0: &Build) : 0x1::string::String {
        arg0.platform
    }

    public fun build_sha256(arg0: &Build) : vector<u8> {
        arg0.sha256
    }

    public fun build_size(arg0: &Build) : u64 {
        arg0.size
    }

    public fun buy_sui(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        buy_sui_at(arg0, arg1, arg2, &v0, arg4, arg5)
    }

    fun buy_sui_at(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        assert_sellable(arg1);
        assert!(arg1.accept_sui, 411);
        let v0 = current_price_usd(arg1, arg4);
        assert!(v0 > 0, 413);
        let v1 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::read_price(arg0, arg3, arg4);
        let v2 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::usd_to_mist(v0, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 412);
        let (v3, v4) = mint(arg1, arg0, 0, v2, v0, arg4, arg5);
        let v5 = v3;
        if (v4 == 0x2::clock::timestamp_ms(arg4)) {
            settle_sui(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v2), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::fee_bps(arg0), arg5);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.escrow_sui, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v2));
        };
        after_mint(arg1, v5, 0, v2, v0, v1, 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::fee_bps(arg0), v4, arg4, arg5);
        0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&v5)
    }

    public fun buy_usdc<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_usdc<T0>(arg0);
        assert_sellable(arg1);
        let v0 = current_price_usd(arg1, arg3);
        assert!(v0 > 0, 413);
        assert!(0x2::coin::value<T0>(arg2) >= v0, 412);
        let (v1, v2) = mint(arg1, arg0, 1, v0, v0, arg3, arg4);
        let v3 = v1;
        if (v2 == 0x2::clock::timestamp_ms(arg3)) {
            settle_usdc<T0>(arg0, arg1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), v0), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::fee_bps(arg0), arg4);
        } else {
            let v4 = UsdcEscrow{dummy_field: false};
            let v5 = usdc_mut<T0, UsdcEscrow>(arg1, v4);
            0x2::balance::join<T0>(v5, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), v0));
        };
        after_mint(arg1, v3, 1, v0, v0, 0, 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::fee_bps(arg0), v2, arg3, arg4);
        0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&v3)
    }

    fun check_details(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= 128, 403);
        assert!(0x1::string::length(arg1) <= 512 && 0x1::string::length(arg2) <= 512, 403);
    }

    fun check_slug(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 > 0 && v1 <= 64, 404);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 == 45) {
                if (v2 > 0) {
                    v2 + 1 < v1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 404);
            v2 = v2 + 1;
        };
    }

    public fun claim_free(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        assert_sellable(arg1);
        assert!(current_price_usd(arg1, arg2) == 0, 414);
        let (v0, _) = mint(arg1, arg0, 1, 0, 0, arg2, arg3);
        let v2 = v0;
        after_mint(arg1, v2, 1, 0, 0, 0, 0, 0x2::clock::timestamp_ms(arg2), arg2, arg3);
        0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&v2)
    }

    public fun create_game(arg0: &mut 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::Studio, arg2: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::assert_cap(arg1, arg2);
        check_slug(&arg3);
        check_details(&arg4, &arg5, &arg6);
        let v0 = ResaleTerms{
            enabled          : false,
            royalty_bps      : 0,
            min_hold_ms      : 0,
            min_royalty_mist : 0,
            royalty_to       : 0x2::tx_context::sender(arg9),
        };
        let v1 = Game{
            id             : 0x2::object::new(arg9),
            version        : 1,
            studio         : 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::Studio>(arg1),
            slug           : arg3,
            name           : arg4,
            image_url      : arg5,
            metadata_url   : arg6,
            price_usd      : arg7,
            sale_price_usd : 0,
            sale_ends_ms   : 0,
            accept_sui     : arg8,
            listed         : false,
            blocked        : false,
            launch_check   : false,
            edition        : 1,
            latest         : 0x1::option::none<Release>(),
            editions       : 0x2::table::new<u64, Release>(arg9),
            resale         : v0,
            sales          : 0,
            refunds        : 0,
            sold_usd       : 0,
            escrow         : 0x2::table::new<0x2::object::ID, Sale>(arg9),
            escrow_sui     : 0x2::balance::zero<0x2::sui::SUI>(),
            revenue_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x2::object::id<Game>(&v1);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::add_slug(arg0, arg3, v2);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::add_game(arg1, v2);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::game_created(v2, 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::Studio>(arg1), arg3, arg4, arg7);
        updated(&v1);
        0x2::transfer::share_object<Game>(v1);
        v2
    }

    public fun current_price_usd(arg0: &Game, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.sale_price_usd > 0 && 0x2::clock::timestamp_ms(arg1) < arg0.sale_ends_ms) {
            arg0.sale_price_usd
        } else {
            arg0.price_usd
        }
    }

    public fun edition(arg0: &Game) : u64 {
        arg0.edition
    }

    public fun escrow_count(arg0: &Game) : u64 {
        0x2::table::length<0x2::object::ID, Sale>(&arg0.escrow)
    }

    public fun escrow_sui(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow_sui)
    }

    public fun escrow_usdc<T0>(arg0: &Game) : u64 {
        let v0 = UsdcEscrow{dummy_field: false};
        usdc_value<T0, UsdcEscrow>(arg0, v0)
    }

    public fun escrowed(arg0: &Game, arg1: 0x2::object::ID) : (address, u8, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Sale>(&arg0.escrow, arg1);
        (v0.buyer, v0.coin, v0.amount, v0.release_at_ms)
    }

    public(friend) fun finalize<T0>(arg0: &mut Game, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, Sale>(&arg0.escrow, arg2)) {
            return
        };
        let v0 = 0x2::table::remove<0x2::object::ID, Sale>(&mut arg0.escrow, arg2);
        let v1 = 0x2::object::id<Game>(arg0);
        if (v0.coin == 0) {
            let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow_sui, v0.amount);
            settle_sui(arg1, arg0, v2, v0.fee_bps, arg3);
        } else {
            let v3 = UsdcEscrow{dummy_field: false};
            let v4 = usdc_mut<T0, UsdcEscrow>(arg0, v3);
            settle_usdc<T0>(arg1, arg0, 0x2::balance::split<T0>(v4, v0.amount), v0.fee_bps, arg3);
        };
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::escrow_released(arg2, v1, v0.coin, v0.amount, 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::bps_of(v0.amount, v0.fee_bps));
    }

    public fun image_url(arg0: &Game) : 0x1::string::String {
        arg0.image_url
    }

    public fun in_escrow(arg0: &Game, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Sale>(&arg0.escrow, arg1)
    }

    public fun latest(arg0: &Game) : 0x1::option::Option<Release> {
        arg0.latest
    }

    public fun launch_check(arg0: &Game) : bool {
        arg0.launch_check
    }

    public fun listed(arg0: &Game) : bool {
        arg0.listed
    }

    public fun metadata_url(arg0: &Game) : 0x1::string::String {
        arg0.metadata_url
    }

    public fun migrate(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::AdminCap, arg1: &mut Game) {
        assert!(arg1.version < 1, 408);
        arg1.version = 1;
    }

    public fun min_hold_ms(arg0: &ResaleTerms) : u64 {
        arg0.min_hold_ms
    }

    public fun min_royalty_mist(arg0: &ResaleTerms) : u64 {
        arg0.min_royalty_mist
    }

    fun mint(arg0: &mut Game, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.sales = arg0.sales + 1;
        arg0.sold_usd = arg0.sold_usd + arg4;
        let v1 = 0x1::option::borrow<Release>(&arg0.latest);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<Build>(&v1.builds)) {
            0x1::vector::push_back<vector<u8>>(&mut v2, 0x1::vector::borrow<Build>(&v1.builds, v3).sha256);
            v3 = v3 + 1;
        };
        let v4 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::new(0x2::object::id<Game>(arg0), arg0.slug, arg0.name, arg0.image_url, v1.edition, v1.version, v2, v0, arg0.sales, arg6);
        let v5 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::refund_window_ms(arg1);
        let v6 = if (v5 == 0 || arg3 == 0) {
            v0
        } else {
            v0 + v5
        };
        if (v6 != v0) {
            let v7 = Sale{
                buyer         : 0x2::tx_context::sender(arg6),
                coin          : arg2,
                amount        : arg3,
                price_usd     : arg4,
                fee_bps       : 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::fee_bps(arg1),
                release_at_ms : v6,
            };
            0x2::table::add<0x2::object::ID, Sale>(&mut arg0.escrow, 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&v4), v7);
        };
        (v4, v6)
    }

    public fun name(arg0: &Game) : 0x1::string::String {
        arg0.name
    }

    public fun price_usd(arg0: &Game) : u64 {
        arg0.price_usd
    }

    public fun publish_release(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg2: &mut Game, arg3: u64, arg4: 0x1::string::String, arg5: bool, arg6: vector<0x1::string::String>, arg7: vector<vector<u8>>, arg8: vector<u64>, arg9: vector<0x1::string::String>, arg10: &0x2::clock::Clock) {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_live(arg1);
        assert_owner(arg2, arg0);
        if (0x1::option::is_some<Release>(&arg2.latest)) {
            assert!(arg3 > 0x1::option::borrow<Release>(&arg2.latest).version, 408);
            if (arg5) {
                arg2.edition = arg2.edition + 1;
            };
        };
        assert!(0x1::string::length(&arg4) <= 32, 403);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg6);
        assert!(v0 > 0 && v0 <= 16, 409);
        let v1 = if (0x1::vector::length<vector<u8>>(&arg7) == v0) {
            if (0x1::vector::length<u64>(&arg8) == v0) {
                0x1::vector::length<0x1::string::String>(&arg9) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 409);
        let v2 = 0x1::vector::empty<Build>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg6, v3);
            assert!(0x1::string::length(&v4) > 0 && 0x1::string::length(&v4) <= 32, 409);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg7, v3)) == 32, 409);
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg9, v3)) > 0 && 0x1::string::length(0x1::vector::borrow<0x1::string::String>(&arg9, v3)) <= 512, 409);
            let v5 = 0;
            while (v5 < v3) {
                assert!(*0x1::vector::borrow<0x1::string::String>(&arg6, v5) != v4, 409);
                v5 = v5 + 1;
            };
            let v6 = Build{
                platform : v4,
                sha256   : *0x1::vector::borrow<vector<u8>>(&arg7, v3),
                size     : *0x1::vector::borrow<u64>(&arg8, v3),
                path     : *0x1::vector::borrow<0x1::string::String>(&arg9, v3),
            };
            0x1::vector::push_back<Build>(&mut v2, v6);
            v3 = v3 + 1;
        };
        let v7 = Release{
            version         : arg3,
            label           : arg4,
            edition         : arg2.edition,
            builds          : v2,
            published_at_ms : 0x2::clock::timestamp_ms(arg10),
        };
        if (0x2::table::contains<u64, Release>(&arg2.editions, arg2.edition)) {
            *0x2::table::borrow_mut<u64, Release>(&mut arg2.editions, arg2.edition) = v7;
        } else {
            0x2::table::add<u64, Release>(&mut arg2.editions, arg2.edition, v7);
        };
        arg2.latest = 0x1::option::some<Release>(v7);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::release_published(0x2::object::id<Game>(arg2), arg3, arg4, arg2.edition, arg6, arg7, arg8, arg9);
    }

    public fun refund<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_current(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_usdc<T0>(arg0);
        assert_current(arg1);
        let v0 = 0x2::object::id<Game>(arg1);
        assert!(0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::game(&arg2) == v0, 415);
        let v1 = 0x2::object::id<0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::Licence>(&arg2);
        assert!(0x2::table::contains<0x2::object::ID, Sale>(&arg1.escrow, v1), 416);
        let v2 = 0x2::table::remove<0x2::object::ID, Sale>(&mut arg1.escrow, v1);
        assert!(0x2::clock::timestamp_ms(arg3) < v2.release_at_ms, 417);
        if (v2.coin == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow_sui, v2.amount), arg4), v2.buyer);
        } else {
            let v3 = UsdcEscrow{dummy_field: false};
            let v4 = usdc_mut<T0, UsdcEscrow>(arg1, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, v2.amount), arg4), v2.buyer);
        };
        arg1.refunds = arg1.refunds + 1;
        arg1.sold_usd = arg1.sold_usd - v2.price_usd;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::licence::burn(arg2);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::refunded(v1, v0, v2.buyer, v2.coin, v2.amount);
    }

    public fun refunds(arg0: &Game) : u64 {
        arg0.refunds
    }

    public fun release<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_current(arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_usdc<T0>(arg0);
        assert_current(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0x2::table::contains<0x2::object::ID, Sale>(&arg1.escrow, v1) && 0x2::clock::timestamp_ms(arg3) >= 0x2::table::borrow<0x2::object::ID, Sale>(&arg1.escrow, v1).release_at_ms) {
                finalize<T0>(arg1, arg0, v1, arg4);
            };
            v0 = v0 + 1;
        };
    }

    public fun release_builds(arg0: &Release) : vector<Build> {
        arg0.builds
    }

    public fun release_edition(arg0: &Release) : u64 {
        arg0.edition
    }

    public fun release_for(arg0: &Game, arg1: u64) : 0x1::option::Option<Release> {
        if (0x2::table::contains<u64, Release>(&arg0.editions, arg1)) {
            0x1::option::some<Release>(*0x2::table::borrow<u64, Release>(&arg0.editions, arg1))
        } else {
            0x1::option::none<Release>()
        }
    }

    public fun release_label(arg0: &Release) : 0x1::string::String {
        arg0.label
    }

    public fun release_version(arg0: &Release) : u64 {
        arg0.version
    }

    public fun resale_enabled(arg0: &ResaleTerms) : bool {
        arg0.enabled
    }

    public fun resale_terms(arg0: &Game) : ResaleTerms {
        arg0.resale
    }

    public fun revenue_sui(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.revenue_sui)
    }

    public fun revenue_usdc<T0>(arg0: &Game) : u64 {
        let v0 = UsdcRevenue{dummy_field: false};
        usdc_value<T0, UsdcRevenue>(arg0, v0)
    }

    public fun royalty_bps(arg0: &ResaleTerms) : u64 {
        arg0.royalty_bps
    }

    public fun royalty_due(arg0: &ResaleTerms, arg1: u64) : u64 {
        let v0 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::bps_of(arg1, arg0.royalty_bps);
        if (v0 < arg0.min_royalty_mist) {
            arg0.min_royalty_mist
        } else {
            v0
        }
    }

    public fun royalty_to(arg0: &ResaleTerms) : address {
        arg0.royalty_to
    }

    public fun sale(arg0: &Game) : (u64, u64) {
        (arg0.sale_price_usd, arg0.sale_ends_ms)
    }

    public fun sales(arg0: &Game) : u64 {
        arg0.sales
    }

    public fun set_blocked(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::AdminCap, arg1: &mut Game, arg2: bool) {
        arg1.blocked = arg2;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::game_blocked(0x2::object::id<Game>(arg1), arg2);
    }

    public fun set_details(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        assert_owner(arg1, arg0);
        check_details(&arg2, &arg3, &arg4);
        arg1.name = arg2;
        arg1.image_url = arg3;
        arg1.metadata_url = arg4;
        updated(arg1);
    }

    public fun set_launch_check(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: bool) {
        assert_owner(arg1, arg0);
        arg1.launch_check = arg2;
        updated(arg1);
    }

    public fun set_listed(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: bool) {
        assert_owner(arg1, arg0);
        assert!(!arg2 || 0x1::option::is_some<Release>(&arg1.latest), 407);
        arg1.listed = arg2;
        updated(arg1);
    }

    public fun set_price(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: u64, arg3: bool) {
        assert_owner(arg1, arg0);
        arg1.price_usd = arg2;
        arg1.accept_sui = arg3;
        if (arg1.sale_price_usd >= arg2) {
            arg1.sale_price_usd = 0;
            arg1.sale_ends_ms = 0;
        };
        updated(arg1);
    }

    public fun set_resale(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        assert_owner(arg1, arg0);
        assert!(arg3 <= 5000 && arg4 <= 31536000000, 418);
        let v0 = ResaleTerms{
            enabled          : arg2,
            royalty_bps      : arg3,
            min_hold_ms      : arg4,
            min_royalty_mist : arg5,
            royalty_to       : arg6,
        };
        arg1.resale = v0;
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::resale_terms_set(0x2::object::id<Game>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_sale(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: u64, arg3: u64) {
        assert_owner(arg1, arg0);
        if (arg2 == 0) {
            arg1.sale_ends_ms = 0;
        } else {
            assert!(arg2 < arg1.price_usd, 410);
            arg1.sale_ends_ms = arg3;
        };
        arg1.sale_price_usd = arg2;
        updated(arg1);
    }

    fun settle_sui(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::bps_of(0x2::balance::value<0x2::sui::SUI>(&arg2), arg3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, v0), arg4), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::treasury(arg0));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.revenue_sui, arg2);
    }

    fun settle_usdc<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg1: &mut Game, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::bps_of(0x2::balance::value<T0>(&arg2), arg3);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v0), arg4), 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::treasury(arg0));
        };
        let v1 = UsdcRevenue{dummy_field: false};
        0x2::balance::join<T0>(usdc_mut<T0, UsdcRevenue>(arg1, v1), arg2);
    }

    public fun slug(arg0: &Game) : 0x1::string::String {
        arg0.slug
    }

    public fun sold_usd(arg0: &Game) : u64 {
        arg0.sold_usd
    }

    fun updated(arg0: &Game) {
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::game_updated(0x2::object::id<Game>(arg0), arg0.name, arg0.image_url, arg0.metadata_url, arg0.price_usd, arg0.sale_price_usd, arg0.sale_ends_ms, arg0.accept_sui, arg0.listed, arg0.launch_check);
    }

    fun usdc_mut<T0, T1: copy + drop + store>(arg0: &mut Game, arg1: T1) : &mut 0x2::balance::Balance<T0> {
        if (!0x2::dynamic_field::exists<T1>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<T1, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<T1, 0x2::balance::Balance<T0>>(&mut arg0.id, arg1)
    }

    fun usdc_value<T0, T1: copy + drop + store>(arg0: &Game, arg1: T1) : u64 {
        if (0x2::dynamic_field::exists<T1>(&arg0.id, arg1)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<T1, 0x2::balance::Balance<T0>>(&arg0.id, arg1))
        } else {
            0
        }
    }

    public fun withdraw_sui(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &mut Game, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_owner(arg1, arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::withdrawn(0x2::object::id<Game>(arg1), 0, 0x2::balance::value<0x2::sui::SUI>(&arg1.revenue_sui), 0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.revenue_sui), arg2)
    }

    public fun withdraw_usdc<T0>(arg0: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::studio::StudioCap, arg1: &0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::Store, arg2: &mut Game, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg2, arg0);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::store::assert_usdc<T0>(arg1);
        let v0 = UsdcRevenue{dummy_field: false};
        let v1 = usdc_mut<T0, UsdcRevenue>(arg2, v0);
        let v2 = 0x2::balance::withdraw_all<T0>(v1);
        0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events::withdrawn(0x2::object::id<Game>(arg2), 1, 0x2::balance::value<T0>(&v2), 0x2::tx_context::sender(arg3));
        0x2::coin::from_balance<T0>(v2, arg3)
    }

    // decompiled from Move bytecode v7
}

