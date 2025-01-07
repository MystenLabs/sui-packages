module 0x4ae4e4b2ac6c10ee082a81967af72121ae90e82fbd3faeb79d86e259b431dd9c::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 6, b"FRT", b"FART", b"Just a fart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732478433255.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

