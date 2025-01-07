module 0xff74db631d245736c7c90cdc7b50573dc18ef5fd2b04116d9b4d249815543e2b::vtus {
    struct VTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTUS>(arg0, 9, b"VTUS", b"Supertus", b"Vtus1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09df4314-9c88-41db-89c3-c576c53f8011.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

