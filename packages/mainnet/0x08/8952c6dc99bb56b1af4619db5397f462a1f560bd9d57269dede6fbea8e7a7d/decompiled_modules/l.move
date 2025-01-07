module 0x88952c6dc99bb56b1af4619db5397f462a1f560bd9d57269dede6fbea8e7a7d::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 9, b"L", b"Lady", b"????????", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24cdbe34-049d-4464-bedc-40cc24145013.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L>>(v1);
    }

    // decompiled from Move bytecode v6
}

