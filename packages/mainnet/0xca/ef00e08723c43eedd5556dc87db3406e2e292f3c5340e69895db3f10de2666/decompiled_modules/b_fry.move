module 0xcaef00e08723c43eedd5556dc87db3406e2e292f3c5340e69895db3f10de2666::b_fry {
    struct B_FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FRY>(arg0, 9, b"bFRY", b"bToken FRY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

