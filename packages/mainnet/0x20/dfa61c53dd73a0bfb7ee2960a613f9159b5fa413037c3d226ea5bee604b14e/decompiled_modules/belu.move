module 0x20dfa61c53dd73a0bfb7ee2960a613f9159b5fa413037c3d226ea5bee604b14e::belu {
    struct BELU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELU>(arg0, 6, b"BELU", b"Belugana", b"An innovative cryptocurrency project. Sui Project to Promote Belugana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1469_a2e2d60613.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELU>>(v1);
    }

    // decompiled from Move bytecode v6
}

