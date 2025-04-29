module 0x125e8ff92b6a3da1d2ed2e1cba95ea80c66ba69cf52027df8e7b1b836a3a2462::b_zvz {
    struct B_ZVZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZVZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZVZ>(arg0, 9, b"bZVZ", b"bToken ZVZ", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZVZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZVZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

