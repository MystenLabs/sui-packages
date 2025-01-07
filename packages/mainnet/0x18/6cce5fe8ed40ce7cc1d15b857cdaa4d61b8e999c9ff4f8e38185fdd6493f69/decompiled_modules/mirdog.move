module 0x186cce5fe8ed40ce7cc1d15b857cdaa4d61b8e999c9ff4f8e38185fdd6493f69::mirdog {
    struct MIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRDOG>(arg0, 9, b"MIRDOG", b"Mir", b"the future is coming soon, let's get ready to conquer new heights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06d22531-8fae-456b-8d7b-941f602bc817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

