module 0xdb77354fe02a20ea2d90b08b6226302c5fab271d3e411f787a6a4fd41ad6d6a5::b_crsh {
    struct B_CRSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CRSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CRSH>(arg0, 9, b"bCRSH", b"bToken CRSH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CRSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CRSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

