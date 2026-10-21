module 0x8d96405faebefb3cb3b89040aefe13e5a0f4fd473efd6d269466cafa21003161::parchment {
    struct PARCHMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHMENT>(arg0, 9, b"PARCHMENT", b"PARCHMENT", b"Freely transferable. Not collateral.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARCHMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun install_treasury<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<PARCHMENT>) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::install_reward_cap<T0, PARCHMENT>(arg0, arg1, arg2, arg3);
    }

    public fun supply<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>) : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::reward_supply<T0, PARCHMENT>(arg0)
    }

    // decompiled from Move bytecode v7
}

