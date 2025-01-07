module 0x4811d51b6a8c6853442dea85af48747c5736724428f53341d086b54f8361376d::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 9, b"LONG", b"Long puppy", b"Longpuppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59831802-c513-4d2f-8363-bf8e102e45a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

