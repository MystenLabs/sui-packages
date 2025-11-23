module 0x55493941a9d838f55de73dfc7da2a34d15b77da23df3c02d40c28cfb911159d7::treasury {
    struct FeeSplit has store, key {
        id: 0x2::object::UID,
        faithgg_bps: u64,
        manifest_bps: u64,
        pilgrimage_bps: u64,
        ops_bps: u64,
    }

    struct Vaults has store, key {
        id: 0x2::object::UID,
        faithgg: 0x2::coin::Coin<0x2::sui::SUI>,
        manifest_buyback: 0x2::coin::Coin<0x2::sui::SUI>,
        pilgrimage: 0x2::coin::Coin<0x2::sui::SUI>,
        ops: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : (FeeSplit, Vaults) {
        let v0 = FeeSplit{
            id             : 0x2::object::new(arg0),
            faithgg_bps    : 7000,
            manifest_bps   : 2000,
            pilgrimage_bps : 200,
            ops_bps        : 800,
        };
        let v1 = Vaults{
            id               : 0x2::object::new(arg0),
            faithgg          : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            manifest_buyback : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            pilgrimage       : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            ops              : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        (v0, v1)
    }

    public fun deposit_to_faithgg(arg0: &mut Vaults, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.faithgg, arg1);
    }

    public fun faithgg_balance(arg0: &Vaults) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.faithgg)
    }

    public fun manifest_balance(arg0: &Vaults) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.manifest_buyback)
    }

    public fun ops_balance(arg0: &Vaults) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.ops)
    }

    public fun pay_from_faithgg(arg0: &mut Vaults, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.faithgg, arg2, arg3), arg1);
    }

    public fun pilgrimage_balance(arg0: &Vaults) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.pilgrimage)
    }

    public fun set_split(arg0: &mut FeeSplit, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 + arg2 + arg3 + arg4 == 10000, 0x55493941a9d838f55de73dfc7da2a34d15b77da23df3c02d40c28cfb911159d7::errors::E_BAD_SPLIT());
        arg0.faithgg_bps = arg1;
        arg0.manifest_bps = arg2;
        arg0.pilgrimage_bps = arg3;
        arg0.ops_bps = arg4;
    }

    public fun split_and_route_internal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeeSplit, arg2: &mut Vaults, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 * arg1.faithgg_bps / 10000;
        let v2 = v0 * arg1.manifest_bps / 10000;
        let v3 = v0 * arg1.pilgrimage_bps / 10000;
        let v4 = v0 - v1 - v2 - v3;
        if (v1 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg2.faithgg, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg3));
        };
        if (v2 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg2.manifest_buyback, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg3));
        };
        if (v3 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg2.pilgrimage, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3));
        };
        if (v4 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg2.ops, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg3));
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
    }

    public fun withdraw_faithgg(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.faithgg, arg1, arg2)
    }

    public fun withdraw_manifest_buyback(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.manifest_buyback, arg1, arg2)
    }

    public fun withdraw_ops(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.ops, arg1, arg2)
    }

    public fun withdraw_pilgrimage(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.pilgrimage, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

