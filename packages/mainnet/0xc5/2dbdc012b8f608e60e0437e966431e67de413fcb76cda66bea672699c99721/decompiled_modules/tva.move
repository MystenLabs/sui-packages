module 0xc52dbdc012b8f608e60e0437e966431e67de413fcb76cda66bea672699c99721::tva {
    struct TVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVA>(arg0, 9, b"TVA", b"travel", b"For the joy of earning money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a9d8aa2-c5b7-4384-b276-1aeb2d2faaef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

