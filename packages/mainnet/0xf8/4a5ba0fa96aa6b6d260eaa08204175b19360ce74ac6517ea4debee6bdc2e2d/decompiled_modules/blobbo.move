module 0xf84a5ba0fa96aa6b6d260eaa08204175b19360ce74ac6517ea4debee6bdc2e2d::blobbo {
    struct BLOBBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBBO>(arg0, 6, b"BLOBBO", b"SUIBLOBBO", b"A blob of chaos, a meme of hope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_044624766_d94f7075f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

