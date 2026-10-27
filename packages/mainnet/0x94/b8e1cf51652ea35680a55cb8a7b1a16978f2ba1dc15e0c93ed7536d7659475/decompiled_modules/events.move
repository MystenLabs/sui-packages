module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events {
    struct ConfigQueued has copy, drop {
        config: 0x2::object::ID,
        ready_ms: u64,
        treasury: address,
        fee_bps: u16,
    }

    struct ConfigApplied has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
        fee_bps: u16,
    }

    struct ConfigDiscarded has copy, drop {
        config: 0x2::object::ID,
    }

    struct ConfigPaused has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct ConfigMigrated has copy, drop {
        config: 0x2::object::ID,
        version: u64,
    }

    struct CollectionCreated has copy, drop {
        collection: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        max_supply: u64,
        ends_ms: u64,
        reserve: u64,
        random: bool,
        policy: 0x2::object::ID,
        royalty_bps: u16,
        royalty_min: u64,
        royalty_recipient: address,
        lock: bool,
        personal: bool,
        revealed: bool,
        metadata_root: 0x1::option::Option<vector<u8>>,
        provenance: 0x1::option::Option<vector<u8>>,
        payees: vector<address>,
        shares: vector<u64>,
    }

    struct PhaseSet has copy, drop {
        collection: 0x2::object::ID,
        index: u64,
        name: 0x1::string::String,
        start_ms: u64,
        end_ms: u64,
        price: u64,
        coin: 0x1::type_name::TypeName,
        per_wallet: u64,
        cap: u64,
        root: 0x1::option::Option<vector<u8>>,
    }

    struct Stocked has copy, drop {
        collection: 0x2::object::ID,
        stocked: u64,
        max_supply: u64,
    }

    struct CollectionPaused has copy, drop {
        collection: 0x2::object::ID,
        paused: bool,
        by_admin: bool,
    }

    struct PayeesSet has copy, drop {
        collection: 0x2::object::ID,
        payees: vector<address>,
        shares: vector<u64>,
    }

    struct RoyaltySet has copy, drop {
        collection: 0x2::object::ID,
        bps: 0x1::option::Option<u16>,
        min: 0x1::option::Option<u64>,
        recipient: address,
    }

    struct RoyaltiesClaimed has copy, drop {
        collection: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct PolicyCapReleased has copy, drop {
        collection: 0x2::object::ID,
    }

    struct Minted has copy, drop {
        collection: 0x2::object::ID,
        item: 0x2::object::ID,
        n: u64,
        to: address,
        kiosk: 0x1::option::Option<0x2::object::ID>,
        phase: 0x1::option::Option<u64>,
        price: u64,
        coin: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct Revealed has copy, drop {
        collection: 0x2::object::ID,
        base_uri: 0x1::string::String,
        ext: 0x1::string::String,
        metadata_root: 0x1::option::Option<vector<u8>>,
    }

    struct TraitsAttached has copy, drop {
        collection: 0x2::object::ID,
        item: 0x2::object::ID,
        n: u64,
    }

    struct Withdrawn has copy, drop {
        collection: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        gross: u64,
        fee: u64,
        treasury: address,
        payees: vector<address>,
        amounts: vector<u64>,
    }

    struct FeatureProposed has copy, drop {
        kind: 0x1::type_name::TypeName,
        proposer: address,
        name: 0x1::string::String,
        url: 0x1::string::String,
        collection: 0x1::option::Option<0x2::object::ID>,
    }

    struct FeatureApproved has copy, drop {
        kind: 0x1::type_name::TypeName,
    }

    struct FeatureRemoved has copy, drop {
        kind: 0x1::type_name::TypeName,
        by_admin: bool,
    }

    public(friend) fun collection_created(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: 0x2::object::ID, arg10: u16, arg11: u64, arg12: address, arg13: bool, arg14: bool, arg15: bool, arg16: 0x1::option::Option<vector<u8>>, arg17: 0x1::option::Option<vector<u8>>, arg18: vector<address>, arg19: vector<u64>) {
        let v0 = CollectionCreated{
            collection        : arg0,
            kind              : arg1,
            creator           : arg2,
            name              : arg3,
            symbol            : arg4,
            max_supply        : arg5,
            ends_ms           : arg6,
            reserve           : arg7,
            random            : arg8,
            policy            : arg9,
            royalty_bps       : arg10,
            royalty_min       : arg11,
            royalty_recipient : arg12,
            lock              : arg13,
            personal          : arg14,
            revealed          : arg15,
            metadata_root     : arg16,
            provenance        : arg17,
            payees            : arg18,
            shares            : arg19,
        };
        0x2::event::emit<CollectionCreated>(v0);
    }

    public(friend) fun collection_paused(arg0: 0x2::object::ID, arg1: bool, arg2: bool) {
        let v0 = CollectionPaused{
            collection : arg0,
            paused     : arg1,
            by_admin   : arg2,
        };
        0x2::event::emit<CollectionPaused>(v0);
    }

    public(friend) fun config_applied(arg0: 0x2::object::ID, arg1: address, arg2: u16) {
        let v0 = ConfigApplied{
            config   : arg0,
            treasury : arg1,
            fee_bps  : arg2,
        };
        0x2::event::emit<ConfigApplied>(v0);
    }

    public(friend) fun config_discarded(arg0: 0x2::object::ID) {
        let v0 = ConfigDiscarded{config: arg0};
        0x2::event::emit<ConfigDiscarded>(v0);
    }

    public(friend) fun config_migrated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ConfigMigrated{
            config  : arg0,
            version : arg1,
        };
        0x2::event::emit<ConfigMigrated>(v0);
    }

    public(friend) fun config_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ConfigPaused{
            config : arg0,
            paused : arg1,
        };
        0x2::event::emit<ConfigPaused>(v0);
    }

    public(friend) fun config_queued(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u16) {
        let v0 = ConfigQueued{
            config   : arg0,
            ready_ms : arg1,
            treasury : arg2,
            fee_bps  : arg3,
        };
        0x2::event::emit<ConfigQueued>(v0);
    }

    public(friend) fun feature_approved(arg0: 0x1::type_name::TypeName) {
        let v0 = FeatureApproved{kind: arg0};
        0x2::event::emit<FeatureApproved>(v0);
    }

    public(friend) fun feature_proposed(arg0: 0x1::type_name::TypeName, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x2::object::ID>) {
        let v0 = FeatureProposed{
            kind       : arg0,
            proposer   : arg1,
            name       : arg2,
            url        : arg3,
            collection : arg4,
        };
        0x2::event::emit<FeatureProposed>(v0);
    }

    public(friend) fun feature_removed(arg0: 0x1::type_name::TypeName, arg1: bool) {
        let v0 = FeatureRemoved{
            kind     : arg0,
            by_admin : arg1,
        };
        0x2::event::emit<FeatureRemoved>(v0);
    }

    public(friend) fun minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: 0x1::option::Option<0x1::type_name::TypeName>) {
        let v0 = Minted{
            collection : arg0,
            item       : arg1,
            n          : arg2,
            to         : arg3,
            kiosk      : arg4,
            phase      : arg5,
            price      : arg6,
            coin       : arg7,
        };
        0x2::event::emit<Minted>(v0);
    }

    public(friend) fun payees_set(arg0: 0x2::object::ID, arg1: vector<address>, arg2: vector<u64>) {
        let v0 = PayeesSet{
            collection : arg0,
            payees     : arg1,
            shares     : arg2,
        };
        0x2::event::emit<PayeesSet>(v0);
    }

    public(friend) fun phase_set(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::type_name::TypeName, arg7: u64, arg8: u64, arg9: 0x1::option::Option<vector<u8>>) {
        let v0 = PhaseSet{
            collection : arg0,
            index      : arg1,
            name       : arg2,
            start_ms   : arg3,
            end_ms     : arg4,
            price      : arg5,
            coin       : arg6,
            per_wallet : arg7,
            cap        : arg8,
            root       : arg9,
        };
        0x2::event::emit<PhaseSet>(v0);
    }

    public(friend) fun policy_cap_released(arg0: 0x2::object::ID) {
        let v0 = PolicyCapReleased{collection: arg0};
        0x2::event::emit<PolicyCapReleased>(v0);
    }

    public(friend) fun revealed(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<vector<u8>>) {
        let v0 = Revealed{
            collection    : arg0,
            base_uri      : arg1,
            ext           : arg2,
            metadata_root : arg3,
        };
        0x2::event::emit<Revealed>(v0);
    }

    public(friend) fun royalties_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = RoyaltiesClaimed{
            collection : arg0,
            amount     : arg1,
            recipient  : arg2,
        };
        0x2::event::emit<RoyaltiesClaimed>(v0);
    }

    public(friend) fun royalty_set(arg0: 0x2::object::ID, arg1: 0x1::option::Option<u16>, arg2: 0x1::option::Option<u64>, arg3: address) {
        let v0 = RoyaltySet{
            collection : arg0,
            bps        : arg1,
            min        : arg2,
            recipient  : arg3,
        };
        0x2::event::emit<RoyaltySet>(v0);
    }

    public(friend) fun stocked(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = Stocked{
            collection : arg0,
            stocked    : arg1,
            max_supply : arg2,
        };
        0x2::event::emit<Stocked>(v0);
    }

    public(friend) fun traits_attached(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = TraitsAttached{
            collection : arg0,
            item       : arg1,
            n          : arg2,
        };
        0x2::event::emit<TraitsAttached>(v0);
    }

    public(friend) fun withdrawn(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: address, arg5: vector<address>, arg6: vector<u64>) {
        let v0 = Withdrawn{
            collection : arg0,
            coin       : arg1,
            gross      : arg2,
            fee        : arg3,
            treasury   : arg4,
            payees     : arg5,
            amounts    : arg6,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

