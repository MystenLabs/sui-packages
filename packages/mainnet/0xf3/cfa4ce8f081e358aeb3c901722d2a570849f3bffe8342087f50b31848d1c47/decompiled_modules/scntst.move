module 0xf3cfa4ce8f081e358aeb3c901722d2a570849f3bffe8342087f50b31848d1c47::scntst {
    struct SCNTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCNTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCNTST>(arg0, 9, b"SCNTST", b"Scientist", x"596f75206b6e6f772c2049e280996d20736f6d657468696e67206f66206120736369656e74697374206d7973656c6620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/685c55df-88f4-4f11-98af-106b7208d5fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCNTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCNTST>>(v1);
    }

    // decompiled from Move bytecode v6
}

