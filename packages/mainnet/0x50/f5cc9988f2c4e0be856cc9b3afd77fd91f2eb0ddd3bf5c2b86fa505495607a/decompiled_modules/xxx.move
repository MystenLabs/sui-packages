module 0x50f5cc9988f2c4e0be856cc9b3afd77fd91f2eb0ddd3bf5c2b86fa505495607a::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 9, b"XXX", b"Triple X", b"Do you like XXX movies?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1496696b-f528-4c3f-a42d-f86aa8fed5fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

