module 0x41497fdb60d711e638dea7426cf3be31c52e49c92d75221b7c84972b9e7cf9cb::vbnnj {
    struct VBNNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VBNNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VBNNJ>(arg0, 9, b"VBNNJ", b"Ghjjj", b"Bnnkmk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/488ff0f7-4e14-4ea9-baeb-f19b01bc1462.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VBNNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VBNNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

