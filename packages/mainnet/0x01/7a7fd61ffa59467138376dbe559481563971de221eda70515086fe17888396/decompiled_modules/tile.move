module 0x17a7fd61ffa59467138376dbe559481563971de221eda70515086fe17888396::tile {
    struct Registry has key {
        id: 0x2::object::UID,
        owner: address,
        base_uri: 0x1::string::String,
        claimed: 0x2::table::Table<u64, address>,
        total: u64,
        tile_price: u64,
        market_fee_bps: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_receiver: address,
    }

    struct Tile has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        tx: u64,
        ty: u64,
    }

    struct TileMinted has copy, drop {
        token_id: u64,
        to: address,
        tx: u64,
        ty: u64,
    }

    public entry fun claim_tile(arg0: &mut Registry, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.tile_price > 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.tile_price, 5);
        let v0 = token_id_from_key(arg2, arg3);
        assert!(!0x2::table::contains<u64, address>(&arg0.claimed, v0), 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.tile_price, arg4)));
        0x2::table::add<u64, address>(&mut arg0.claimed, v0, 0x2::tx_context::sender(arg4));
        arg0.total = arg0.total + 1;
        let v1 = TileMinted{
            token_id : v0,
            to       : 0x2::tx_context::sender(arg4),
            tx       : arg2,
            ty       : arg3,
        };
        0x2::event::emit<TileMinted>(v1);
        let v2 = Tile{
            id       : 0x2::object::new(arg4),
            token_id : v0,
            tx       : arg2,
            ty       : arg3,
        };
        0x2::transfer::public_transfer<Tile>(v2, 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            base_uri          : 0x1::string::utf8(b"https://sui.xono.ai/metadata/"),
            claimed           : 0x2::table::new<u64, address>(arg0),
            total             : 0,
            tile_price        : 0,
            market_fee_bps    : 700,
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_receiver : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun key_from_token_id(arg0: u64) : (u64, u64) {
        (arg0 >> 15, arg0 & 32767)
    }

    public fun market_fee_bps(arg0: &Registry) : u64 {
        arg0.market_fee_bps
    }

    public entry fun mint_tile(arg0: &mut Registry, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = token_id_from_key(arg2, arg3);
        assert!(!0x2::table::contains<u64, address>(&arg0.claimed, v0), 3);
        0x2::table::add<u64, address>(&mut arg0.claimed, v0, arg1);
        arg0.total = arg0.total + 1;
        let v1 = TileMinted{
            token_id : v0,
            to       : arg1,
            tx       : arg2,
            ty       : arg3,
        };
        0x2::event::emit<TileMinted>(v1);
        let v2 = Tile{
            id       : 0x2::object::new(arg4),
            token_id : v0,
            tx       : arg2,
            ty       : arg3,
        };
        0x2::transfer::public_transfer<Tile>(v2, arg1);
    }

    public entry fun set_market_fee_bps(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 <= 1000, 6);
        arg0.market_fee_bps = arg1;
    }

    public entry fun set_tile_price(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.tile_price = arg1;
    }

    public entry fun set_treasury_receiver(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 != @0x0, 7);
        arg0.treasury_receiver = arg1;
    }

    public fun tile_price(arg0: &Registry) : u64 {
        arg0.tile_price
    }

    public fun token_id_from_key(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 16383, 2);
        assert!(arg1 <= 16383, 2);
        arg0 << 15 | arg1
    }

    public fun total_minted(arg0: &Registry) : u64 {
        arg0.total
    }

    public fun treasury_value(arg0: &Registry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public entry fun withdraw(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg1), arg0.treasury_receiver);
    }

    // decompiled from Move bytecode v7
}

