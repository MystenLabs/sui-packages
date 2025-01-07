module 0x54919b45fb26552550edaf709e456a02eec538d358e488f7f8274976ea030b5::ulas {
    struct ULAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULAS>(arg0, 6, b"ULAS", b"ULALA", b"Ulalala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730995789039.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ULAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

