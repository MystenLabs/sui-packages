module 0x31f41e8ad3bb81fa57c6b948d45adba9acd60ae888e743611c9d2d8e4c8792ec::fartm {
    struct FARTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTM>(arg0, 6, b"FARTM", b"Fart Museum SUI", b" Welcome to the Fart Museum, the first cryptocurrency that celebrates the art, history, and science of... breaking wind! ,$FARTM is a unique token designed to bring a playful and educational twist to the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250129_012932_596_5d19da04d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

