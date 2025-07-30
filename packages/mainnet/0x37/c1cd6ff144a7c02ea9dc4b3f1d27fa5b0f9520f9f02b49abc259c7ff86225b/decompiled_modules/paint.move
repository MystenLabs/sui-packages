module 0x37c1cd6ff144a7c02ea9dc4b3f1d27fa5b0f9520f9f02b49abc259c7ff86225b::paint {
    struct PAINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAINT>(arg0, 6, b"PAINT", b"SuiPlay", b"Create, collaborate, and earn in Sui's digital canvas! COMING SOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxqaqqc6wc6ypdd7lv4s3tq5lwnmzpwwehgpaodm4nanme4tdnim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAINT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

