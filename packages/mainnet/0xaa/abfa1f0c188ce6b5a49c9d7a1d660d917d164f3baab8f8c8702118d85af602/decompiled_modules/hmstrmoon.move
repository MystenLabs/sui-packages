module 0xaaabfa1f0c188ce6b5a49c9d7a1d660d917d164f3baab8f8c8702118d85af602::hmstrmoon {
    struct HMSTRMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTRMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTRMOON>(arg0, 9, b"HMSTRMOON", b"Hmstr Moon", b"Hamster Kombat to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63ac4d3e-9910-4b9a-9bc9-020bd162d3f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTRMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMSTRMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

