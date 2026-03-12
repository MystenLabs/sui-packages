module 0xe304cf5c247057a3d748cebd56d4eb1a18c0c2dcba2bbb2a120c64fa1528a86b::aqusdc {
    struct AQUSDC has drop {
        dummy_field: bool,
    }

    struct BurnGateway has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<AQUSDC>,
    }

    public fun burn(arg0: &mut BurnGateway, arg1: 0x2::coin::Coin<AQUSDC>) : u64 {
        0x2::coin::burn<AQUSDC>(&mut arg0.treasury_cap, arg1)
    }

    public fun create_burn_gateway(arg0: 0x2::coin::TreasuryCap<AQUSDC>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnGateway{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<BurnGateway>(v0);
    }

    fun init(arg0: AQUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUSDC>(arg0, 6, b"aqUSDC", b"AquaYield USDC", b"Yield-bearing USDC vault token from AquaYield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/LGWQ0045SzePRFHnuGK5mxF25zBOToRmEpWrUSpSkOI")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUSDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

