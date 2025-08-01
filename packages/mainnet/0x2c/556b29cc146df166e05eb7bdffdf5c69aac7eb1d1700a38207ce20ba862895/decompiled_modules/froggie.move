module 0x2c556b29cc146df166e05eb7bdffdf5c69aac7eb1d1700a38207ce20ba862895::froggie {
    struct FROGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGIE>(arg0, 6, b"Froggie", b"froggie", b"Froggie moving", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754035180823.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

