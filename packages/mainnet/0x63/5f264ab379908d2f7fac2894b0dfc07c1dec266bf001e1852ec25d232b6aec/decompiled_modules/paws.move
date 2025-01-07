module 0x635f264ab379908d2f7fac2894b0dfc07c1dec266bf001e1852ec25d232b6aec::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 9, b"PAWS", b"$PAWS", b"Paws token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ef98bf0-32a8-4d45-ac16-a67b9350097d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

