module 0xe4de296583be4f91bb240f16c215d5fdb0932da083e5715485ca99b4e8cd92e7::bapesui {
    struct BAPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPESUI>(arg0, 6, b"BAPESUI", b"BRAZILIAN APE", b"BRAZILIAN APE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995382430.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAPESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

