module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground {
    struct PublishedApp has key {
        id: 0x2::object::UID,
        builder: address,
        name: 0x1::string::String,
        prompt: 0x1::string::String,
        manifest_blob: 0x1::string::String,
        archive_blob: 0x1::string::String,
        tree_hash: 0x1::string::String,
        parent: 0x1::option::Option<0x2::object::ID>,
        category: 0x1::string::String,
        visits: u64,
        stars: u64,
        tips_total: u64,
        created_at_ms: u64,
    }

    struct StarRegistry has key {
        id: 0x2::object::UID,
        starred: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<address>>,
    }

    struct BuilderProfile has copy, drop, store {
        apps_published: u64,
        stars_received: u64,
        remixes_received: u64,
        score: u64,
    }

    struct BuilderBoard has key {
        id: 0x2::object::UID,
        builders: 0x2::table::Table<address, BuilderProfile>,
    }

    struct FlagRegistry has key {
        id: 0x2::object::UID,
        flags: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<address>>,
        hidden: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct NameRegistry has key {
        id: 0x2::object::UID,
        owner_of: 0x2::table::Table<0x1::string::String, address>,
        name_of: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AppPublished has copy, drop {
        app_id: 0x2::object::ID,
        builder: address,
        name: 0x1::string::String,
        parent: 0x1::option::Option<0x2::object::ID>,
        manifest_blob: 0x1::string::String,
        created_at_ms: u64,
    }

    struct AppVisited has copy, drop {
        app_id: 0x2::object::ID,
        visits: u64,
    }

    struct AppStarred has copy, drop {
        app_id: 0x2::object::ID,
        by: address,
        stars: u64,
    }

    struct AppRemixed has copy, drop {
        parent: 0x2::object::ID,
        child: 0x2::object::ID,
        builder: address,
    }

    struct AppTipped has copy, drop {
        app_id: 0x2::object::ID,
        from: address,
        amount: u64,
        fee: u64,
    }

    struct AppFlagged has copy, drop {
        app_id: 0x2::object::ID,
        by: address,
        flags: u64,
    }

    struct AppHidden has copy, drop {
        app_id: 0x2::object::ID,
        hidden: bool,
    }

    struct AppUpdated has copy, drop {
        app_id: 0x2::object::ID,
        tree_hash: 0x1::string::String,
        updated_at_ms: u64,
    }

    struct NameClaimed has copy, drop {
        name: 0x1::string::String,
        owner: address,
    }

    struct NameReleased has copy, drop {
        name: 0x1::string::String,
        owner: address,
    }

    struct TreasuryWithdrawn has copy, drop {
        to: address,
        amount: u64,
    }

    struct BuilderScored has copy, drop {
        builder: address,
        score: u64,
        apps: u64,
        stars: u64,
        remixes: u64,
    }

    public fun builder(arg0: &PublishedApp) : address {
        arg0.builder
    }

    public fun builder_apps(arg0: &BuilderBoard, arg1: address) : u64 {
        if (0x2::table::contains<address, BuilderProfile>(&arg0.builders, arg1)) {
            0x2::table::borrow<address, BuilderProfile>(&arg0.builders, arg1).apps_published
        } else {
            0
        }
    }

    public fun builder_remixes(arg0: &BuilderBoard, arg1: address) : u64 {
        if (0x2::table::contains<address, BuilderProfile>(&arg0.builders, arg1)) {
            0x2::table::borrow<address, BuilderProfile>(&arg0.builders, arg1).remixes_received
        } else {
            0
        }
    }

    public fun builder_score(arg0: &BuilderBoard, arg1: address) : u64 {
        if (0x2::table::contains<address, BuilderProfile>(&arg0.builders, arg1)) {
            0x2::table::borrow<address, BuilderProfile>(&arg0.builders, arg1).score
        } else {
            0
        }
    }

    public fun claim_name(arg0: &mut NameRegistry, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.owner_of, arg1), 5);
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.name_of, v0)) {
            let v1 = 0x2::table::remove<address, 0x1::string::String>(&mut arg0.name_of, v0);
            if (0x2::table::contains<0x1::string::String, address>(&arg0.owner_of, v1)) {
                0x2::table::remove<0x1::string::String, address>(&mut arg0.owner_of, v1);
            };
        };
        0x2::table::add<0x1::string::String, address>(&mut arg0.owner_of, arg1, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.name_of, v0, arg1);
        let v2 = NameClaimed{
            name  : arg1,
            owner : v0,
        };
        0x2::event::emit<NameClaimed>(v2);
    }

    public fun create_builder_board(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderBoard{
            id       : 0x2::object::new(arg0),
            builders : 0x2::table::new<address, BuilderProfile>(arg0),
        };
        0x2::transfer::share_object<BuilderBoard>(v0);
    }

    public fun create_flag_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlagRegistry{
            id     : 0x2::object::new(arg0),
            flags  : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<address>>(arg0),
            hidden : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<FlagRegistry>(v0);
    }

    public fun create_name_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{
            id       : 0x2::object::new(arg0),
            owner_of : 0x2::table::new<0x1::string::String, address>(arg0),
            name_of  : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StarRegistry{
            id      : 0x2::object::new(arg0),
            starred : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<address>>(arg0),
        };
        0x2::transfer::share_object<StarRegistry>(v0);
    }

    public fun create_treasury(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg1),
            admin   : arg0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    fun do_publish(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address) {
        let v0 = PublishedApp{
            id            : 0x2::object::new(arg8),
            builder       : 0x2::tx_context::sender(arg8),
            name          : arg0,
            prompt        : arg1,
            manifest_blob : arg2,
            archive_blob  : arg3,
            tree_hash     : arg4,
            parent        : arg6,
            category      : arg5,
            visits        : 0,
            stars         : 0,
            tips_total    : 0,
            created_at_ms : arg7,
        };
        let v1 = 0x2::object::id<PublishedApp>(&v0);
        let v2 = v0.builder;
        let v3 = AppPublished{
            app_id        : v1,
            builder       : v2,
            name          : v0.name,
            parent        : v0.parent,
            manifest_blob : v0.manifest_blob,
            created_at_ms : arg7,
        };
        0x2::event::emit<AppPublished>(v3);
        if (0x1::option::is_some<0x2::object::ID>(&arg6)) {
            let v4 = AppRemixed{
                parent  : *0x1::option::borrow<0x2::object::ID>(&arg6),
                child   : v1,
                builder : v2,
            };
            0x2::event::emit<AppRemixed>(v4);
        };
        0x2::transfer::share_object<PublishedApp>(v0);
        (v1, v2)
    }

    fun do_star(arg0: &mut PublishedApp, arg1: &mut StarRegistry, arg2: address) {
        assert!(arg2 != arg0.builder, 1);
        let v0 = 0x2::object::id<PublishedApp>(arg0);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg1.starred, v0)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg1.starred, v0, 0x2::vec_set::empty<address>());
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg1.starred, v0);
        assert!(!0x2::vec_set::contains<address>(v1, &arg2), 0);
        0x2::vec_set::insert<address>(v1, arg2);
        arg0.stars = arg0.stars + 1;
        let v2 = AppStarred{
            app_id : v0,
            by     : arg2,
            stars  : arg0.stars,
        };
        0x2::event::emit<AppStarred>(v2);
    }

    public fun flag_app(arg0: &PublishedApp, arg1: &mut FlagRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<PublishedApp>(arg0);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg1.flags, v1)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg1.flags, v1, 0x2::vec_set::empty<address>());
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg1.flags, v1);
        assert!(!0x2::vec_set::contains<address>(v2, &v0), 3);
        0x2::vec_set::insert<address>(v2, v0);
        let v3 = AppFlagged{
            app_id : v1,
            by     : v0,
            flags  : 0x2::vec_set::length<address>(v2),
        };
        0x2::event::emit<AppFlagged>(v3);
    }

    public fun flag_count(arg0: &FlagRegistry, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.flags, arg1)) {
            0x2::vec_set::length<address>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.flags, arg1))
        } else {
            0
        }
    }

    public fun is_hidden(arg0: &FlagRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.hidden, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.hidden, arg1)
    }

    public fun name_of_owner(arg0: &NameRegistry, arg1: address) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.name_of, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<address, 0x1::string::String>(&arg0.name_of, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun name_owner(arg0: &NameRegistry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.owner_of, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.owner_of, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun parent(arg0: &PublishedApp) : &0x1::option::Option<0x2::object::ID> {
        &arg0.parent
    }

    fun profile_mut(arg0: &mut BuilderBoard, arg1: address) : &mut BuilderProfile {
        if (!0x2::table::contains<address, BuilderProfile>(&arg0.builders, arg1)) {
            let v0 = BuilderProfile{
                apps_published   : 0,
                stars_received   : 0,
                remixes_received : 0,
                score            : 0,
            };
            0x2::table::add<address, BuilderProfile>(&mut arg0.builders, arg1, v0);
        };
        0x2::table::borrow_mut<address, BuilderProfile>(&mut arg0.builders, arg1)
    }

    public fun publish_app(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, _) = do_publish(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7), arg8);
    }

    public fun publish_app_v2(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &mut BuilderBoard, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = do_publish(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg8), arg9);
        let v2 = profile_mut(arg7, v1);
        v2.apps_published = v2.apps_published + 1;
        recompute(v2);
        let v3 = BuilderScored{
            builder : v1,
            score   : v2.score,
            apps    : v2.apps_published,
            stars   : v2.stars_received,
            remixes : v2.remixes_received,
        };
        0x2::event::emit<BuilderScored>(v3);
    }

    public fun publish_remix_v3(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &PublishedApp, arg7: &mut BuilderBoard, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg6.builder;
        let (_, v2) = do_publish(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::some<0x2::object::ID>(0x2::object::id<PublishedApp>(arg6)), 0x2::clock::timestamp_ms(arg8), arg9);
        let v3 = profile_mut(arg7, v2);
        v3.apps_published = v3.apps_published + 1;
        recompute(v3);
        let v4 = BuilderScored{
            builder : v2,
            score   : v3.score,
            apps    : v3.apps_published,
            stars   : v3.stars_received,
            remixes : v3.remixes_received,
        };
        0x2::event::emit<BuilderScored>(v4);
        if (v0 != v2) {
            let v5 = profile_mut(arg7, v0);
            v5.remixes_received = v5.remixes_received + 1;
            recompute(v5);
            let v6 = BuilderScored{
                builder : v0,
                score   : v5.score,
                apps    : v5.apps_published,
                stars   : v5.stars_received,
                remixes : v5.remixes_received,
            };
            0x2::event::emit<BuilderScored>(v6);
        };
    }

    fun recompute(arg0: &mut BuilderProfile) {
        arg0.score = arg0.apps_published * 5 + arg0.stars_received * 3 + arg0.remixes_received * 4;
    }

    public fun record_visit(arg0: &mut PublishedApp) {
        arg0.visits = arg0.visits + 1;
        let v0 = AppVisited{
            app_id : 0x2::object::id<PublishedApp>(arg0),
            visits : arg0.visits,
        };
        0x2::event::emit<AppVisited>(v0);
    }

    public fun release_name(arg0: &mut NameRegistry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x1::string::String>(&arg0.name_of, v0), 6);
        let v1 = 0x2::table::remove<address, 0x1::string::String>(&mut arg0.name_of, v0);
        0x2::table::remove<0x1::string::String, address>(&mut arg0.owner_of, v1);
        let v2 = NameReleased{
            name  : v1,
            owner : v0,
        };
        0x2::event::emit<NameReleased>(v2);
    }

    public fun set_hidden(arg0: &PublishedApp, arg1: &mut FlagRegistry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.builder, 4);
        let v0 = 0x2::object::id<PublishedApp>(arg0);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.hidden, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.hidden, v0) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.hidden, v0, arg2);
        };
        let v1 = AppHidden{
            app_id : v0,
            hidden : arg2,
        };
        0x2::event::emit<AppHidden>(v1);
    }

    public fun star(arg0: &mut PublishedApp, arg1: &mut StarRegistry, arg2: &0x2::tx_context::TxContext) {
        do_star(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun star_v2(arg0: &mut PublishedApp, arg1: &mut StarRegistry, arg2: &mut BuilderBoard, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.builder;
        do_star(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v1 = profile_mut(arg2, v0);
        v1.stars_received = v1.stars_received + 1;
        recompute(v1);
        let v2 = BuilderScored{
            builder : v0,
            score   : v1.score,
            apps    : v1.apps_published,
            stars   : v1.stars_received,
            remixes : v1.remixes_received,
        };
        0x2::event::emit<BuilderScored>(v2);
    }

    public fun stars(arg0: &PublishedApp) : u64 {
        arg0.stars
    }

    public fun tip_app(arg0: &mut PublishedApp, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = v0 * 250 / 10000;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v1), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), arg0.builder);
        arg0.tips_total = arg0.tips_total + v0 - v1;
        let v3 = AppTipped{
            app_id : 0x2::object::id<PublishedApp>(arg0),
            from   : 0x2::tx_context::sender(arg2),
            amount : v0 - v1,
            fee    : v1,
        };
        0x2::event::emit<AppTipped>(v3);
    }

    public fun tip_app_v2(arg0: &mut PublishedApp, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = v0 * 250 / 10000;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), arg0.builder);
        arg0.tips_total = arg0.tips_total + v0 - v1;
        let v3 = AppTipped{
            app_id : 0x2::object::id<PublishedApp>(arg0),
            from   : 0x2::tx_context::sender(arg3),
            amount : v0 - v1,
            fee    : v1,
        };
        0x2::event::emit<AppTipped>(v3);
    }

    public fun tips_total(arg0: &PublishedApp) : u64 {
        arg0.tips_total
    }

    public fun treasury_admin(arg0: &Treasury) : address {
        arg0.admin
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun tree_hash(arg0: &PublishedApp) : 0x1::string::String {
        arg0.tree_hash
    }

    public fun update_app(arg0: &mut PublishedApp, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.builder, 4);
        arg0.manifest_blob = arg1;
        arg0.archive_blob = arg2;
        arg0.tree_hash = arg3;
        let v0 = AppUpdated{
            app_id        : 0x2::object::id<PublishedApp>(arg0),
            tree_hash     : arg0.tree_hash,
            updated_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AppUpdated>(v0);
    }

    public fun visits(arg0: &PublishedApp) : u64 {
        arg0.visits
    }

    public fun withdraw_treasury(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), arg0.admin);
        let v0 = TreasuryWithdrawn{
            to     : arg0.admin,
            amount : arg1,
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

