module 0xb67cf2917172facd41704783a9aa0f771c7edd0fae96b6893907423a86d149d9::chon {
    struct CHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHON>(arg0, 6, b"CHON", b"Sui chon", b"Sui chon - Give rice to Suichon who lives in Sui's water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1343_9b3a5ffae6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHON>>(v1);
    }

    // decompiled from Move bytecode v6
}

