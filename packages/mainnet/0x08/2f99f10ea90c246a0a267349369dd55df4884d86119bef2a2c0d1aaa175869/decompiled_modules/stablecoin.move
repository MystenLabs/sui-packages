module 0x82f99f10ea90c246a0a267349369dd55df4884d86119bef2a2c0d1aaa175869::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xce0ca45b2ed62ad74b50ce0d6bbf94dfb20b4eeca4d72977e8d3fc800502bd08::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

