module 0x381bd74749ccc1290e448dd5514f83716b330cba3481029fbacb00078f06a5::wlp {
    struct WLP has key {
        id: 0x2::object::UID,
    }

    public fun create_wlp_pool(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg2: WLP, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<WLP>(arg0, decimals(), 0x1::string::utf8(b"WLP"), 0x1::string::utf8(b"WaterX LP Token"), 0x1::string::utf8(b"Liquidity Provider token for WaterX Perp DEX"), 0x1::string::utf8(b"https://token-metadata.bridge.xyz/images/usd_sui.png"), arg3);
        0x2::transfer::public_share_object<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::lp_pool::WlpPool<WLP>>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::lp_pool::create_pool<WLP>(arg1, v1, decimals(), arg3));
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

