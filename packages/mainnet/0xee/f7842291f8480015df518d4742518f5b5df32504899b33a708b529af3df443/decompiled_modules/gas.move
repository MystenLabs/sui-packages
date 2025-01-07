module 0xeef7842291f8480015df518d4742518f5b5df32504899b33a708b529af3df443::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 9, b"GAS", b"Gasken", b"Gas aja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98d4a73a-adfc-4eb3-a435-86e8e1879f5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

