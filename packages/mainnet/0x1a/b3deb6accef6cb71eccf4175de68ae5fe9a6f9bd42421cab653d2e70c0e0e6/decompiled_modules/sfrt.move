module 0x1ab3deb6accef6cb71eccf4175de68ae5fe9a6f9bd42421cab653d2e70c0e0e6::sfrt {
    struct SFRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFRT>(arg0, 6, b"SFRT", b"SNEAKY FERRET", b"Quick, clever, and always on the move. Sneaky Ferret is stealing the spotlight in the meme world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_030439908_14b678e165.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

