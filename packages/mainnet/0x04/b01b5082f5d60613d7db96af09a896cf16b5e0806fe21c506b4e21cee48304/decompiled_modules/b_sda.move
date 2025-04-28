module 0x4b01b5082f5d60613d7db96af09a896cf16b5e0806fe21c506b4e21cee48304::b_sda {
    struct B_SDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SDA>(arg0, 9, b"bSDA", b"bToken SDA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

