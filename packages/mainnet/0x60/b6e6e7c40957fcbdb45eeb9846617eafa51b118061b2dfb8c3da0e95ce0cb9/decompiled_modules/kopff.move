module 0x60b6e6e7c40957fcbdb45eeb9846617eafa51b118061b2dfb8c3da0e95ce0cb9::kopff {
    struct KOPFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOPFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOPFF>(arg0, 6, b"KOPFF", b"KOPF", x"4b4f5046204f4e205355c4b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984980020.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOPFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOPFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

