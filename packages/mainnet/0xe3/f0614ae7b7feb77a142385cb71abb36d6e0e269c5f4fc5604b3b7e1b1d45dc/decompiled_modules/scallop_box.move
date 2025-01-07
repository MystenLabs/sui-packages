module 0xe3f0614ae7b7feb77a142385cb71abb36d6e0e269c5f4fc5604b3b7e1b1d45dc::scallop_box {
    struct SCALLOP_BOX has drop {
        dummy_field: bool,
    }

    struct ScallopBox has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
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
        total_minted: u64,
        total_burned: u64,
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

    public(friend) fun transfer(arg0: ScallopBox, arg1: address) {
        0x2::transfer::transfer<ScallopBox>(arg0, arg1);
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

    public(friend) fun burn(arg0: &mut ScallopBoxStats, arg1: ScallopBox, arg2: &0x2::tx_context::TxContext) {
        let ScallopBox {
            id              : v0,
            name            : _,
            description     : _,
            image_url       : _,
            attributes      : _,
            rarity          : v5,
            issue_timestamp : v6,
        } = arg1;
        let v7 = v0;
        let v8 = ScallopBoxBurned{
            id              : 0x2::object::uid_to_inner(&v7),
            rarity          : v5,
            issue_timestamp : v6,
            burner          : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ScallopBoxBurned>(v8);
        0x2::object::delete(v7);
        if (v5 == 1) {
            arg0.bronze_burned = arg0.bronze_burned + 1;
        } else if (v5 == 2) {
            arg0.silver_burned = arg0.silver_burned + 1;
        } else if (v5 == 3) {
            arg0.gold_burned = arg0.gold_burned + 1;
        } else if (v5 == 4) {
            arg0.platinum_burned = arg0.platinum_burned + 1;
        } else if (v5 == 5) {
            arg0.diamond_burned = arg0.diamond_burned + 1;
        } else if (v5 == 6) {
            arg0.legendary_burned = arg0.legendary_burned + 1;
        };
        arg0.total_burned = arg0.total_burned + 1;
    }

    fun calc_box_rarity(arg0: u64) : u64 {
        if (arg0 <= 655) {
            1
        } else if (arg0 <= 925) {
            2
        } else if (arg0 <= 995) {
            3
        } else {
            assert!(arg0 <= 1000, 0);
            4
        }
    }

    public fun diamond() : u64 {
        5
    }

    fun get_image_url(arg0: u64) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"bafkreiginzkqsi5itegjcjbxzbhdxvcrhqyburlsy6bjuaa2fdll74ok7e")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"bafkreid3urhcmt6hi6vje27grcvyhnutp5q6ducpcmcuolvlegsqv52fou")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"bafkreifasnucqwcj5zx5vuaqn62ajlb27nomcsprwp5omaf4mxkyglv2fu")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"bafkreido24kmli2wazwekz7ozlekhalajikqonual4ylkkshhmcv52t2oy")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"bafkreihto5xzwsnnuiglwtlrq7pgc3vq6t2qp3e3fydpsfvbm4oyuo6pde")
        } else {
            assert!(arg0 == 6, 0);
            0x1::string::utf8(b"bafkreid7eik27fejxwzgrpymtkumkiiv5kefsshbbxqmxt2y2dxz73scu4")
        }
    }

    public fun gold() : u64 {
        3
    }

    fun init(arg0: SCALLOP_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://airdrop.scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Labs"));
        let v4 = 0x2::package::claim<SCALLOP_BOX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ScallopBox>(&v4, v0, v2, arg1);
        0x2::display::update_version<ScallopBox>(&mut v5);
        let v6 = ScallopBoxStats{
            id               : 0x2::object::new(arg1),
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
            total_minted     : 0,
            total_burned     : 0,
        };
        0x2::transfer::share_object<ScallopBoxStats>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ScallopBox>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun legendary() : u64 {
        6
    }

    public(friend) fun mint(arg0: &mut ScallopBoxStats, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ScallopBox {
        assert!(arg1 >= 1 && arg1 <= 6, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::utf8(b"");
        if (arg1 == 1) {
            arg0.bronze_minted = arg0.bronze_minted + 1;
            v1 = 0x1::string::utf8(b"Bronze Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.bronze_minted));
            v2 = 0x1::string::utf8(b"bronze");
        } else if (arg1 == 2) {
            arg0.silver_minted = arg0.silver_minted + 1;
            v1 = 0x1::string::utf8(b"Silver Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.silver_minted));
            v2 = 0x1::string::utf8(b"silver");
        } else if (arg1 == 3) {
            arg0.gold_minted = arg0.gold_minted + 1;
            v1 = 0x1::string::utf8(b"Gold Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.gold_minted));
            v2 = 0x1::string::utf8(b"gold");
        } else if (arg1 == 4) {
            arg0.platinum_minted = arg0.platinum_minted + 1;
            v1 = 0x1::string::utf8(b"Platinum Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.platinum_minted));
            v2 = 0x1::string::utf8(b"platinum");
        } else if (arg1 == 5) {
            arg0.diamond_minted = arg0.diamond_minted + 1;
            v1 = 0x1::string::utf8(b"Diamond Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.diamond_minted));
            v2 = 0x1::string::utf8(b"diamond");
        } else if (arg1 == 6) {
            arg0.legendary_minted = arg0.legendary_minted + 1;
            v1 = 0x1::string::utf8(b"Legendary Scallop Pearl #");
            0x1::string::append(&mut v1, u64_to_string(arg0.legendary_minted));
            v2 = 0x1::string::utf8(b"legendary");
        };
        arg0.total_minted = arg0.total_minted + 1;
        let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"tier"), v2);
        let v4 = ScallopBox{
            id              : 0x2::object::new(arg3),
            name            : v1,
            description     : 0x1::string::utf8(b"No one knows how precious this pearl is."),
            image_url       : get_image_url(arg1),
            attributes      : v3,
            rarity          : arg1,
            issue_timestamp : v0,
        };
        let v5 = ScallopBoxMinted{
            id              : 0x2::object::id<ScallopBox>(&v4),
            rarity          : arg1,
            issue_timestamp : v0,
            minter          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ScallopBoxMinted>(v5);
        v4
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

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::from_ascii(0x1::ascii::string(v0))
    }

    // decompiled from Move bytecode v6
}

