module 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::lp_fee_policy {
    struct LpFeePolicy has key {
        id: 0x2::object::UID,
        destination: address,
        defaults: SharePair,
        coins: 0x2::table::Table<0x1::type_name::TypeName, SharePair>,
    }

    struct SharePair has copy, drop, store {
        meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        quote_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : LpFeePolicy {
        let v0 = SharePair{
            meme_bps  : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            quote_bps : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
        };
        LpFeePolicy{
            id          : 0x2::object::new(arg0),
            destination : 0x2::tx_context::sender(arg0),
            defaults    : v0,
            coins       : 0x2::table::new<0x1::type_name::TypeName, SharePair>(arg0),
        }
    }

    public fun clear_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, SharePair>(&mut arg0.coins, v0);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_events::lp_fee_policy_changed(0x1::option::some<0x1::type_name::TypeName>(v0), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v1.meme_bps)), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v1.quote_bps)), 0x1::option::none<u64>(), 0x1::option::none<u64>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LpFeePolicy>(new(arg0));
    }

    public(friend) fun protocol_destination(arg0: &LpFeePolicy) : address {
        arg0.destination
    }

    public fun set_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = SharePair{
            meme_bps  : arg3,
            quote_bps : arg4,
        };
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, SharePair>(&arg0.coins, v0)) {
            0x1::option::some<SharePair>(0x2::table::remove<0x1::type_name::TypeName, SharePair>(&mut arg0.coins, v0))
        } else {
            0x1::option::none<SharePair>()
        };
        assert!(v2 != 0x1::option::some<SharePair>(v1), 13835339938280898563);
        0x2::table::add<0x1::type_name::TypeName, SharePair>(&mut arg0.coins, v0, v1);
        let v3 = v2;
        let v4 = if (0x1::option::is_some<SharePair>(&v3)) {
            let v5 = 0x1::option::destroy_some<SharePair>(v3);
            0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v5.meme_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v3);
            0x1::option::none<u64>()
        };
        let v6 = v2;
        let v7 = if (0x1::option::is_some<SharePair>(&v6)) {
            let v8 = 0x1::option::destroy_some<SharePair>(v6);
            0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v8.quote_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v6);
            0x1::option::none<u64>()
        };
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_events::lp_fee_policy_changed(0x1::option::some<0x1::type_name::TypeName>(v0), v4, v7, 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3)), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4)));
    }

    public fun set_default_shares(arg0: &mut LpFeePolicy, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg4: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        let v0 = SharePair{
            meme_bps  : arg3,
            quote_bps : arg4,
        };
        assert!(v0 != arg0.defaults, 13835339818021814275);
        let v1 = arg0.defaults;
        arg0.defaults = v0;
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_events::lp_fee_policy_changed(0x1::option::none<0x1::type_name::TypeName>(), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v1.meme_bps)), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v1.quote_bps)), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3)), 0x1::option::some<u64>(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg4)));
    }

    public fun set_protocol_destination(arg0: &mut LpFeePolicy, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::TreasuryAdmin>, arg3: address) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        assert!(arg3 != @0x0 && arg3 != arg0.destination, 13835058261440593921);
        arg0.destination = arg3;
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_events::lp_fee_destination_changed(arg0.destination, arg3);
    }

    public(friend) fun shares<T0>(arg0: &LpFeePolicy) : (0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, SharePair>(&arg0.coins, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, SharePair>(&arg0.coins, v0)
        } else {
            arg0.defaults
        };
        let v2 = v1;
        (v2.meme_bps, v2.quote_bps)
    }

    // decompiled from Move bytecode v7
}

