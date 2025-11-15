module 0xa124c1d8626858592b70a37f0a6fbae84a0f69d3d185e3ee8405e68e4c504a52::treasury {
    struct FeeSplit has store, key {
        id: 0x2::object::UID,
        faithed_bps: u64,
        manifest_bps: u64,
        ops_bps: u64,
    }

    struct Vaults has store, key {
        id: 0x2::object::UID,
        faithed: 0x2::coin::Coin<0x2::sui::SUI>,
        manifest_buyback: 0x2::coin::Coin<0x2::sui::SUI>,
        ops: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : (FeeSplit, Vaults) {
        let v0 = FeeSplit{
            id           : 0x2::object::new(arg0),
            faithed_bps  : 7000,
            manifest_bps : 2000,
            ops_bps      : 1000,
        };
        let v1 = Vaults{
            id               : 0x2::object::new(arg0),
            faithed          : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            manifest_buyback : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            ops              : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        (v0, v1)
    }

    public fun deposit_to_faithed(arg0: &mut Vaults, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.faithed, arg1);
    }

    public fun pay_from_faithed(arg0: &mut Vaults, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.faithed, arg2, arg3), arg1);
    }

    public fun set_split(arg0: &mut FeeSplit, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 + arg2 + arg3 == 10000, 0xa124c1d8626858592b70a37f0a6fbae84a0f69d3d185e3ee8405e68e4c504a52::errors::E_BAD_SPLIT());
        arg0.faithed_bps = arg1;
        arg0.manifest_bps = arg2;
        arg0.ops_bps = arg3;
    }

    public fun split_and_route_internal(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeeSplit, arg2: &mut Vaults, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 * arg1.faithed_bps / 10000;
        let v2 = v0 * arg1.manifest_bps / 10000;
        0x2::coin::join<0x2::sui::SUI>(&mut arg2.faithed, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v1, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg2.manifest_buyback, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg2.ops, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1 - v2, arg3));
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
    }

    public fun withdraw_faithed(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.faithed, arg1, arg2)
    }

    public fun withdraw_manifest_buyback(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.manifest_buyback, arg1, arg2)
    }

    public fun withdraw_ops(arg0: &mut Vaults, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(&mut arg0.ops, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

