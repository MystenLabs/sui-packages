module 0xa5a3947c927c47463402905523b368c2c42d7dc7352ec3a415d9832ca0f1044a::omgc {
    struct OMGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGC>(arg0, 9, b"OMGC", b"OIMAIGOT", b"oivaicalon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96274e39-6c39-4f50-9663-a0514bcf2cd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

