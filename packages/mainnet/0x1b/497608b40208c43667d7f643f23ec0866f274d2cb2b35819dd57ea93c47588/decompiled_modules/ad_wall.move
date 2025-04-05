module 0x1b497608b40208c43667d7f643f23ec0866f274d2cb2b35819dd57ea93c47588::ad_wall {
    struct BlockInfo has copy, store {
        owner: address,
        image_cid: vector<u8>,
        width: u64,
        height: u64,
        is_top_left: bool,
    }

    struct AdWall has store, key {
        id: 0x2::object::UID,
        owner: address,
        blocks: 0x2::table::Table<u64, BlockInfo>,
        prices: 0x2::table::Table<u64, u64>,
        base_price: u64,
        total_blocks_sold: u64,
    }

    struct BlockPurchased has copy, drop {
        buyer: address,
        block_id: u64,
        width: u64,
        height: u64,
        image_cid: vector<u8>,
        price_paid: u64,
    }

    public entry fun buy_blocks(arg0: &mut AdWall, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg3 * arg4;
        validate_purchase(arg0, arg1, arg2, arg3, arg4);
        let v2 = calculate_price(arg0, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg6, v2, arg7), arg0.owner);
        let v3 = 0;
        while (v3 < arg4) {
            let v4 = 0;
            while (v4 < arg3) {
                let v5 = to_block_id(arg1 + v4, arg2 + v3);
                let v6 = v3 == 0 && v4 == 0;
                let v7 = BlockInfo{
                    owner       : v0,
                    image_cid   : arg5,
                    width       : arg3,
                    height      : arg4,
                    is_top_left : v6,
                };
                0x2::table::add<u64, BlockInfo>(&mut arg0.blocks, v5, v7);
                0x2::table::add<u64, u64>(&mut arg0.prices, v5, v2 / v1);
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        arg0.total_blocks_sold = arg0.total_blocks_sold + v1;
        let v8 = BlockPurchased{
            buyer      : v0,
            block_id   : to_block_id(arg1, arg2),
            width      : arg3,
            height     : arg4,
            image_cid  : arg5,
            price_paid : v2,
        };
        0x2::event::emit<BlockPurchased>(v8);
    }

    fun calculate_price(arg0: &AdWall, arg1: u64) : u64 {
        let v0 = arg0.base_price;
        let v1 = if (arg1 >= 21) {
            90
        } else if (arg1 >= 6) {
            95
        } else {
            100
        };
        (v0 + v0 * 105 * arg0.total_blocks_sold / 100 / 100) * arg1 * v1 / 100
    }

    public fun get_block_image(arg0: &AdWall, arg1: u64) : 0x1::option::Option<vector<u8>> {
        if (0x2::table::contains<u64, BlockInfo>(&arg0.blocks, arg1)) {
            0x1::option::some<vector<u8>>(0x2::table::borrow<u64, BlockInfo>(&arg0.blocks, arg1).image_cid)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun get_block_info(arg0: &AdWall, arg1: u64) : 0x1::option::Option<BlockInfo> {
        if (0x2::table::contains<u64, BlockInfo>(&arg0.blocks, arg1)) {
            0x1::option::some<BlockInfo>(*0x2::table::borrow<u64, BlockInfo>(&arg0.blocks, arg1))
        } else {
            0x1::option::none<BlockInfo>()
        }
    }

    public fun get_block_owner(arg0: &AdWall, arg1: u64) : 0x1::option::Option<address> {
        if (0x2::table::contains<u64, BlockInfo>(&arg0.blocks, arg1)) {
            0x1::option::some<address>(0x2::table::borrow<u64, BlockInfo>(&arg0.blocks, arg1).owner)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_block_price(arg0: &AdWall, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.prices, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.prices, arg1)
        } else {
            arg0.base_price
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdWall{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            blocks            : 0x2::table::new<u64, BlockInfo>(arg0),
            prices            : 0x2::table::new<u64, u64>(arg0),
            base_price        : 100000000,
            total_blocks_sold : 0,
        };
        0x2::transfer::transfer<AdWall>(v0, 0x2::tx_context::sender(arg0));
    }

    fun to_block_id(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 100 && arg1 < 100, 2);
        arg1 * 100 + arg0
    }

    fun validate_purchase(arg0: &AdWall, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 + arg3 <= 100 && arg2 + arg4 <= 100, 2);
        let v0 = 0;
        while (v0 < arg4) {
            let v1 = 0;
            while (v1 < arg3) {
                assert!(!0x2::table::contains<u64, BlockInfo>(&arg0.blocks, to_block_id(arg1 + v1, arg2 + v0)), 1);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

