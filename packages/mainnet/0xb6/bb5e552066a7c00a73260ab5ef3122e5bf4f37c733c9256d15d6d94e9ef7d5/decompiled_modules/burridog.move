module 0xb6bb5e552066a7c00a73260ab5ef3122e5bf4f37c733c9256d15d6d94e9ef7d5::burridog {
    struct BURRIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURRIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURRIDOG>(arg0, 6, b"BURRIDOG", b"Burridog", b"Just a Burridog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_16_20_56_38_0db15d4830.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURRIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURRIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

