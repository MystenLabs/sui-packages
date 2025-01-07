module 0x5915d9697fd76e6cd8746a81052da2313d3051ec7b689f82ba6d400d4a5ea123::tlvc {
    struct TLVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLVC>(arg0, 9, b"TLVC", b"TLV", b"GHJKL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ee21a9c-3d9e-4444-85e8-dc4c0c0cd7aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

