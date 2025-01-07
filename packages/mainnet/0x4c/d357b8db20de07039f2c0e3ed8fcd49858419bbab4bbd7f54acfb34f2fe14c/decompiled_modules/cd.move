module 0x4cd357b8db20de07039f2c0e3ed8fcd49858419bbab4bbd7f54acfb34f2fe14c::cd {
    struct CD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CD>(arg0, 9, b"CD", b"Cadic", b"CADIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/741d52b2-1cc2-461a-9c54-00d6bce0db11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CD>>(v1);
    }

    // decompiled from Move bytecode v6
}

