module 0x32594906e51a89bfc9ff12de75d8999d126dd51c71f464574c72051938b198cb::ffh {
    struct FFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFH>(arg0, 9, b"FFH", b"GIU", b"Get Get Get ASAP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfb56a52-e125-4963-82af-061c960fc1b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

