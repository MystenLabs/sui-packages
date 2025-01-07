module 0x9d839d5735cbdcc051473e7b55748749daf9c29f496d4f9acd7c1ba6b20ee8ed::tothemoon {
    struct TOTHEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTHEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTHEMOON>(arg0, 9, b"TOTHEMOON", b"MOONSUI", b"SUI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a444c9a4-d02d-4479-9564-ea984d3d78ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTHEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOTHEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

