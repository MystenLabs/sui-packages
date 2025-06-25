module 0xf8b94583143c708146fa1548b77c3db5bb4292164acbfbd926cfe02457a1e9f4::lit {
    struct LIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIT>(arg0, 6, b"LIT", b"Line it up", b"LIT Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750842481947.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

