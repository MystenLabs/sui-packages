module 0x10736a3d43d742e99efad7b14bd47318013044ff27824a45056be109b7dd5dbc::owksb {
    struct OWKSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWKSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWKSB>(arg0, 9, b"OWKSB", b"jejd", b"bsbsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4f64ab0-09ec-40fc-8fbe-8872759509f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWKSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWKSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

