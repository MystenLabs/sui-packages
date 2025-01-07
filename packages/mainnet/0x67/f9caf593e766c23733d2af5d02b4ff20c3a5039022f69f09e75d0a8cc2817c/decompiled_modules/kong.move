module 0x67f9caf593e766c23733d2af5d02b4ff20c3a5039022f69f09e75d0a8cc2817c::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 6, b"KONG", b"ANGRY KONG", b"$KONG for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961758439.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

