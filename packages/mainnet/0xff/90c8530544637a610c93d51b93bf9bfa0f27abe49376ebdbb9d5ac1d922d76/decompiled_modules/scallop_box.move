module 0xff90c8530544637a610c93d51b93bf9bfa0f27abe49376ebdbb9d5ac1d922d76::scallop_box {
    struct ScallopBox has store, key {
        id: 0x2::object::UID,
        rarity: u64,
        issue_timestamp: u64,
    }

    struct ScallopBoxMinted has copy, drop {
        rarity: u64,
        issue_timestamp: u64,
        minter: address,
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

    public fun legendary() : u64 {
        6
    }

    public(friend) fun mint(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ScallopBox {
        assert!(arg0 >= 1 && arg0 <= 6, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = ScallopBox{
            id              : 0x2::object::new(arg2),
            rarity          : arg0,
            issue_timestamp : v0,
        };
        let v2 = ScallopBoxMinted{
            rarity          : arg0,
            issue_timestamp : v0,
            minter          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ScallopBoxMinted>(v2);
        v1
    }

    public(friend) fun mint_with_rarity_seed(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ScallopBox {
        let v0 = calc_box_rarity(arg0);
        assert!(v0 >= 1 && v0 <= 4, 0);
        mint(v0, arg1, arg2)
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

