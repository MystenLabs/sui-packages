module 0x6ba17b8f3de02247da9cd70b61dd9aa2b1bf21921841e556a1d9705bdd56a0c4::dv {
    struct DV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DV>(arg0, 9, b"DV", b"Davis", b"Davis Secrector", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15dd123e-8889-4343-bbde-35a5dee137bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DV>>(v1);
    }

    // decompiled from Move bytecode v6
}

