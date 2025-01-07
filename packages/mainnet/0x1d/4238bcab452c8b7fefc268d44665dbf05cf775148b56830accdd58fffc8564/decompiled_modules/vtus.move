module 0x1d4238bcab452c8b7fefc268d44665dbf05cf775148b56830accdd58fffc8564::vtus {
    struct VTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTUS>(arg0, 9, b"VTUS", b"Vaetus", b"Good vtus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70220f6d-f384-4c77-96cb-189e5fc8b537.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

