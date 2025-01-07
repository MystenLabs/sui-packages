module 0xfafb360aa6a9dd3baded09e420552da282c2a157f2527325d0eb907d762a27da::huule {
    struct HUULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUULE>(arg0, 9, b"HUULE", b"Huu2", b"Hu hu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52edff49-acdb-4b10-89a9-9af191318d0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUULE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUULE>>(v1);
    }

    // decompiled from Move bytecode v6
}

