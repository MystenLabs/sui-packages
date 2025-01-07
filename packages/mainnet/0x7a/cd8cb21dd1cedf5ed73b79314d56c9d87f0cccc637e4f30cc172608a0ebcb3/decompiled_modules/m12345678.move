module 0x7acd8cb21dd1cedf5ed73b79314d56c9d87f0cccc637e4f30cc172608a0ebcb3::m12345678 {
    struct M12345678 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M12345678, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M12345678>(arg0, 9, b"M12345678", b"MANGO ", b"Mango token is a good token buy and pump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8a348fb-c6d6-4517-bc34-0e0e7002333b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M12345678>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M12345678>>(v1);
    }

    // decompiled from Move bytecode v6
}

