module 0x183b4cbecf29d6de0a94a90547e16ec7c3de7100c0852fbfbe73e61eed97e5cc::wlp {
    struct WLP has key {
        id: 0x2::object::UID,
    }

    public fun create_wlp_pool(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: WLP, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<WLP>(arg0, decimals(), 0x1::string::utf8(b"WLP"), 0x1::string::utf8(b"WaterX LP Token"), 0x1::string::utf8(b"Liquidity Provider token for WaterX Perp DEX"), 0x1::string::utf8(b"https://token-metadata.bridge.xyz/images/usd_sui.png"), arg3);
        0x2::transfer::public_share_object<0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::WlpPool<WLP>>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool::create_pool<WLP>(arg1, v1, decimals(), arg3));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<WLP>>(0x2::coin_registry::finalize<WLP>(v0, arg3), 0x2::tx_context::sender(arg3));
        let WLP { id: v2 } = arg2;
        0x2::object::delete(v2);
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WLP{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WLP>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

