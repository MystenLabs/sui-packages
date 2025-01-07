module 0x30ff9e778905c97c3b958479214e5006813a9650d0af570fb2d0ccabaa512996::drops {
    struct DROPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPS>(arg0, 6, b"DROPS", b"SuiDrop", b"SuiDrop. The purest drops harvested from leftist tears following Trump election win ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959127461.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

