module 0xf49c868d0e864a5deac7d0cefe1db5441e2b104e9466919821579546387d5d21::suz {
    struct SUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZ>(arg0, 6, b"SUZ", b"SUZUKI", b"More than just a memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_007b88d8a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

