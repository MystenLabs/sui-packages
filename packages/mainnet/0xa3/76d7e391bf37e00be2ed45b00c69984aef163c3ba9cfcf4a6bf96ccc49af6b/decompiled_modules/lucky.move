module 0xa376d7e391bf37e00be2ed45b00c69984aef163c3ba9cfcf4a6bf96ccc49af6b::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    struct LuckyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        level: u64,
        point: u64,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct BurnCap has key {
        id: 0x2::object::UID,
    }

    struct MintState has store, key {
        id: 0x2::object::UID,
        supply: u64,
        open: bool,
        minted: 0x2::bag::Bag,
    }

    public entry fun burn(arg0: &BurnCap, arg1: LuckyNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let LuckyNFT {
            id      : v0,
            name    : _,
            img_url : _,
            level   : _,
            point   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_public_mint(arg0: &MintCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintState{
            id     : 0x2::object::new(arg1),
            supply : 0,
            open   : true,
            minted : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<MintState>(v0);
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LUCKY>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<LuckyNFT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0xa376d7e391bf37e00be2ed45b00c69984aef163c3ba9cfcf4a6bf96ccc49af6b::royalty_rule::add<LuckyNFT>(&mut v4, &v3, 500, 1000);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<LuckyNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<LuckyNFT>>(v4);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://www.luckystar.homes/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"LuckyStar has its unique star sign NFT series which could boost your earning while you play lucky games. LuckyStar NFT supports functions as staking, upgrading, boosting, trading and more."));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://www.luckystar.homes/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"LuckyStar"));
        let v9 = 0x2::display::new_with_fields<LuckyNFT>(&v0, v5, v7, arg1);
        0x2::display::update_version<LuckyNFT>(&mut v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LuckyNFT>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v10, 0x2::tx_context::sender(arg1));
        let v11 = BurnCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BurnCap>(v11, 0x2::tx_context::sender(arg1));
    }

    fun inner_mint(arg0: &mut 0x2::tx_context::TxContext) : LuckyNFT {
        LuckyNFT{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(b"LuckyStar"),
            img_url : 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-1.png"),
            level   : 1,
            point   : 0,
        }
    }

    public entry fun level(arg0: &LuckyNFT) : u64 {
        arg0.level
    }

    public fun mint(arg0: &MintCap, arg1: &mut 0x2::tx_context::TxContext) : LuckyNFT {
        LuckyNFT{
            id      : 0x2::object::new(arg1),
            name    : 0x1::string::utf8(b"LuckyStar"),
            img_url : 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-1.png"),
            level   : 1,
            point   : 0,
        }
    }

    public entry fun mint_and_transfer(arg0: &MintCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<LuckyNFT>(mint(arg0, arg2), arg1);
    }

    public fun mint_for_test(arg0: &mut 0x2::tx_context::TxContext) : LuckyNFT {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        let MintCap { id: v1 } = v0;
        0x2::object::delete(v1);
        mint(&v0, arg0)
    }

    public entry fun mint_to_sender(arg0: &MintCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1);
        0x2::transfer::public_transfer<LuckyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun point(arg0: &LuckyNFT) : u64 {
        arg0.point
    }

    public entry fun point_up(arg0: &mut LuckyNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.point = arg0.point + arg1;
        if (arg0.point < 999000000000) {
            arg0.img_url = 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-1.png");
            arg0.level = 1;
        } else if (arg0.point < 1999000000000) {
            arg0.img_url = 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-2.png");
            arg0.level = 2;
        } else if (arg0.point < 3999000000000) {
            arg0.img_url = 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-3.png");
            arg0.level = 3;
        } else if (arg0.point < 7999000000000) {
            arg0.img_url = 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-4.png");
            arg0.level = 4;
        } else {
            arg0.img_url = 0x1::string::utf8(b"https://luckystar-nft.s3.ap-southeast-1.amazonaws.com/imgs/level-5.png");
            arg0.level = 5;
        };
    }

    public entry fun public_mint_switch(arg0: &mut MintState, arg1: &MintCap) {
        arg0.open = !arg0.open;
    }

    public entry fun unlimit_mint(arg0: &mut MintState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open, 1001);
        assert!(!0x2::bag::contains<address>(&arg0.minted, 0x2::tx_context::sender(arg1)), 1002);
        arg0.supply = arg0.supply + 1;
        0x2::bag::add<address, u64>(&mut arg0.minted, 0x2::tx_context::sender(arg1), 1);
        let v0 = inner_mint(arg1);
        0x2::transfer::public_transfer<LuckyNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

