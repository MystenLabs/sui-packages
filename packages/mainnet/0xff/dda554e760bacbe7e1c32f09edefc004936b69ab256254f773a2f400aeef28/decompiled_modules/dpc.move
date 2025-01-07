module 0xffdda554e760bacbe7e1c32f09edefc004936b69ab256254f773a2f400aeef28::dpc {
    struct DPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPC>(arg0, 6, b"DPC", b"Doge pharaoh", b"Stake your $PHARAOH tokens and earn rewards fit for a king. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736089767281.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

