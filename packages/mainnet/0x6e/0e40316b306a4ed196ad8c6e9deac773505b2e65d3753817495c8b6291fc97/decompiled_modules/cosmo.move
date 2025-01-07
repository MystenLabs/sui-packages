module 0x6e0e40316b306a4ed196ad8c6e9deac773505b2e65d3753817495c8b6291fc97::cosmo {
    struct COSMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMO>(arg0, 6, b"COSMO", b"Cosmocadia", b"The number 1 community-based memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957114458.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

