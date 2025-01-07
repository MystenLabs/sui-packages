module 0x2ab0484ef1a346ece1d19ac385ac585eaec829405ee8c0cb637fb0f9ff04cfb2::scarrot {
    struct SCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARROT>(arg0, 9, b"SCARROT", b"Scarrot.MM", b"Vegetable for healthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8a044a7-8fd1-4a07-801e-008b862fb8a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

