module 0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::dgen_wrapped_sbt {
    struct DGEN_WRAPPED_SBT has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        owner: address,
        sbt_id: 0x2::object::ID,
        tier: u8,
        rank: u64,
    }

    struct DgenWrappedSBT has key {
        id: 0x2::object::UID,
        index: u64,
        owner: address,
        tier: u8,
        tier_name: 0x1::string::String,
        tier_description: 0x1::string::String,
        n_txns: u64,
        n_packages: u64,
        n_active_days: u64,
        peak_daily_txns: u64,
        peak_tx_ds: 0x1::string::String,
        n_coin_types: u64,
        n_shitcoin_types: u64,
        n_recipients: u64,
        top_apps: vector<0x1::string::String>,
        rank: u64,
        details: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct DgenWrappedBackup has key {
        id: 0x2::object::UID,
        sbt_id: 0x2::object::ID,
        sbt_bytes: vector<u8>,
        memo: vector<u8>,
    }

    struct HodlerStatus has key {
        id: 0x2::object::UID,
        total_supply: u64,
        balance_table: 0x2::table::Table<address, u64>,
    }

    public fun delete_backup(arg0: DgenWrappedBackup) {
        let DgenWrappedBackup {
            id        : v0,
            sbt_id    : _,
            sbt_bytes : _,
            memo      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun details(arg0: &DgenWrappedSBT) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.details
    }

    fun from_keys_and_values(arg0: vector<0x1::string::String>, arg1: vector<u64>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun hodler_balance(arg0: &HodlerStatus, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balance_table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balance_table, arg1)
        } else {
            0
        }
    }

    public fun index(arg0: &DgenWrappedSBT) : u64 {
        arg0.index
    }

    fun init(arg0: DGEN_WRAPPED_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Degen #{index}: {tier_name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui Degen 2023 is the dopest, free mint NFT collection that's all about celebrating the wild ride of Sui's first year. This isn't just a collection; it's your permanent ticket to the OG club, a digital high-five for riding the Suinami wave right from the splash."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nftstorage.link/ipfs/bafybeibzl4rccmeylbr6zwrx43hwvsigvojw4lr65onqzhdyykootwrddu/{tier}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.suidgen.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sui $dgen"));
        let v4 = 0x2::package::claim<DGEN_WRAPPED_SBT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DgenWrappedSBT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DgenWrappedSBT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<DgenWrappedSBT>>(v5, v6);
        let v7 = HodlerStatus{
            id            : 0x2::object::new(arg1),
            total_supply  : 0,
            balance_table : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<HodlerStatus>(v7);
    }

    public fun mint_to(arg0: &0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::GlobalConfig, arg1: &mut HodlerStatus, arg2: address, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: vector<0x1::string::String>, arg14: u64, arg15: vector<0x1::string::String>, arg16: vector<u64>, arg17: &mut 0x2::tx_context::TxContext) {
        0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::assert_valid_package_version(arg0);
        0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::assert_is_mintable(arg0);
        0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::assert_sender_is_minter(arg0, arg17);
        let v0 = new_sbt(arg2, total_supply(arg1), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, from_keys_and_values(arg15, arg16), arg17);
        if (!0x1::vector::is_empty<u8>(&arg3)) {
            0x2::transfer::transfer<DgenWrappedBackup>(new_backup(&v0, arg3, arg17), 0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::backup_collector(arg0));
        };
        0x2::transfer::transfer<DgenWrappedSBT>(v0, arg2);
        arg1.total_supply = arg1.total_supply + 1;
        let v1 = &mut arg1.balance_table;
        if (!0x2::table::contains<address, u64>(v1, arg2)) {
            0x2::table::add<address, u64>(v1, arg2, 0);
        };
        let v2 = 0x2::table::borrow_mut<address, u64>(v1, arg2);
        *v2 = *v2 + 1;
    }

    fun new_backup(arg0: &DgenWrappedSBT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : DgenWrappedBackup {
        DgenWrappedBackup{
            id        : 0x2::object::new(arg2),
            sbt_id    : 0x2::object::id<DgenWrappedSBT>(arg0),
            sbt_bytes : 0x2::bcs::to_bytes<DgenWrappedSBT>(arg0),
            memo      : arg1,
        }
    }

    fun new_sbt(arg0: address, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: vector<0x1::string::String>, arg12: u64, arg13: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg14: &mut 0x2::tx_context::TxContext) : DgenWrappedSBT {
        let v0 = 0x2::object::new(arg14);
        let v1 = MintEvent{
            owner  : arg0,
            sbt_id : 0x2::object::uid_to_inner(&v0),
            tier   : arg2,
            rank   : arg12,
        };
        0x2::event::emit<MintEvent>(v1);
        let (v2, v3) = tier_to_name_and_description(arg2);
        DgenWrappedSBT{
            id               : v0,
            index            : arg1,
            owner            : arg0,
            tier             : arg2,
            tier_name        : v2,
            tier_description : v3,
            n_txns           : arg3,
            n_packages       : arg4,
            n_active_days    : arg5,
            peak_daily_txns  : arg6,
            peak_tx_ds       : arg7,
            n_coin_types     : arg8,
            n_shitcoin_types : arg9,
            n_recipients     : arg10,
            top_apps         : arg11,
            rank             : arg12,
            details          : arg13,
        }
    }

    public fun rank(arg0: &DgenWrappedSBT) : u64 {
        arg0.rank
    }

    fun test_mint_interal(arg0: &0x7fafee2e4e5fdaa1079f11a79f61d1090c2960fb3cd48de8bf3f45df913e606a::config::GlobalConfig, arg1: &mut HodlerStatus, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SUI 8192 by Ethos"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"KriyaDEX"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"DeSuiLabs Coin Flip"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Scallop"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Hyperspace"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"buck_minted"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"scallop_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"kriya_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"cetus_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"navi_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"deepbook_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"aftermath_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"typus_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suilette_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"desuicoinflip_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"hyperspace_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"bluemove_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"suimint_txns"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"quest_txns"));
        mint_to(arg0, arg1, arg2, arg3, 1, 41880, 170, 183, 6057, 0x1::string::utf8(b"2023-07-14"), 38, 35, 80, v0, 1, v2, vector[9680899281602, 412, 685, 40, 283, 30, 303, 157, 128, 542, 313, 103, 23, 9], arg4);
    }

    public fun tier(arg0: &DgenWrappedSBT) : u8 {
        arg0.tier
    }

    fun tier_to_name_and_description(arg0: u8) : (0x1::string::String, 0x1::string::String) {
        if (arg0 == 0) {
            (0x1::string::utf8(b"Sui Gods"), 0x1::string::utf8(b"Riding the Suinami like bosses; in the land of Sui, we don't just transact, we reign supreme and that's a fact"))
        } else if (arg0 == 1) {
            (0x1::string::utf8(b"Degen Demigods"), 0x1::string::utf8(b"Living on the blockchain, where every trend is a commandment."))
        } else if (arg0 == 2) {
            (0x1::string::utf8(b"Shill Sharks"), 0x1::string::utf8(b"Tweet it, hype it, watch it fly; we're the reason 'buy the rumor' never dies"))
        } else if (arg0 == 3) {
            (0x1::string::utf8(b"Diamond Hands Dukes"), 0x1::string::utf8(b"Diamond hands, iron will; holding strong, chillin' still, even when the market's downhill"))
        } else {
            let (v2, v3) = if (arg0 == 4) {
                (0x1::string::utf8(b"Tracking whales, surfing waves; playing the crypto sea, where fortune favors the brave"), 0x1::string::utf8(b"Whale Watchers"))
            } else {
                let (v4, v5) = if (arg0 == 5) {
                    (0x1::string::utf8(b"Rug Pull Survivors"), 0x1::string::utf8(b"Rugged once, rugged twice, still in the game, rolling the dice; crypto life, ain't it nice?"))
                } else if (arg0 == 6) {
                    (0x1::string::utf8(b"Lambo Dreamers"), 0x1::string::utf8(b"In crypto we trust, for a Lambo or bust; dreaming of rides, while in volatility we thrust"))
                } else if (arg0 == 7) {
                    (0x1::string::utf8(b"FOMO Fighters"), 0x1::string::utf8(b"Missed the hype train once, not twice; now we invest with advice, not with dice"))
                } else if (arg0 == 8) {
                    (0x1::string::utf8(b"Moon Missionaries"), 0x1::string::utf8(b"To the moon or bust, with every pump we trust; our bags are packed, just waiting for thrust!"))
                } else {
                    (0x1::string::utf8(b"Paper Hands Peasants"), 0x1::string::utf8(b"Sell at the dip, regret at the peak; we're the kings and queens of the panic-sell streak!"))
                };
                (v5, v4)
            };
            (v3, v2)
        }
    }

    public fun total_supply(arg0: &HodlerStatus) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

