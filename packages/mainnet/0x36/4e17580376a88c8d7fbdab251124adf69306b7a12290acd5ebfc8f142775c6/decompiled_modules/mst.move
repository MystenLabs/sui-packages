module 0x364e17580376a88c8d7fbdab251124adf69306b7a12290acd5ebfc8f142775c6::mst {
    struct MST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MST>(arg0, 9, b"MST", b"MIST", b"MIST for yu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53892d2c-0b7a-4b8c-93c4-1b2727dd480e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MST>>(v1);
    }

    // decompiled from Move bytecode v6
}

