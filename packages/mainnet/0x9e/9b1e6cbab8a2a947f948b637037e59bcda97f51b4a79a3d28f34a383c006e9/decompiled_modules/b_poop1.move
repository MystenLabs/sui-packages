module 0x9e9b1e6cbab8a2a947f948b637037e59bcda97f51b4a79a3d28f34a383c006e9::b_poop1 {
    struct B_POOP1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POOP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POOP1>(arg0, 9, b"bPOOP1", b"bToken POOP1", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POOP1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POOP1>>(v1);
    }

    // decompiled from Move bytecode v6
}

