module 0x9316f789f9d4c5b54e7426dbce9f61fbc6235c99941c2b39beff550513c64723::kb {
    struct KB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KB>(arg0, 9, b"KB", b"Kaiba", x"4b61696261206b69e1babf6d2073c4a9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35ca6434-76ed-429d-b8a7-8fe40fbf511b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KB>>(v1);
    }

    // decompiled from Move bytecode v6
}

