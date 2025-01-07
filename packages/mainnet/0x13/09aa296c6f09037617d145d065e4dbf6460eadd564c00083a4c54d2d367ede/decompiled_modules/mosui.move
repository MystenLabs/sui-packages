module 0x1309aa296c6f09037617d145d065e4dbf6460eadd564c00083a4c54d2d367ede::mosui {
    struct MOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSUI>(arg0, 6, b"MOSUI", b"MONALISUI", b"Mona lisui $MOSU. By Retardio Da Vinci", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958355418.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

