module 0x3b5b4132756ba570fe6eb1589ee04c8a14de1316f298c0f5440657005370a9ea::sepe {
    struct SEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPE>(arg0, 6, b"SEPE", b"SUI PEPE", b"LFG DYOR AND CHILL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NUMH_niz_400x400_2ba6484b83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

