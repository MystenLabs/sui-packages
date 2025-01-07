module 0x8913aa642b0b69b0847fe2fd50ec3d457e25ab26abadbac08d02750c079e507d::dogka {
    struct DOGKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGKA>(arg0, 9, b"DOGKA", b"Kaka", b"Dogs kaka ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dea9f21a-b9c7-48e7-a84f-5748d9aa5a5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

