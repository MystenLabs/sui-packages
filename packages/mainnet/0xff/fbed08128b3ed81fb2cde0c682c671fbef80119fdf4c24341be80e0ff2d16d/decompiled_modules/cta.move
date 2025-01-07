module 0xfffbed08128b3ed81fb2cde0c682c671fbef80119fdf4c24341be80e0ff2d16d::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 6, b"CTA", b"CAT THEFT AUTO", b"We got CTA before GTA6 .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733755588706.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

