module 0x2e7d809630f3d9ca59f6eef76df8bbc7e7b705e02526abfd701e3deb26ca9f3a::suilati {
    struct SUILATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILATI>(arg0, 6, b"SUILATI", b"Suilati Pokemon", b"Legendary dragon pokemon couple will make sui great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmjc7gjbqmcuw7qa3hxs6q3e73fpy5refbbverg7badyfgvaqzay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILATI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

