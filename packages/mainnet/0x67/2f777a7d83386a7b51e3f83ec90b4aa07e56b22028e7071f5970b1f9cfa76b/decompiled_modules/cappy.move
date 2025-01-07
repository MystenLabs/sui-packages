module 0x672f777a7d83386a7b51e3f83ec90b4aa07e56b22028e7071f5970b1f9cfa76b::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"Sui Cappy", b"Chill with $CAPPY , be Cappy at the creek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cappy_c3b933ee57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

