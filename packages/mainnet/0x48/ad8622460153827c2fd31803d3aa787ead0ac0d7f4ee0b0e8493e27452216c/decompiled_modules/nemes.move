module 0x48ad8622460153827c2fd31803d3aa787ead0ac0d7f4ee0b0e8493e27452216c::nemes {
    struct NEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMES>(arg0, 9, b"NEMES", b"Neme", b"Games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c226bf02-9396-49e9-9f0c-3a2294ccf4bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

