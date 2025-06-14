module 0xe7c261c55556501357521b2c1380d9688393ce85372df91b099544198f216c64::b_sab {
    struct B_SAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SAB>(arg0, 9, b"bSAB", b"bToken SAB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

