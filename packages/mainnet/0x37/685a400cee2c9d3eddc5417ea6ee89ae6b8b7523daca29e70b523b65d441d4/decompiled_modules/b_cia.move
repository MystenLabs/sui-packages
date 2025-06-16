module 0x37685a400cee2c9d3eddc5417ea6ee89ae6b8b7523daca29e70b523b65d441d4::b_cia {
    struct B_CIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CIA>(arg0, 9, b"bCIA", b"bToken CIA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

