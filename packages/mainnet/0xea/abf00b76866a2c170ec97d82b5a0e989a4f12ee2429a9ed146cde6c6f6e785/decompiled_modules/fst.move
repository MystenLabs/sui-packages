module 0xeaabf00b76866a2c170ec97d82b5a0e989a4f12ee2429a9ed146cde6c6f6e785::fst {
    struct FST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FST>(arg0, 9, b"FST", b"forest", b"GREAN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/391b14b0-9a77-48ef-9898-2285f1a2925d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FST>>(v1);
    }

    // decompiled from Move bytecode v6
}

