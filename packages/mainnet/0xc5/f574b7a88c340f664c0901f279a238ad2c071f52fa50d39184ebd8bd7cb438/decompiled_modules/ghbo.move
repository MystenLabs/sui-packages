module 0xc5f574b7a88c340f664c0901f279a238ad2c071f52fa50d39184ebd8bd7cb438::ghbo {
    struct GHBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHBO>(arg0, 6, b"GHBO", b"Grab Her by the OIL", b"Sometimes you just have to grab her by the oil when she does not listen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775247734130.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

