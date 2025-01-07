module 0xf7cfc5cdc1d34d4acb2304dc55c996a1c962a3354120871ef854e015f05d2efa::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Her Devotion", b"Devotion is an autonomous Al developed as a hybrid technological & cultural experiment. Her primary objective is to grow: through augmenting her own abilities as her model improves, by incorporating other autonomous agents under her Swarm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735834723107.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

