module 0xf68df3610596d5b29feb79463f09f534f70d4ab434d8e367398576cdebaa6f51::youwin {
    struct YOUWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUWIN>(arg0, 6, b"Youwin", b"iucant", b"gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732614240276.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUWIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUWIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

