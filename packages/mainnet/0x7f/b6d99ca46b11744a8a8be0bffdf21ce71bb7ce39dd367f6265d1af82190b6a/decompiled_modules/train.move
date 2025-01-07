module 0x7fb6d99ca46b11744a8a8be0bffdf21ce71bb7ce39dd367f6265d1af82190b6a::train {
    struct TRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIN>(arg0, 6, b"Train", b"SuiTrain", b"Nothing stops this train", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730501115880.05")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

