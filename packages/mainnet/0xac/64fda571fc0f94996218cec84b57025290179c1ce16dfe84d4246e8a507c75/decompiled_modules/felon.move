module 0xac64fda571fc0f94996218cec84b57025290179c1ce16dfe84d4246e8a507c75::felon {
    struct FELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELON>(arg0, 6, b"FELON", b"FElon", b"Felon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732488798365.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

