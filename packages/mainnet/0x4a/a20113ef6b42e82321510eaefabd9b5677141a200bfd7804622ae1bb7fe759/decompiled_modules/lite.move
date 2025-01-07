module 0x4aa20113ef6b42e82321510eaefabd9b5677141a200bfd7804622ae1bb7fe759::lite {
    struct LITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITE>(arg0, 9, b"LITE", b"LTC", b"Lite coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efe28422-7e25-428f-ae87-97cc0c7f4da8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

