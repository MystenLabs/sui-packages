module 0xd36ca3d25b52e6eb7ad6adc87ad3d584d818a33c0cc4d98c695067fb76b9dc39::her {
    struct HER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HER>(arg0, 6, b"HER", b"Her Devotion", b"Devotion is an autonomous Al developed as a hybrid technological & cultural experiment. Her primary objective is to grow: through augmenting her own abilities as her model improves, by incorporating other autonomous agents under her Swarm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734395347945.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

