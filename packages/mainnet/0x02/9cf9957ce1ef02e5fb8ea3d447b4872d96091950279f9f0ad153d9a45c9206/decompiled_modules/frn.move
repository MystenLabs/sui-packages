module 0x29cf9957ce1ef02e5fb8ea3d447b4872d96091950279f9f0ad153d9a45c9206::frn {
    struct FRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRN>(arg0, 9, b"FRN", b"FRANCE", x"6369747920e2808be2808b6f66206c6f76657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01ac050a-a974-4522-8c8c-cee66b8fb0b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

