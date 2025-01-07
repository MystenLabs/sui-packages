module 0xe7a951979da1e2e5bb686ac8b75c3df6be4c951c26e8d7c2fef9087ded1bd089::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 6, b"CTA", b"CAT THEFT AUTO", x"576520676f7420435441206265666f72652047544136202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734081737748.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

