module 0xd063270352062bf08ab850441da4aae39ea030f1172e0d518ec97e7f32c2d2e9::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 9, b"DOGGY", b"Doggy", b"69 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5462ef43-e4d0-434d-a8e8-9f59386c1fc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

