module 0x1db8f67d30cea8f8fc7b5258397db1fb377eb905f41f9c225b9820a7402eaee9::tface {
    struct TFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFACE>(arg0, 6, b"TFACE", b"TrollFace", b"Just a trollface who will never rug, trust me :3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949800469.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

