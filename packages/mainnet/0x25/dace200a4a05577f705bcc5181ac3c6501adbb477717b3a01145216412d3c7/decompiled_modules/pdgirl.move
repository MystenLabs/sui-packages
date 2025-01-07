module 0x25dace200a4a05577f705bcc5181ac3c6501adbb477717b3a01145216412d3c7::pdgirl {
    struct PDGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDGIRL>(arg0, 9, b"PDGIRL", b"PD Girl", b"The girl who was seeded from the sale.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1e16e14-8126-4057-a672-e8f1f9b35b45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

