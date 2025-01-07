module 0xa2ba70eb917f7a2481585488ed1248401b4200062ee3a2c1f9fa3043fd0ddae1::sci {
    struct SCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCI>(arg0, 6, b"SCI", b"SuiCatIce", b"Cat sluurrpp juicy ice cream in summer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008617_aa59d79c14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

