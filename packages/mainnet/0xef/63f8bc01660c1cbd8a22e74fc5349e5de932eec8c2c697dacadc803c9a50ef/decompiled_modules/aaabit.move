module 0xef63f8bc01660c1cbd8a22e74fc5349e5de932eec8c2c697dacadc803c9a50ef::aaabit {
    struct AAABIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABIT>(arg0, 6, b"AAABIT", b"Rabbit", x"6a757374206120726162626974200a0a68747470733a2f2f742e6d652f6161617261626269740a0a68747470733a2f2f782e636f6d2f6161617261626269746f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_image_6_04fcaa0618.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

