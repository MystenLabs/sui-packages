module 0x7c1947d77d7cf6ad2a0328e411affb0a65fd759c27f09fc3817a1e72346b047b::pdi {
    struct PDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDI>(arg0, 9, b"PDI", b"P. Diddy", b"Dear and good boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa911b96-924e-4980-9dc0-52977137c239.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

