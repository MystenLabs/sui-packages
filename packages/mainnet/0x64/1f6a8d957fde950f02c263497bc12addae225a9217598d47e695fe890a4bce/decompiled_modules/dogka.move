module 0x641f6a8d957fde950f02c263497bc12addae225a9217598d47e695fe890a4bce::dogka {
    struct DOGKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGKA>(arg0, 9, b"DOGKA", b"Kaka", b"Dogs kaka ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8570abae-a6c9-49f3-96a8-bc51bda687b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

