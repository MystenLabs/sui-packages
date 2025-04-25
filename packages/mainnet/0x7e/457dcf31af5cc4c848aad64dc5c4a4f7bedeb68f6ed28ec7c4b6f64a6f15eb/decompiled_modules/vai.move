module 0x7e457dcf31af5cc4c848aad64dc5c4a4f7bedeb68f6ed28ec7c4b6f64a6f15eb::vai {
    struct VAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAI>(arg0, 6, b"VAI", b"VUNDIO AI", b"Vundio is an AI powered NFT generator, integrated with #SUI NET. Sleek design and user friendly features make the experience enjoyable and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_22_41_00_0c7f6e7920.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

