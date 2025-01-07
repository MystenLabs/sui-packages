module 0xc6c8d242d1612965860f2d8ec548ab4c8640109b44c8e9da6ac58e96b8ee709c::eternal {
    struct ETERNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETERNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETERNAL>(arg0, 9, b"ETERNAL", b"Eternal", x"56c4a96e682063e1bbad75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63e33e50-d211-4631-a63c-3412e15a6725.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETERNAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETERNAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

