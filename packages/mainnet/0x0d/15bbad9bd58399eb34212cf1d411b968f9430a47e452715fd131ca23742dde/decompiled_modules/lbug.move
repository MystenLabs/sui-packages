module 0xd15bbad9bd58399eb34212cf1d411b968f9430a47e452715fd131ca23742dde::lbug {
    struct LBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBUG>(arg0, 9, b"LBUG", b"LANOCHIM", b"Let's make community together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a87f8ac-9c89-4d33-8a54-af6b275a317b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

