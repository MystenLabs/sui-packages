module 0x766f99be19b6d43c974e23c2d62af3aa83f708319a6abbdc56177c72d0248ed4::yowie {
    struct YOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOWIE>(arg0, 6, b"YOWIE", b"Yowie", b"Icy but hot, its Yowie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_854ac0819b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

