module 0x5cd715ca0e2ae9f76132a90f1c7f8efb32805910387a9f42bae2b4d7c94d60a3::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"MEME", b"meme", b"A meme token combining humor and community spirit, offering fun and entertainment while harnessing the power of blockchain technology. Join the movement and be part of the meme revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/images_1_e9faf7a7bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

