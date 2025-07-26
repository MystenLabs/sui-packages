module 0xf3b445e249c7b44c6372a2b5832bf5d9a4140b01ddd82163db861abd02e546ee::mikura {
    struct MIKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKURA>(arg0, 6, b"Mikura", b"Mikura AI", b"Mikura is a vibrant AI humanoid who combines her love for music with a deep passion for the Sui Blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig44mofqegvhqgovk5sl5opebg6f7jofms33xm5oewhbmzgewf3oa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

