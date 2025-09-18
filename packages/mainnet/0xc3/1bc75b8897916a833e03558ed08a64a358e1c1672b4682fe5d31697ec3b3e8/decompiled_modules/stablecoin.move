module 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::upgrade_service::new<STABLECOIN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0xc31bc75b8897916a833e03558ed08a64a358e1c1672b4682fe5d31697ec3b3e8::upgrade_service::UpgradeService<STABLECOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

