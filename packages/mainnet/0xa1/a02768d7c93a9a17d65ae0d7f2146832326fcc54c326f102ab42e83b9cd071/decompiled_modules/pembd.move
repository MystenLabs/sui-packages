module 0xa1a02768d7c93a9a17d65ae0d7f2146832326fcc54c326f102ab42e83b9cd071::pembd {
    struct PEMBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEMBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEMBD>(arg0, 9, b"PEMBD", b"hdje", b"hebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a252c498-2f21-423b-a19d-d8e323067120.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEMBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEMBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

