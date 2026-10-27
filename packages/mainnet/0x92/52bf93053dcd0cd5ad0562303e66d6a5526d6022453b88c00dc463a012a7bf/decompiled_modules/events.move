module 0x9252bf93053dcd0cd5ad0562303e66d6a5526d6022453b88c00dc463a012a7bf::events {
    struct StudioRegistered has copy, drop {
        studio: 0x2::object::ID,
        cap: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
    }

    struct StudioUpdated has copy, drop {
        studio: 0x2::object::ID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct GameCreated has copy, drop {
        game: 0x2::object::ID,
        studio: 0x2::object::ID,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        price_usd: u64,
    }

    struct GameUpdated has copy, drop {
        game: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        price_usd: u64,
        sale_price_usd: u64,
        sale_ends_ms: u64,
        accept_sui: bool,
        listed: bool,
        launch_check: bool,
    }

    struct GameBlocked has copy, drop {
        game: 0x2::object::ID,
        blocked: bool,
    }

    struct ReleasePublished has copy, drop {
        game: 0x2::object::ID,
        version: u64,
        label: 0x1::string::String,
        edition: u64,
        platforms: vector<0x1::string::String>,
        sha256: vector<vector<u8>>,
        sizes: vector<u64>,
        paths: vector<0x1::string::String>,
    }

    struct ResaleTermsSet has copy, drop {
        game: 0x2::object::ID,
        enabled: bool,
        royalty_bps: u64,
        min_hold_ms: u64,
        min_royalty_mist: u64,
        royalty_to: address,
    }

    struct Purchased has copy, drop {
        licence: 0x2::object::ID,
        game: 0x2::object::ID,
        buyer: address,
        coin: u8,
        amount: u64,
        price_usd: u64,
        price_e8: u64,
        fee_bps: u64,
        edition: u64,
        version: u64,
        release_at_ms: u64,
        purchased_at_ms: u64,
        number: u64,
    }

    struct Refunded has copy, drop {
        licence: 0x2::object::ID,
        game: 0x2::object::ID,
        buyer: address,
        coin: u8,
        amount: u64,
    }

    struct EscrowReleased has copy, drop {
        licence: 0x2::object::ID,
        game: 0x2::object::ID,
        coin: u8,
        amount: u64,
        fee: u64,
    }

    struct Withdrawn has copy, drop {
        game: 0x2::object::ID,
        coin: u8,
        amount: u64,
        by: address,
    }

    struct MadeTradable has copy, drop {
        licence: 0x2::object::ID,
        resale_licence: 0x2::object::ID,
        game: 0x2::object::ID,
        owner: address,
        kiosk: 0x2::object::ID,
    }

    struct Resold has copy, drop {
        licence: 0x2::object::ID,
        game: 0x2::object::ID,
        paid: u64,
        royalty: u64,
        royalty_to: address,
        kiosk: 0x2::object::ID,
        held_ms: u64,
    }

    struct StorePaused has copy, drop {
        paused: bool,
    }

    struct TreasurySet has copy, drop {
        treasury: address,
    }

    struct FeeSet has copy, drop {
        fee_bps: u64,
    }

    struct RefundWindowSet has copy, drop {
        refund_window_ms: u64,
    }

    struct OracleParamsSet has copy, drop {
        max_age_s: u64,
        max_conf_bps: u64,
        min_price_e8: u64,
        max_price_e8: u64,
    }

    public(friend) fun escrow_released(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = EscrowReleased{
            licence : arg0,
            game    : arg1,
            coin    : arg2,
            amount  : arg3,
            fee     : arg4,
        };
        0x2::event::emit<EscrowReleased>(v0);
    }

    public(friend) fun fee_set(arg0: u64) {
        let v0 = FeeSet{fee_bps: arg0};
        0x2::event::emit<FeeSet>(v0);
    }

    public(friend) fun game_blocked(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = GameBlocked{
            game    : arg0,
            blocked : arg1,
        };
        0x2::event::emit<GameBlocked>(v0);
    }

    public(friend) fun game_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) {
        let v0 = GameCreated{
            game      : arg0,
            studio    : arg1,
            slug      : arg2,
            name      : arg3,
            price_usd : arg4,
        };
        0x2::event::emit<GameCreated>(v0);
    }

    public(friend) fun game_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool) {
        let v0 = GameUpdated{
            game           : arg0,
            name           : arg1,
            image_url      : arg2,
            metadata_url   : arg3,
            price_usd      : arg4,
            sale_price_usd : arg5,
            sale_ends_ms   : arg6,
            accept_sui     : arg7,
            listed         : arg8,
            launch_check   : arg9,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    public(friend) fun made_tradable(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::object::ID) {
        let v0 = MadeTradable{
            licence        : arg0,
            resale_licence : arg1,
            game           : arg2,
            owner          : arg3,
            kiosk          : arg4,
        };
        0x2::event::emit<MadeTradable>(v0);
    }

    public(friend) fun oracle_params_set(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = OracleParamsSet{
            max_age_s    : arg0,
            max_conf_bps : arg1,
            min_price_e8 : arg2,
            max_price_e8 : arg3,
        };
        0x2::event::emit<OracleParamsSet>(v0);
    }

    public(friend) fun purchased(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = Purchased{
            licence         : arg0,
            game            : arg1,
            buyer           : arg2,
            coin            : arg3,
            amount          : arg4,
            price_usd       : arg5,
            price_e8        : arg6,
            fee_bps         : arg7,
            edition         : arg8,
            version         : arg9,
            release_at_ms   : arg10,
            purchased_at_ms : arg11,
            number          : arg12,
        };
        0x2::event::emit<Purchased>(v0);
    }

    public(friend) fun refund_window_set(arg0: u64) {
        let v0 = RefundWindowSet{refund_window_ms: arg0};
        0x2::event::emit<RefundWindowSet>(v0);
    }

    public(friend) fun refunded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64) {
        let v0 = Refunded{
            licence : arg0,
            game    : arg1,
            buyer   : arg2,
            coin    : arg3,
            amount  : arg4,
        };
        0x2::event::emit<Refunded>(v0);
    }

    public(friend) fun release_published(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: vector<0x1::string::String>, arg5: vector<vector<u8>>, arg6: vector<u64>, arg7: vector<0x1::string::String>) {
        let v0 = ReleasePublished{
            game      : arg0,
            version   : arg1,
            label     : arg2,
            edition   : arg3,
            platforms : arg4,
            sha256    : arg5,
            sizes     : arg6,
            paths     : arg7,
        };
        0x2::event::emit<ReleasePublished>(v0);
    }

    public(friend) fun resale_terms_set(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: address) {
        let v0 = ResaleTermsSet{
            game             : arg0,
            enabled          : arg1,
            royalty_bps      : arg2,
            min_hold_ms      : arg3,
            min_royalty_mist : arg4,
            royalty_to       : arg5,
        };
        0x2::event::emit<ResaleTermsSet>(v0);
    }

    public(friend) fun resold(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: 0x2::object::ID, arg6: u64) {
        let v0 = Resold{
            licence    : arg0,
            game       : arg1,
            paid       : arg2,
            royalty    : arg3,
            royalty_to : arg4,
            kiosk      : arg5,
            held_ms    : arg6,
        };
        0x2::event::emit<Resold>(v0);
    }

    public(friend) fun store_paused(arg0: bool) {
        let v0 = StorePaused{paused: arg0};
        0x2::event::emit<StorePaused>(v0);
    }

    public(friend) fun studio_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address) {
        let v0 = StudioRegistered{
            studio : arg0,
            cap    : arg1,
            name   : arg2,
            owner  : arg3,
        };
        0x2::event::emit<StudioRegistered>(v0);
    }

    public(friend) fun studio_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = StudioUpdated{
            studio : arg0,
            name   : arg1,
            url    : arg2,
        };
        0x2::event::emit<StudioUpdated>(v0);
    }

    public(friend) fun treasury_set(arg0: address) {
        let v0 = TreasurySet{treasury: arg0};
        0x2::event::emit<TreasurySet>(v0);
    }

    public(friend) fun withdrawn(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address) {
        let v0 = Withdrawn{
            game   : arg0,
            coin   : arg1,
            amount : arg2,
            by     : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

