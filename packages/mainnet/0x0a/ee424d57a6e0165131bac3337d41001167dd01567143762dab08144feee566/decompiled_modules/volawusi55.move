module 0xaee424d57a6e0165131bac3337d41001167dd01567143762dab08144feee566::volawusi55 {
    struct VOLAWUSI55 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLAWUSI55, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLAWUSI55>(arg0, 9, b"VOLAWUSI55", b"$MEMEV", b"Make money ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf63755c-8505-4618-85f3-5c912e807612.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLAWUSI55>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLAWUSI55>>(v1);
    }

    // decompiled from Move bytecode v6
}

