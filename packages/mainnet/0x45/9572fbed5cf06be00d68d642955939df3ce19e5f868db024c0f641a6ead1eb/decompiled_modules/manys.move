module 0x459572fbed5cf06be00d68d642955939df3ce19e5f868db024c0f641a6ead1eb::manys {
    struct MANYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYS>(arg0, 9, b"MANYS", b"Many", b"More and many", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0307672-69d8-49bd-ac24-9eedf5b24f08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

