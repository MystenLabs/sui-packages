module 0xb63039c4a238afea3affd1db6ab8f5031b04a920a4c83f791e00cd1b22ba373b::kostasgrlondon {
    struct KOSTASGRLONDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOSTASGRLONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KOSTASGRLONDON>(arg0, 6, b"KOSTASGRLONDON", b"Kostas", b"WEB3 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/london_88237c0550.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOSTASGRLONDON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOSTASGRLONDON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

