module 0x73624454ef9c85909cc97195dd9f2ffda046f41278375102213753ac1857f6cb::sri {
    struct SRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRI>(arg0, 6, b"SRI", b"Samurai", b"$SRI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/samurai_253c9d2ffb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

