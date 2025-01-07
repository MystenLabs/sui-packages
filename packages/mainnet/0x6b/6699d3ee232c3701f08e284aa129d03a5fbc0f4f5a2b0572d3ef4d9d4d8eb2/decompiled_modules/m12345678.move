module 0x6b6699d3ee232c3701f08e284aa129d03a5fbc0f4f5a2b0572d3ef4d9d4d8eb2::m12345678 {
    struct M12345678 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M12345678, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M12345678>(arg0, 9, b"M12345678", b"MANGO ", b"Mango token is a good token buy and pump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7f37a5e-51dc-4c85-bc5f-f0bd4cc432ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M12345678>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M12345678>>(v1);
    }

    // decompiled from Move bytecode v6
}

