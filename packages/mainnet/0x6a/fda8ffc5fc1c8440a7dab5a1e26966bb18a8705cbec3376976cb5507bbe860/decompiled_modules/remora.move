module 0x6afda8ffc5fc1c8440a7dab5a1e26966bb18a8705cbec3376976cb5507bbe860::remora {
    struct REMORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMORA>(arg0, 6, b"REMORA", b"Slick Remora", b"This venture doth promise a bounteous return!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_1_e7dbd71c77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

