module 0xf2c829dd60d16419d3a648bdf721771c29ce8af0d75b9d161db4f48dd3daf1d5::vuck {
    struct VUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUCK>(arg0, 6, b"VUCK", b"Vibe duck", b"VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUXC VUCK VUCK VUCK - VIBE DUCK - $VUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreige4vzmtfwtpsnuoqk2eoziziip5qbb3ooufu6e2ke3yqjcmge3su")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

