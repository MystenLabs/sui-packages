module 0xa826f9af20a182dbd4adb3feee24000a7f459b9a3d562a9f05882d42b9e13b4a::milksui {
    struct MILKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKSUI>(arg0, 6, b"MILKSUI", b"MilkyWay", b"Got Milk?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732382210237.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

