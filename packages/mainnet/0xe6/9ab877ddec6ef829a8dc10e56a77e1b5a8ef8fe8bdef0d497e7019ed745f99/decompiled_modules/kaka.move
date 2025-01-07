module 0xe69ab877ddec6ef829a8dc10e56a77e1b5a8ef8fe8bdef0d497e7019ed745f99::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKA>(arg0, 9, b"KAKA", b"Kakashka", b"Kakashka token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/074613dd-1e13-42e0-9f29-b6a49e9c567b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

