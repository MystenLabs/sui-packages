module 0x1f2218b02005c6a4cfd6673c7d9a7cd9f06594bac5bbec6f68d9c04e3fdba431::borodach {
    struct BORODACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORODACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORODACH>(arg0, 9, b"BORODACH", b"Boroda", b"Cooll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbf11b49-dcb9-4e4e-8b9a-bf057ca5820b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORODACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORODACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

