module 0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::scallop_box {
    struct ScallopBox has store, key {
        id: 0x2::object::UID,
        rarity: u64,
        issue_timestamp: u64,
    }

    struct ScallopBoxStats has key {
        id: 0x2::object::UID,
        bronze_minted: u64,
        bronze_burned: u64,
        silver_minted: u64,
        silver_burned: u64,
        gold_minted: u64,
        gold_burned: u64,
        platinum_minted: u64,
        platinum_burned: u64,
        diamond_minted: u64,
        diamond_burned: u64,
        legendary_minted: u64,
        legendary_burned: u64,
    }

    struct ScallopBoxMinted has copy, drop {
        id: 0x2::object::ID,
        rarity: u64,
        issue_timestamp: u64,
        minter: address,
    }

    struct ScallopBoxBurned has copy, drop {
        id: 0x2::object::ID,
        rarity: u64,
        issue_timestamp: u64,
        burner: address,
    }

    public fun box_issue_timestamp(arg0: &ScallopBox) : u64 {
        arg0.issue_timestamp
    }

    public fun box_rarity(arg0: &ScallopBox) : u64 {
        arg0.rarity
    }

    public fun bronze() : u64 {
        1
    }

    public(friend) fun burn(arg0: &mut ScallopBoxStats, arg1: ScallopBox, arg2: &mut 0x2::tx_context::TxContext) {
        let ScallopBox {
            id              : v0,
            rarity          : v1,
            issue_timestamp : v2,
        } = arg1;
        let v3 = v0;
        let v4 = ScallopBoxBurned{
            id              : 0x2::object::uid_to_inner(&v3),
            rarity          : v1,
            issue_timestamp : v2,
            burner          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ScallopBoxBurned>(v4);
        0x2::object::delete(v3);
        if (v1 == 1) {
            arg0.bronze_burned = arg0.bronze_burned + 1;
        } else if (v1 == 2) {
            arg0.silver_burned = arg0.silver_burned + 1;
        } else if (v1 == 3) {
            arg0.gold_burned = arg0.gold_burned + 1;
        } else if (v1 == 4) {
            arg0.platinum_burned = arg0.platinum_burned + 1;
        } else if (v1 == 5) {
            arg0.diamond_burned = arg0.diamond_burned + 1;
        } else if (v1 == 6) {
            arg0.legendary_burned = arg0.legendary_burned + 1;
        };
    }

    public fun calc_box_rarity(arg0: u64) : u64 {
        if (arg0 <= 700) {
            1
        } else if (arg0 <= 950) {
            2
        } else if (arg0 <= 995) {
            3
        } else {
            assert!(arg0 <= 1005, 0);
            5
        }
    }

    public fun diamond() : u64 {
        5
    }

    public fun gold() : u64 {
        3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopBoxStats{
            id               : 0x2::object::new(arg0),
            bronze_minted    : 0,
            bronze_burned    : 0,
            silver_minted    : 0,
            silver_burned    : 0,
            gold_minted      : 0,
            gold_burned      : 0,
            platinum_minted  : 0,
            platinum_burned  : 0,
            diamond_minted   : 0,
            diamond_burned   : 0,
            legendary_minted : 0,
            legendary_burned : 0,
        };
        0x2::transfer::share_object<ScallopBoxStats>(v0);
    }

    public fun legendary() : u64 {
        6
    }

    public(friend) fun mint(arg0: &mut ScallopBoxStats, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ScallopBox {
        assert!(arg1 >= 1 && arg1 <= 6, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = ScallopBox{
            id              : 0x2::object::new(arg3),
            rarity          : arg1,
            issue_timestamp : v0,
        };
        if (arg1 == 1) {
            arg0.bronze_minted = arg0.bronze_minted + 1;
        } else if (arg1 == 2) {
            arg0.silver_minted = arg0.silver_minted + 1;
        } else if (arg1 == 3) {
            arg0.gold_minted = arg0.gold_minted + 1;
        } else if (arg1 == 4) {
            arg0.platinum_minted = arg0.platinum_minted + 1;
        } else if (arg1 == 5) {
            arg0.diamond_minted = arg0.diamond_minted + 1;
        } else if (arg1 == 6) {
            arg0.legendary_minted = arg0.legendary_minted + 1;
        };
        let v2 = ScallopBoxMinted{
            id              : 0x2::object::id<ScallopBox>(&v1),
            rarity          : arg1,
            issue_timestamp : v0,
            minter          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ScallopBoxMinted>(v2);
        v1
    }

    public(friend) fun mint_with_rarity_seed(arg0: &mut ScallopBoxStats, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ScallopBox {
        let v0 = calc_box_rarity(arg1);
        assert!(v0 >= 1 && v0 <= 4, 0);
        mint(arg0, v0, arg2, arg3)
    }

    public fun platinum() : u64 {
        4
    }

    public fun rarity_base() : u64 {
        1000
    }

    public fun silver() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

