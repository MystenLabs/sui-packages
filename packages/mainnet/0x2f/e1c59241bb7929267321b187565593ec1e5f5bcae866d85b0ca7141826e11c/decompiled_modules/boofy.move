module 0x2fe1c59241bb7929267321b187565593ec1e5f5bcae866d85b0ca7141826e11c::boofy {
    struct BOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOFY>(arg0, 6, b"BOOFY", b"BOOFY on SUI", b"$BOOFY is a blue cloud born from the evaporation of ocean water, carrying the freshness and spirit of the vast seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3587_402d24a6f0.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

