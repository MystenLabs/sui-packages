module 0x6f0ea0352d9e0c24a9109a184edff3a35160ee3f4c686c5817fb5eea77422860::suizzly {
    struct SUIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZLY>(arg0, 6, b"SUIZZLY", b"Suizzly bear", b"Dive into the sweetest corner of the SUI chain $SIZZLY the chubby bear on a mission for endless honey (gains)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qiwk35ge_400x400_2a6aa470d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

